//
//  LFLFetcher.m
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/10.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLFetcher.h"
#import "LFLFetcherManager.h"
#import "LFLFetcher+NetWork.h"
#import "LFLFetcher+CoreData.h"

@interface LFLFetcher()

@property (nonatomic, strong, readwrite) NSString *networkGroupID;
@end

@implementation LFLFetcher

- (void)dealloc {
    [[LFLJsonPraserManager shareInstance] canclePraserInGroup:[self networkGroupID]];
    //这里少一个取消对应的网络请求方法
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init {
    self = [super init];
    if (self) {
        //do something
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveMemoryWarningNotification:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)didReceiveMemoryWarningNotification:(NSNotification *)notify {
    [self turnedAllObjectIntoFault];
}
@end
