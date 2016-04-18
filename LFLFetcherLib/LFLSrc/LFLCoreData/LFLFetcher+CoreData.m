//
//  LFLFetcher+CoreData.m
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/12.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLFetcher+CoreData.h"
#import "LFLFetcherManager.h"
#import <objc/runtime.h>
#import "NSManagedObject+LFLExtend.h"

static const void *fetcherDictionaryKey = &fetcherDictionaryKey;

@implementation LFLFetcher (CoreData)

- (NSDictionary *)fetchers {
    NSMutableDictionary *fetcher = objc_getAssociatedObject(self, fetcherDictionaryKey);
    if (!fetcher) {
        objc_setAssociatedObject(self, fetcherDictionaryKey, fetcher, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return fetcher;
}

- (NSFetchedResultsController *)fetcherWith:(Class)objectsClass
                                   sortedBy:(NSString *)sortTerm
                                  ascending:(BOOL)ascending
                              withPredicate:(NSPredicate *)predicate
                                    groupBy:(NSString *)groupKeyPath
                                     offset:(NSInteger)offset {
    NSString *key = [NSString stringWithFormat:@"%@_%@",NSStringFromClass(objectsClass),@(offset)];
    NSFetchedResultsController *fetcher = self.fetchers[key];
    if (!fetcher) {
        LFLFetcherManager *manager = [LFLFetcherManager shareInstance];
        fetcher = [objectsClass LFL_fetcherAllGroupedBy:groupKeyPath
                                          withPredicate:predicate
                                               sortedBy:sortTerm
                                              ascending:ascending
                                                 offset:offset
                                               delegate:self
                                              inContext:manager.context];
        NSMutableDictionary *fetchers = objc_getAssociatedObject(self, fetcherDictionaryKey);
        if (!fetchers) {
            fetchers = [[NSMutableDictionary alloc] init];
            objc_setAssociatedObject(self, fetcherDictionaryKey, fetchers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        } else {
            [fetchers removeAllObjects];
        }
        fetchers[key] = fetcher;
    }
    return fetcher;
}

- (NSFetchedResultsController *)fetcherWith:(Class)objectClass
                                   sortedBy:(NSString *)sortTerm
                                  ascending:(BOOL)ascending
                              withPredicate:(NSPredicate *)predicate
                                    groupBy:(NSString *)groupingKeyPath {
    NSString *key = NSStringFromClass([objectClass class]);
    NSFetchedResultsController *fetcher = self.fetchers[key];
    if (!fetcher) {
        LFLFetcherManager *manamger = [LFLFetcherManager shareInstance];
        fetcher = [objectClass MR_fetchAllSortedBy:sortTerm
                                         ascending:ascending
                                     withPredicate:predicate
                                           groupBy:groupingKeyPath
                                          delegate:self
                                         inContext:manamger.context];
        NSMutableDictionary *fetchers = objc_getAssociatedObject(self, fetcherDictionaryKey);
        if (!fetchers) {
            fetchers = [[NSMutableDictionary alloc] init];
            objc_setAssociatedObject(self, fetcherDictionaryKey, fetchers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        } else {
            [fetchers removeAllObjects];
        }
        fetchers[key] = key;
    }
    return fetcher;
}

- (void)invalidFetcherWith:(Class)objectClass {
    NSString *key = NSStringFromClass(objectClass);
    NSMutableDictionary *fetchers = objc_getAssociatedObject(self, fetcherDictionaryKey);
    [fetchers removeObjectForKey:key];
}

- (void)resetAllFetcher {
    NSMutableDictionary *fetchers = objc_getAssociatedObject(self, fetcherDictionaryKey);
    [fetchers removeAllObjects];
}

- (void)turnedAllObjectIntoFault {
    [self.fetchers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSFetchedResultsController *fetcher = (NSFetchedResultsController *)obj;
        NSInteger numberOfSections = [[fetcher sections] count];
        for (int i = 0; i<numberOfSections; i++) {
            NSArray *objects = [[[fetcher sections] objectAtIndex:i] objects];
            for (NSManagedObject *obj in objects) {
                [fetcher.managedObjectContext refreshObject:obj mergeChanges:NO];
            }
        }
    }];
}

+ (void)deleteAllObjectWithEntityClass:(Class)entityClass completion:(void(^)(void))completion {
    LFLFetcherManager *manager = [LFLFetcherManager shareInstance];
    NSPersistentStoreCoordinator *coordinator = manager.coordinator;
    NSManagedObjectContext *privateContext = [NSManagedObjectContext MR_contextWithStoreCoordinator:coordinator];
    __weak NSManagedObjectContext *mainContext = [manager context];
    
    [mainContext performBlockAndWait:^{
        [mainContext MR_observeContextOnMainThread:privateContext];
    }];
    
    [privateContext performBlock:^{
        NSArray *fetchedObjects = [entityClass MR_findAllInContext:privateContext];
        [fetchedObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj) {
                [privateContext deleteObject:obj];
            }
        }];
        [privateContext MR_saveToPersistentStoreAndWait];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
           [mainContext performBlockAndWait:^{
               [mainContext MR_stopObservingContext:privateContext];
           }];
            if (completion) {
                completion();
            }
        });
    }];
}

