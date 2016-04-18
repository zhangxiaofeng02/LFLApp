//
//  NSManagedObject+LFLExtend.h
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/12.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (LFLExtend)

/**
 * 根据筛选条件获取结果处理器
 **/
+ (NSFetchedResultsController *)LFL_fetcherAllGroupedBy:(NSString *)group
                                          withPredicate:(NSPredicate *)predicate
                                               sortedBy:(NSString *)sorte
                                              ascending:(BOOL)ascending
                                                 offset:(NSInteger)offset
                                               delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                              inContext:(NSManagedObjectContext *)context;

/**
 * 根据条件获取结果数组
 */
+ (NSArray *)LFL_findAllSortedBy:(NSString *)sort
                       ascending:(BOOL)ascending
                   withPredicate:(NSPredicate *)predicate
                       inContext:(NSManagedObjectContext *)context
                       withLimit:(NSInteger)limit;

/**
 * 获取一个托管对象模型的全部属性
 **/
+ (NSMutableArray *)copyPropertysName:(NSManagedObject *)object;

/**
 * 托管对象模型属性迁移
 **/
- (BOOL)copyPropertysTo:(NSManagedObject *)toObject;

/**
 * 获取托管对象模型的个数
 **/
+ (NSInteger)LFL_numberOfEntitiesWithContext:(NSManagedObjectContext *)context;

/**
 * 获取托管对象模型的个数 - 带筛选条件
 **/
+ (NSInteger)LFL_numberOfEntitiesWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
@end
