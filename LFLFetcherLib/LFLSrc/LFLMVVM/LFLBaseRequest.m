//
//  LFLBaseRequest.m
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/21.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLBaseRequest.h"
#import "EasyTransModel.h"
#import "LFLFetcherManager.h"

NSString * const LFLRequestStateSuccess = @"LFLRequestStateSuccess";
NSString * const LFLRequestStateFailed = @"LFLRequestStateFailed";
NSString * const LFLRequestStateSending = @"LFLRequestStateSending";
NSString * const LFLRequestStateError = @"LFLRequestStateError";
NSString * const LFLRequestStateCancle = @"LFLRequestStateCancle";
NSString * const LFLRequestStateInit = @"LFLRequestStateInit";

@implementation LFLBaseRequest

+ (id)RequestWithOwner:(id)owner {
    return [[self alloc] initRequestWithOwner:owner];
}

+ (id)RequestWithOwner:(id)owner handlerBlock:(VoidBlock)voidBlock {
    return [[self alloc] initRequestWithOwner:owner handleBlock:voidBlock];
}

- (id)initRequestWithOwner:(id)owner {
    self = [super init];
    if (self) {
        [self loadRequestWithOwner:owner];
    }
    return self;
}

- (id)initRequestWithOwner:(id)owner handleBlock:(VoidBlock)voidBlock {
    self = [super init];
    if (self) {
        self.requestInActiveBlock = voidBlock;
        [self loadRequestWithOwner:owner];
    }
    return self;
}

- (void)loadRequestWithOwner:(id)owner {
    self.output = nil;
    self.message = @"";
    self.SCHEME = @"https://";
    self.HOST = @"";
    self.PATH = @"";
    self.METHOD = @"";
    self.needCheckCode = YES;
    if (owner) {
        self.fetcher = [[LFLFetcherManager shareInstance] fetcherWithObject:owner];
    } else {
        self.fetcher = [[LFLFetcherManager shareInstance] fetcherWithObject:@"MVVMRequest"];
    }
    self.params = [NSMutableDictionary dictionary];
    self.httpHeaderFields = [NSMutableDictionary dictionary];
    self.isFirstRequest = YES;
    self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    self.state = LFLRequestStateInit;
    [self loadActive];
}

- (void)loadActive {
    self.requestNeedActive = NO;
    @weakify(self)
    [[RACObserve(self, requestNeedActive)
     filter:^BOOL(NSNumber *active) {
         return [active boolValue];
     }]
     subscribeNext:^(id x) {
        @strongify(self)
        if (self.requestInActiveBlock) {
            self.requestInActiveBlock();
        }
        self.requestNeedActive = NO;
    }];
}

- (BOOL)success {
    if (self.output == nil) {
        return NO;
    }
    return LFLRequestStateSuccess == _state ? YES : NO;
}

- (BOOL)failed {
    return LFLRequestStateFailed == _state || LFLRequestStateError == _state ? YES : NO;
}

- (BOOL)sending {
    return LFLRequestStateSending == _state ? YES : NO;
}

- (BOOL)cancled {
    return LFLRequestStateCancle == _state ? YES : NO;
}

- (void)cancle {
    if (self.op) {
        [self.op cancel];
        if (self.op.state == NSURLSessionTaskStateCanceling) {
            self.state = LFLRequestStateCancle;
        }
    }
}
@end