+ (NSManagedObject *)addObject:(Class)objectClass withPropertys:(NSDictionary*)propertys {
    LFLFetcherManager *manager = [LFLFetcherManager shareInstance];
    NSPersistentStoreCoordinator *coordinator = [manager coordinator];
    __weak NSManagedObjectContext *mainContext = [manager context];
    NSManagedObjectContext *privateContext = [NSManagedObjectContext MR_contextWithStoreCoordinator:coordinator];
    
    [mainContext performBlockAndWait:^{
        [mainContext MR_observeContextOnMainThread:privateContext];
    }];
    
    __block NSManagedObject *newObject = nil;
    [privateContext performBlockAndWait:^{
        debugAssert([NSThread isMainThread]);
        newObject = [objectClass MR_createEntityInContext:privateContext];
        if (newObject) {
            [propertys enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [newObject setValue:obj forKey:key];
            }];
            [privateContext MR_saveToPersistentStoreAndWait];
        }
        [mainContext MR_stopObservingContext:privateContext];
    }];
    NSManagedObject *newObjectInMainCtx = [mainContext objectWithID:newObject.objectID];
    debugAssert(newObjectInMainCtx);
    return newObjectInMainCtx;
}

+ (BOOL)deleteObjectWithPredicate:(NSPredicate *)predicate entityClass:(Class)entityClass {
    LFLFetcherManager *manager = [LFLFetcherManager shareInstance];
    NSPersistentStoreCoordinator *coordinator = [manager coordinator];
    __weak NSManagedObjectContext *mainContext = [manager context];
    NSManagedObjectContext *privateContext = [NSManagedObjectContext MR_contextWithStoreCoordinator:coordinator];
    
    [mainContext performBlockAndWait:^{
        [mainContext MR_observeContextOnMainThread:privateContext];
    }];
    __block BOOL success = NO;
    __block NSArray *objects = nil;
    [privateContext performBlockAndWait:^{
        debugAssert([NSThread isMainThread]);
        objects = [entityClass MR_findAllWithPredicate:predicate];
        [objects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj) {
                [privateContext deleteObject:obj];
                success = YES;
            }
        }];
        if (objects.count>0) {
            [privateContext MR_saveToPersistentStoreAndWait];
        }
        [mainContext performBlockAndWait:^{
            [mainContext MR_stopObservingContext:privateContext];
        }];
    }];
    success = objects.count > 0;
    return success;
}

+ (void)deleteObjects:(NSArray *)objects {
    if (objects.count) {
        NSManagedObjectContext *context = [[LFLFetcherManager shareInstance] context];
        [objects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSManagedObject *object = (NSManagedObject *)obj;
            [object MR_deleteEntityInContext:context];
            [context MR_saveToPersistentStoreAndWait];
        }];
    }
}

