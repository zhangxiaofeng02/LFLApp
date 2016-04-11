//
//  LFLFetcher+NetWork.h
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/10.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLFetcher.h"

//定义下载进度回调
typedef void(^LFLRequestProgress)(int64_t bytesRead,int64_t totalBytesRead);
typedef LFLRequestProgress LFLGetProgress;
typedef LFLRequestProgress LFLPostPrgress;

//重定义,不依赖第三方库
typedef NSURLSessionTask LFLURLSesstionTask;

//请求成功，失败回调
typedef void(^LFLRequestSuccess)(NSDictionary *dict,NSError *error);
typedef void(^LFLRequestFailed)(NSError *error);

@interface LFLFetcher (NetWork)

#pragma mark - Get请求
- (void)getFromUrl:(NSString *)url
       withParamer:(NSDictionary *)paramer
 withRequestHeader:(NSDictionary *)header
     inSerialQueue:(BOOL)serial//默认YES
withProgressHandler:(LFLGetProgress)progress
withSuccessHandler:(LFLRequestSuccess)success
 withFailedHandler:(LFLRequestFailed)failed;

- (void)getFromServerInterfaceKey:(NSString *)serverInterfaceKey
                      withParamer:(NSDictionary *)paramer
                withRequestHeader:(NSDictionary *)header
                    inSerialQueue:(BOOL)serial
              withProgressHandler:(LFLGetProgress)progress
               withSuccessHandler:(LFLRequestSuccess)success
                withFailedHandler:(LFLRequestFailed)failed;

#pragma mark - Post请求
- (void)postToUrl:(NSString *)url
      withParamer:(NSDictionary *)paramer
withRequestHeader:(NSDictionary *)header
    isSerialQueue:(BOOL)serial
withProgressHandler:(LFLPostPrgress)progress
withSuccessHandler:(LFLRequestSuccess)success
withFailedHandler:(LFLRequestFailed)failed;

- (void)postToServerInterfaceKey:(NSString *)serverInterfaceKey
                     withParamer:(NSDictionary *)paramer
               withRequestHeader:(NSDictionary *)header
                   isSerialQueue:(BOOL)serial
             withProgressHandler:(LFLPostPrgress)progress
              withSuccessHandler:(LFLRequestSuccess)success
               withFailedHandler:(LFLRequestFailed)failed;
@end
