//
//  LFLFetcher+CoreData.h
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/12.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLFetcher.h"

@interface LFLFetcher (CoreData)

/**
 * 带偏移量的查询器
 */
- (NSFetchedResultsController *)fetcherWith:(Class)objectsClass
                                   sortedBy:(NSString *)sortTerm
                                  ascending:(BOOL)ascending
                              withPredicate:(NSPredicate *)predicate
                                    groupBy:(NSString *)groupKeyPath
                                     offset:(NSInteger)offset;

/**
 * 不带偏移量的查询器
 */
- (NSFetchedResultsController *)fetcherWith:(Class)objectClass
                                   sortedBy:(NSString *)sortTerm
                                  ascending:(BOOL)ascending
                              withPredicate:(NSPredicate *)predicate
                                    groupBy:(NSString *)groupingKeyPath;

/**
 * 去除某个类的查询结果，key ＝ [self class]
 **/
- (void)invalidFetcherWith:(Class)objectClass;

/**
 * 重置LFLFetcher维护的查询结果字典，移除全部结果
 **/
- (void)resetAllFetcher;

/**
 * 将所有NSManagedObject对象（LFLFetcher维护的字典中的对象）状态全部置为fault,相当于刷新所有上下文，同步状态，保存
 **/
- (void)turnedAllObjectIntoFault;

/**
 * 删除所有的主context的托管对象 - 异步
 **/
+ (void)deleteAllObjectWithEntityClass:(__unsafe_unretained Class)entityClass completion:(void(^)(void))completion;

/**
 * 添加托管对象模型 - 异步
 **/
+ (NSManagedObject *)addObject:(Class)objectClass withPropertys:(NSDictionary*)propertys;

/**
 * 删除托管对象模型 - 异步
 **/
+ (BOOL)deleteObjectWithPredicate:(NSPredicate *)predicate entityClass:(Class)entityClass;

/**
 * 删除托管对象模型 - 同步
 */
+ (void)deleteObjects:(NSArray*)objects;

/**
 * 更新托管对象模型 - 异步
 **/
+ (BOOL)updateObjectPropertyWith:(NSManagedObject*)obj;

/**
 * 更新托管对象模型（多个） - 异步
 **/
+ (BOOL)updateObjectsPropertyWith:(NSArray *)objs;

/**
 * 获取当前托管对象模型中某个属性的最大值
 */
+ (NSNumber*)maxIndexObject:(NSString*)maxIndexKey entityClass:(Class)entityClass;

/**
 * 返回当前属性的第一条
 **/
+ (id)largestValueForAttribute:(NSString *)attribute ascending:(BOOL)ascending entityClass:(Class)entityClass;

/**
 * 根据过滤条件获取对应的托管对象模型数组
 **/
+ (NSArray *)fetchObjectsWithPredicate:(NSPredicate *)predicate entityClass:(Class)entityClass;

/**
 * 根据过滤条件，排序，分组，数量获取托管对象模型数组
 **/
+ (NSArray *)fetchObjectsSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)searchTerm entityClass:(Class)entityClass withLimit:(NSInteger)limit;

/**
 * 根据过滤条件获取第一条对应的托管对象模型
 **/
+ (id)firstObjectWithPredicate:(NSPredicate*)predicate sortedBy:(NSString *)propert entityClass:(Class)entityClass;
@end
