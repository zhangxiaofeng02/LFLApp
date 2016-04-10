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

@interface LFLFetcherManager()

@property (nonatomic, strong) NSMutableDictionary *fetcherMap;
@end

@implementation LFLFetcherManager

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        
    }
    return self;
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
    }
    _fetcherMap[fetcherKey] = fetcher;
    return fetcher;
}

- (void)removeFetcherWithObjects:(id)object {
    NSString *fetcherKey = [NSString stringWithFormat:@"%@_%@",object,NSStringFromClass([object class])];
    [_fetcherMap removeObjectForKey:fetcherKey];
    if (_fetcherMap.count == 0) {
        LFLLog(@"fetcher对象全部清空");
    }
}
@end
