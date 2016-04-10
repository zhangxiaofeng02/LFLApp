//
//  LFLFetcher+NetWork.m
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/10.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLFetcher+NetWork.h"

static NSInteger kLFLMaxConcurrentOperationCount = 3;
static NSMutableArray *allTasksArr;
@implementation LFLFetcher (NetWork)

#pragma mark - Get请求
- (void)getFromUrl:(NSString *)url
       withParamer:(NSDictionary *)paramer
 withRequestHeader:(NSDictionary *)header
     inSerialQueue:(BOOL)serial
withProgressHandler:(LFLGetProgress)progress
withSuccessHandler:(LFLRequestSuccess)success
 withFailedHandler:(LFLRequestFailed)failed {
    [self getFromUrl:url
  serverInterfaceKey:kLFLServerInterfaceUnkonw
         withParamer:paramer
   withRequestHeader:header
       inSerialQueue:serial
 withProgressHandler:progress
  withSuccessHandler:success
   withFailedHandler:failed];
}

- (void)getFromServerInterfaceKey:(NSString *)serverInterfaceKey
                      withParamer:(NSDictionary *)paramer
                withRequestHeader:(NSDictionary *)header
                    inSerialQueue:(BOOL)serial
              withProgressHandler:(LFLGetProgress)progress
               withSuccessHandler:(LFLRequestSuccess)success
                withFailedHandler:(LFLRequestFailed)failed {
    [self getFromUrl:[LFLURLMaker LFLURLwithServerInterfaceKey:serverInterfaceKey]
  serverInterfaceKey:serverInterfaceKey
         withParamer:paramer
   withRequestHeader:header
       inSerialQueue:serial
 withProgressHandler:progress
  withSuccessHandler:success
   withFailedHandler:failed];
}

- (void)getFromUrl:(NSString *)urlStr
serverInterfaceKey:(NSString *)serverInterfaceKey
       withParamer:(NSDictionary *)paramer
 withRequestHeader:(NSDictionary *)header
     inSerialQueue:(BOOL)serial
withProgressHandler:(LFLGetProgress)progress
withSuccessHandler:(LFLRequestSuccess)success
 withFailedHandler:(LFLRequestFailed)failed; {
   
    AFHTTPSessionManager *manager = [self configManagerWithHeader:header isSerializer:serial];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    if (!url) {
        debugAssert(@"url不正确");
    }
    
    LFLURLSesstionTask *task = [manager GET:urlStr parameters:paramer progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[[self class] allTasks] removeObject:task];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[[self class] allTasks] removeObject:task];
        if (failed) {
            failed(error);
        }
    }];
    
    if (task) {
        [[[self class] allTasks] addObject:task];
    }
}

#pragma mark - Post请求
- (void)postToUrl:(NSString *)url
      withParamer:(NSDictionary *)paramer
withRequestHeader:(NSDictionary *)header
    isSerialQueue:(BOOL)serial
withProgressHandler:(LFLPostPrgress)progress
withSuccessHandler:(LFLRequestSuccess)success
withFailedHandler:(LFLRequestFailed)failed {
    [self postToUrl:url
withServerInterfaceKey:kLFLServerInterfaceUnkonw
        withParamer:paramer
  withRequestHeader:header
      isSerialQueue:YES
withProgressHandler:progress
 withSuccessHandler:success
  withFailedHandler:failed];
}

- (void)postToServerInterfaceKey:(NSString *)serverInterfaceKey
                     withParamer:(NSDictionary *)paramer
               withRequestHeader:(NSDictionary *)header
                   isSerialQueue:(BOOL)serial
             withProgressHandler:(LFLPostPrgress)progress
              withSuccessHandler:(LFLRequestSuccess)success
               withFailedHandler:(LFLRequestFailed)failed {
    [self postToUrl:[LFLURLMaker LFLURLwithServerInterfaceKey:serverInterfaceKey]
withServerInterfaceKey:serverInterfaceKey
        withParamer:paramer
  withRequestHeader:header
      isSerialQueue:YES
withProgressHandler:progress
 withSuccessHandler:success
  withFailedHandler:failed];
}

- (void)postToUrl:(NSString *)urlStr
withServerInterfaceKey:(NSString *)serverInterfaceKye
      withParamer:(NSDictionary *)paramer
withRequestHeader:(NSDictionary *)header
    isSerialQueue:(BOOL)serial
withProgressHandler:(LFLPostPrgress)progress
withSuccessHandler:(LFLRequestSuccess)success
withFailedHandler:(LFLRequestFailed)failed {
    
    AFHTTPSessionManager *manager = [self configManagerWithHeader:header isSerializer:YES];
    NSURL *url = [NSURL URLWithString:urlStr];
    if (!url) {
        debugAssert(@"URL不正确");
    }
    LFLURLSesstionTask *task = [manager POST:urlStr parameters:paramer progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[[self class] allTasks] removeObject:task];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[[self class] allTasks] removeObject:task];
        if (failed) {
            failed(error);
        }
    }];
    if (task) {
        [[[self class] allTasks] addObject:task];
    }
}

#pragma mark 配置AFHTTPSessionManager
- (AFHTTPSessionManager *)configManagerWithHeader:(NSDictionary *)header isSerializer:(BOOL)serializer {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //请求，返回串行
    if (serializer) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    //请求格式
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    //请求头设置
    for (NSString *key in header.allKeys) {
        if (header[key]) {
            [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
    }
    manager.responseSerializer.acceptableContentTypes = [[self class] acceptableContentTypes];
    manager.operationQueue.maxConcurrentOperationCount = kLFLMaxConcurrentOperationCount;
    
    return manager;
}

#pragma mark private
//可以接受的返回数据类型
+ (NSSet *)acceptableContentTypes {
    return [NSSet setWithArray:@[@"application/json",
                                 @"text/html",
                                 @"text/json",
                                 @"text/plain",
                                 @"text/javascript",
                                 @"text/xml",
                                 @"image/*"]];
}

//全局task任务列表
+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!allTasksArr) {
            allTasksArr = [NSMutableArray array];
        }
    });
    return allTasksArr;
}
@end
