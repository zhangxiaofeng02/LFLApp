//
//  LFLBaseAction.m
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/21.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLBaseAction.h"
#import "EasyTransModel.h"

@interface LFLBaseAction()

@property (nonatomic, strong) NSString *CODE_KEY;
@property (nonatomic) NSUInteger RIGHT_CODE;
@property (nonatomic, strong) NSString *MSG_KEY;
@end

@implementation LFLBaseAction

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static LFLBaseAction *singleTon;
    dispatch_once(&onceToken, ^{
        singleTon = [[[self class] alloc] init];
        singleTon.CODE_KEY = @"status";
        singleTon.RIGHT_CODE = 0;
        singleTon.MSG_KEY = @"msg";
    });
    return singleTon;
}

+ (id)Action {
    return [[[self class] alloc] init];
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (LFLURLSesstionTask *)Send:(LFLBaseRequest *)req {
    if ([req.METHOD isEqualToString:@"GET"]) {
        return [self GET:req];
    } else {
        return [self POST:req];
    }
}

- (LFLURLSesstionTask *)GET:(LFLBaseRequest *)req {
    [self sending:req];
    WeakSelf;
    [req.fetcher getFromUrl:req.url.absoluteString
               withParamer:req.params
         withRequestHeader:req.httpHeaderFields
             inSerialQueue:YES
       withProgressHandler:^(int64_t bytesRead, int64_t totalBytesRead) {
        
       } withSuccessHandler:^(NSDictionary *dict, NSError *error) {
           StrongSelf;
           if (error) {
               req.error = error;
               [strongSelf failed:req];
           } else {
               req.output = dict;
               [strongSelf checkCode:req];
           }
       } withFailedHandler:^(NSError *error) {
           StrongSelf;
           if (error) {
               req.error = error;
               [strongSelf failed:req];
           }
       }];
    return nil;
}

- (LFLURLSesstionTask *)POST:(LFLBaseRequest *)req {
    WeakSelf;
    [req.fetcher postToServerInterfaceKey:req.url.absoluteString
                              withParamer:req.params
                        withRequestHeader:req.httpHeaderFields
                            isSerialQueue:YES
                      withProgressHandler:^(int64_t bytesRead, int64_t totalBytesRead) {
                          
                      } withSuccessHandler:^(NSDictionary *dict, NSError *error) {
                          StrongSelf;
                          if (error) {
                              req.error = error;
                              [strongSelf failed:req];
                          } else {
                              req.output = dict;
                              [strongSelf checkCode:req];
                          }
                      } withFailedHandler:^(NSError *error) {
                          StrongSelf;
                          if (error) {
                              req.error = error;
                              [strongSelf failed:req];
                          }
                      }];
    return nil;
}

- (void)sending:(LFLBaseRequest *)req {
    req.state = LFLRequestStateSending;
    if ([self.delegate respondsToSelector:@selector(handleActionMsg:)]) {
        [self.delegate handleActionMsg:req];
    }
}

- (void)success:(LFLBaseRequest *)req {
    req.message = [req.output objectAtPath:[LFLBaseAction shareInstance].MSG_KEY];
    [self successAction:req];
}

- (void)successAction:(LFLBaseRequest *)req {
    req.state = LFLRequestStateSuccess;
    if ([self.delegate respondsToSelector:@selector(handleActionMsg:)]) {
        [self.delegate handleActionMsg:req];
    }
}

- (void)error:(LFLBaseRequest *)req {
    if ([req.output objectAtPath:[LFLBaseAction shareInstance].MSG_KEY]) {
        req.message = [req.output objectAtPath:[LFLBaseAction shareInstance].MSG_KEY];
    }
    req.state = LFLRequestStateError;
    if ([self.delegate respondsToSelector:@selector(handleActionMsg:)]) {
        [self.delegate handleActionMsg:req];
    }
}

- (void)failed:(LFLBaseRequest *)req {
    if (req.error.userInfo != nil && [req.error.userInfo objectForKey:@"NSLocalizedDescription"]) {
        req.message = [req.error.userInfo objectForKey:@"NSLocalizedDescription"];
    } else {
        req.message = [NSString stringWithFormat:@"ServerError"];
    }
    req.state = LFLRequestStateFailed;
    if (req.error.code == -1001) {
        req.isTimeOut = YES;
    }
    if ([self.delegate respondsToSelector:@selector(handleActionMsg:)]) {
        [self.delegate handleActionMsg:req];
    }
}

- (void)checkCode:(LFLBaseRequest *)msg {
    if (msg.needCheckCode) {
        msg.codekey = [msg.output objectAtPath:[LFLBaseAction shareInstance].CODE_KEY];
        if ([msg.output objectAtPath:[LFLBaseAction shareInstance].CODE_KEY] &&
            [[msg.output objectAtPath:[LFLBaseAction shareInstance].CODE_KEY] integerValue] == [LFLBaseAction shareInstance].RIGHT_CODE) {
            [self success:msg];
        } else {
            [self successAction:msg];
        }
    }
}
@end
