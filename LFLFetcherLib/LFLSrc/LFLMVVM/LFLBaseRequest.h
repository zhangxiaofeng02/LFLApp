//
//  LFLBaseRequest.h
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/21.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFLFetcher.h"
#import "LFLFetcher+NetWork.h"

typedef void (^VoidBlock)();

extern NSString * const LFLRequestStateSuccess;
extern NSString * const LFLRequestStateFailed;
extern NSString * const LFLRequestStateSending;
extern NSString * const LFLRequestStateError;
extern NSString * const LFLRequestStateCancle;
extern NSString * const LFLRequestStateInit;

@interface LFLBaseRequest : NSObject

@property (nonatomic, strong) NSDictionary *output;//序列化以后的数据
@property (nonatomic, strong) NSMutableDictionary *params;//请求字典参数
@property (nonatomic, strong) NSString *responseString;//获取的字符串数据
@property (nonatomic, strong) NSError *error;//请求的错误
@property (nonatomic, assign) NSString *state;//Request的状态
@property (nonatomic, strong) NSURL *url;//请求的url
@property (nonatomic, strong) NSString *message;//服务器返回msg或者错误消息
@property (nonatomic, strong) NSObject *codekey; //错误码返回

@property (nonatomic, strong) NSString *SCHEME;//协议
@property (nonatomic, strong) NSString *HOST;//域名
@property (nonatomic, strong) NSString *PATH;//请求路径
@property (nonatomic, strong) NSString *STATICPATH;//其他请求路径
@property (nonatomic, strong) NSString *METHOD;//提交方式
@property (nonatomic, assign) BOOL needCheckCode;//是否需要检查错误码
@property (nonatomic, strong) NSSet *acceptableContentTypes;//可接受的序列化返回的数据格式
@property (nonatomic, strong) NSDictionary *httpHeaderFields; //http头参数设置
@property (nonatomic, assign) BOOL requestNeedActive;//是否发动请求
@property (nonatomic, strong) LFLURLSesstionTask *op;//afn返回的操作队列
@property (nonatomic, copy) VoidBlock requestInActiveBlock;//激活请求后的block
@property (nonatomic, assign) NSTimeInterval timeoutInterval;//超时时间默认60
@property (nonatomic, assign) BOOL isTimeOut;//是否超时
@property (nonatomic, assign) BOOL isFirstRequest;//是否是第一次请求
@property (nonatomic, strong) LFLFetcher *fetcher;

+ (id)RequestWithOwner:(id)owner;//初始化请求
+ (id)RequestWithOwner:(id)owner handlerBlock:(VoidBlock)voidBlock;//初始化带block的请求
- (void)loadRequestWithOwner:(id)owner;//请求加载入口
- (BOOL)success;//请求是否成功
- (BOOL)sending;//请求是否在发送中
- (BOOL)failed;//请求是否失败
- (BOOL)cancled;//请求是否取消
- (void)cancle;//取消本次请求
@end
