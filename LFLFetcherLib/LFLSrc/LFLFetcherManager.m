//
//  LFLFetcherManager.m
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/10.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLFetcherManager.h"
#import "LFLFetcher.h"

static LFLFetcherManager *fetcherMgr = nil;
static NSString *kTrunkBundleName = @"LFLTrunkBundle";
@interface LFLFetcherManager()

@property (nonatomic, strong) NSMutableDictionary *fetcherMap;
@property (nonatomic, strong, readwrite) NSManagedObjectContext *context;
@property (nonatomic, strong, readwrite) NSPersistentStoreCoordinator *coordinator;
@end

@implementation LFLFetcherManager

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [MagicalRecord cleanUp];
}

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetcherMgr = [[LFLFetcherManager alloc] init];
    });
    return fetcherMgr;
}

- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActiveNotification) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (void)initCoreData {
    if (LFL_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        //数据版本升级
    }
    [[LFLFetcherManager shareInstance] coreDataStepUp];
}

- (void)coreDataStepUp {
    NSString *bundleName = kTrunkBundleName;
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"]];
    
    //托管对象模型
    NSManagedObjectModel *mode = [NSManagedObjectModel MR_newModelNamed:@"Model.momd" inBundle:bundle];
    [NSManagedObjectModel MR_setDefaultManagedObjectModel:mode];
    
    NSString *storeFileName = [NSString stringWithFormat:@"%@.sqlite",bundleName];
    NSURL *storeUrl = [NSPersistentStore MR_urlForStoreName:storeFileName];
    
    //创建持久化存储协调器，托管对象上下文
    [MagicalRecord setupCoreDataStackWithStoreAtURL:storeUrl];
    NSPersistentStoreCoordinator * coordinator = [NSPersistentStoreCoordinator MR_defaultStoreCoordinator];
    if (coordinator.persistentStores.count>0) {
        debugAssert(@"新版本API找不到这个处理方法，但是感觉不会走这里，留作观察");
    }
    debugAssert([NSManagedObjectContext MR_defaultContext]);
    _context = [NSManagedObjectContext MR_defaultContext];
    _coordinator = [NSPersistentStoreCoordinator MR_defaultStoreCoordinator];
    [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelOff];
}

- (LFLFetcher *)fetcherWithObject:(id)object {
    NSString *fetcherKey = [NSString stringWithFormat:@"%@_%@",object,NSStringFromClass([object class])];
    debugAssert(fetcherKey.length>0);
    if (!(fetcherKey.length > 0)) {
        return nil;
    }
    if (!_fetcherMap) {
        _fetcherMap = [[NSMutableDictionary alloc] init];
    }
    LFLFetcher *fetcher = _fetcherMap[fetcherKey];
    if (!fetcher) {
        fetcher = [[LFLFetcher alloc] init];
        _fetcherMap[fetcherKey] = fetcher;
    }
    fetcher.fetcherDelegate = object;
    return fetcher;
}

- (void)removeFetcherWithObjects:(id)object {
    NSString *fetcherKey = [NSString stringWithFormat:@"%@_%@",object,NSStringFromClass([object class])];
    [_fetcherMap removeObjectForKey:fetcherKey];
    if (_fetcherMap.count == 0) {
        LFLLog(@"fetcher对象全部清空");
    }
}

- (void)didEnterBackground {
    [[[[self class] shareInstance] context] MR_saveToPersistentStoreAndWait];
}

- (void)didBecomeActiveNotification {
    
}
@end
