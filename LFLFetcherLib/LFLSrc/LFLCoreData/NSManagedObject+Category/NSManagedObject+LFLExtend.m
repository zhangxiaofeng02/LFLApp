//
//  NSManagedObject+LFLExtend.m
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/12.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "NSManagedObject+LFLExtend.h"
#import <objc/runtime.h>

@implementation NSManagedObject (LFLExtend)

+ (NSInteger)LFL_numberOfEntitiesWithContext:(NSManagedObjectContext *)context {
    return [[self.class MR_numberOfEntitiesWithContext:context] integerValue];
}

+ (NSInteger)LFL_numberOfEntitiesWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    return [[self.class MR_numberOfEntitiesWithPredicate:predicate inContext:context] integerValue];
}

+ (NSFetchedResultsController *)LFL_fetcherAllGroupedBy:(NSString *)group
                                          withPredicate:(NSPredicate *)predicate
                                               sortedBy:(NSString *)sorte
                                              ascending:(BOOL)ascending
                                                 offset:(NSInteger)offset
                                               delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                              inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [self MR_requestAllSortedBy:sorte ascending:ascending withPredicate:predicate];
    request.fetchOffset = offset;
    NSFetchedResultsController *controller = [self MR_fetchController:request delegate:delegate useFileCache:NO groupedBy:group inContext:context];
    return controller;
}

+ (NSArray *)LFL_findAllSortedBy:(NSString *)sort
                       ascending:(BOOL)ascending
                   withPredicate:(NSPredicate *)predicate
                       inContext:(NSManagedObjectContext *)context
                       withLimit:(NSInteger)limit {
    NSFetchRequest *request = [self MR_requestAllSortedBy:sort ascending:ascending withPredicate:predicate];
    request.fetchLimit = limit;
    return [self MR_executeFetchRequest:request inContext:context];
}

+ (NSMutableArray *)copyPropertysName:(NSManagedObject *)object {
    NSMutableArray *allPropertys = [NSMutableArray new];
    NSString *moName = [object.entity name];
    Class class = NSClassFromString(moName);
    while (![NSStringFromClass(class) isEqualToString:@"NSManagedObject"]) {
        unsigned int propertyCount = 0;
        objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
        for (int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            const char *name =  property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:name];
            [allPropertys addObject:propertyName];
        }
        free(properties);
        class = [class superclass];
    }
    return allPropertys;
}

- (BOOL)copyPropertysTo:(NSManagedObject *)toObject {
    BOOL hasChange = NO;
    NSArray *propertys = [[self class] copyPropertysName:toObject];
    for (NSString *key in propertys) {
        if (!key) {
            continue;
        }
        
        id value = [self valueForKey:key];
        
        if ([value isKindOfClass:[NSSet class]]) {
            
        } else {
            if (![value isEqual:[toObject valueForKey:key]]) {
                [toObject setValue:value forKey:key];
                hasChange = YES;
            }
        }
    }
    return hasChange;
}
@end
