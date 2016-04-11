//
//  LFLJsonPraserManager.m
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/11.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLJsonPraserManager.h"

@interface LFLJsonPraserManager()

@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) NSMutableDictionary *praserMap;
@end

static LFLJsonPraserManager *manager = nil;
@implementation LFLJsonPraserManager

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LFLJsonPraserManager alloc] init];
    });
    return manager;
}

- (NSInteger)addPraserToQueue:(LFLBaseJsonPraser *)praser withGroupID:(JsonPraserGroupID)groupid {
    debugAssert([NSThread mainThread]);
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:1];
    }
    [_queue addOperation:praser];
    [self addToPraserMap:praser withGroupID:groupid];
    WeakSelf;
    NSString *parserKey = [NSString stringWithFormat:@"%p",praser];
    [praser setCompletionBlock:^{
       dispatch_sync(dispatch_get_main_queue(), ^{
           NSMutableDictionary *parserGroup = weakSelf.praserMap[groupid];
           [parserGroup removeObjectForKey:parserKey];
           if (0 == [weakSelf.praserMap[groupid] allValues].count) {
               [weakSelf.praserMap removeObjectForKey:groupid];
           }
       });
    }];
    return 0;
}

- (void)addToPraserMap:(LFLBaseJsonPraser *)praser withGroupID:(JsonPraserGroupID)groupid {
    debugAssert([NSThread mainThread]);
    if (nil == _praserMap) {
        _praserMap = [[NSMutableDictionary alloc] init];
    }
    if (nil == _praserMap[groupid]) {
        _praserMap[groupid] = [[NSMutableDictionary alloc] init];
    }
    _praserMap[groupid][[NSString stringWithFormat:@"%p",praser]] = praser;
}

- (void)cancleAllParsers {
    [_queue cancelAllOperations];
    [_queue waitUntilAllOperationsAreFinished];
    self.praserMap = nil;
}

- (void)canclePraserInGroup:(JsonPraserGroupID)groupid {
    debugAssert([NSThread isMainThread]);
    NSArray *praserInGroup = [self.praserMap[groupid] allValues];
    for (LFLBaseJsonPraser *praser in praserInGroup) {
        [praser cancel];
    }
    [_praserMap removeObjectForKey:groupid];
}
@end