+ (BOOL)updateObjectPropertyWith:(NSManagedObject*)obj {
    if (!obj) {
        return NO;
    }
    LFLFetcherManager *manager = [LFLFetcherManager shareInstance];
    NSPersistentStoreCoordinator *coordinator = [manager coordinator];
    NSManagedObjectContext *privateContext = [NSManagedObjectContext MR_contextWithStoreCoordinator:coordinator];
    __weak NSManagedObjectContext *mainContext = [manager context];
    [mainContext performBlockAndWait:^{
        [mainContext MR_observeContextOnMainThread:privateContext];
    }];
    
    __block BOOL success = NO;
    [privateContext performBlockAndWait:^{
        debugAssert([NSThread isMainThread]);
        debugAssert([obj isKindOfClass:[NSManagedObject class]]);
        NSManagedObject *oldObj = [privateContext objectWithID:obj.objectID];
        if (oldObj) {
            if (oldObj != obj) {
                [obj copyPropertysTo:oldObj];
            }
            if ([privateContext hasChanges]) {
                [privateContext MR_saveToPersistentStoreAndWait];
                success = YES;
            }
        }
        [mainContext performBlockAndWait:^{
            [mainContext MR_stopObservingContext:privateContext];
        }];
    }];
    return success;
}

+ (BOOL)updateObjectsPropertyWith:(NSArray *)objs {
    if (objs.count == 0) {
        return NO;
    }
    LFLFetcherManager *manager = [LFLFetcherManager shareInstance];
    __weak NSManagedObjectContext *mainContext = [manager context];
    NSPersistentStoreCoordinator *coordinator = [manager coordinator];
    NSManagedObjectContext *privateContext = [NSManagedObjectContext MR_contextWithStoreCoordinator:coordinator];
    
    [mainContext performBlockAndWait:^{
        [mainContext MR_observeContextOnMainThread:privateContext];
    }];
    
    __block BOOL success = NO;
    [privateContext performBlockAndWait:^{
        debugAssert([NSThread isMainThread]);
        BOOL hasChange = NO;
        for (NSManagedObject *obj in objs) {
            debugAssert([obj isKindOfClass:[NSManagedObject class]]);
            NSManagedObject *oldObject = [privateContext objectWithID:obj.objectID];
            if (oldObject && oldObject != obj) {
                if ([obj copyPropertysTo:oldObject]) {
                    hasChange = YES;
                }
            }
        }
        if (hasChange && [privateContext hasChanges]) {
            [privateContext MR_saveToPersistentStoreAndWait];
            success = YES;
        }
        
        [mainContext performBlockAndWait:^{
            [mainContext MR_stopObservingContext:privateContext];
        }];
    }];
    return success;
}

+ (NSNumber*)maxIndexObject:(NSString*)maxIndexKey entityClass:(Class)entityClass {
    LFLFetcherManager *manager = [LFLFetcherManager shareInstance];
    NSNumber *number = [entityClass MR_aggregateOperation:@"max:" onAttribute:maxIndexKey withPredicate:nil inContext:[manager context]];
    if (number) {
        return number;
    }
    return @0;
}

+ (id)largestValueForAttribute:(NSString *)attribute ascending:(BOOL)ascending entityClass:(Class)entityClass {
    LFLFetcherManager *manager = [LFLFetcherManager shareInstance];
    id obj = [entityClass MR_findFirstOrderedByAttribute:attribute ascending:ascending inContext:[manager context]];
    return obj;
}

+ (NSArray *)fetchObjectsWithPredicate:(NSPredicate *)predicate entityClass:(Class)entityClass {
    LFLFetcherManager *manager = [LFLFetcherManager shareInstance];
    NSArray *fetcherObjects = [entityClass MR_findAllWithPredicate:predicate inContext:[manager context]];
    return fetcherObjects;
}

+ (NSArray *)fetchObjectsSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)searchTerm entityClass:(Class)entityClass withLimit:(NSInteger)limit{
    LFLFetcherManager *manager = [LFLFetcherManager shareInstance];
    NSArray *fetcherObjects = [entityClass LFL_findAllSortedBy:sortTerm
                                                         ascending:ascending
                                                     withPredicate:searchTerm
                                                         inContext:[manager context]
                                                         withLimit:limit];
    return fetcherObjects;
}

+ (id)firstObjectWithPredicate:(NSPredicate*)predicate sortedBy:(NSString *)propert entityClass:(Class)entityClass {
    LFLFetcherManager *manager = [LFLFetcherManager shareInstance];
    id fetchedObject = [entityClass MR_findFirstWithPredicate:predicate sortedBy:propert ascending:NO inContext:[manager context]];
    return fetchedObject;
}
@end
