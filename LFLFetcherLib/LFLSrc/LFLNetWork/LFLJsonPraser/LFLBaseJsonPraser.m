//
//  LFLJsonPraser.m
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/11.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLBaseJsonPraser.h"

@interface LFLBaseJsonPraser()

@property (nonatomic, strong) NSData *data;
@end

@implementation LFLBaseJsonPraser

+ (LFLBaseJsonPraser *)createParserWithClass:(Class)parserClass initWithJson:(NSDictionary *)json {
    debugAssert([parserClass isSubclassOfClass:[LFLBaseJsonPraser class]]);
    LFLBaseJsonPraser *parser = [[parserClass alloc] initWithJson:json];
    return parser;
}

+ (LFLBaseJsonPraser *)createParserWithClass:(Class)parserClass initWithData:(NSData *)data {
    debugAssert([parserClass isSubclassOfClass:[LFLBaseJsonPraser class]]);
    LFLBaseJsonPraser *parser = [[parserClass alloc] initWithData:data];
    return parser;
}

- (id)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

- (id)initWithJson:(NSDictionary *)json {
    self = [super init];
    if (self) {
        _jsonObj = json;
    }
    return self;
}

- (void)main {
    @autoreleasepool {
        NSError *error = nil;
        if (!_jsonObj) {
            _jsonObj = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableLeaves error:&error];
            if (!_jsonObj) {
                LFLLog(@"JSON解析出错");
            }
        }
        self.data = nil;
        BOOL success = [self praser];
        if (success && !self.isCancelled) {
            [self reportFinish];
        } else {
            [self reportFaild];
        }
    }
}

- (BOOL)praser {
    BOOL success = NO;
    if ([NSJSONSerialization isValidJSONObject:_jsonObj]) {
        if ([_jsonObj isKindOfClass:[NSDictionary class]]) {
            NSInteger status = [[_jsonObj valueForKey:@"status"] integerValue];
            if (status == 2) {
                //demo:统一处理
            }
            success = YES;
        }
    } else {
        LFLLog(@"JSON格式异常，服务器异常");
    }
    return success;
}

- (void)reportFinish {
    if (![self isCancelled] && _finishHandler) {
        if ([NSThread isMainThread]) {
            _finishHandler(_jsonObj);
        } else {
            WeakSelf;
            dispatch_sync(dispatch_get_main_queue(), ^{
                StrongSelf;
                if (strongSelf.finishHandler) {
                    strongSelf.finishHandler(_jsonObj);
                }
            });
        }
    }
}

- (void)reportFaild {
    if (![self isCancelled] && _failedHandler) {
        if ([NSThread isMainThread]) {
            _failedHandler(_jsonObj);
        } else {
            WeakSelf;
            dispatch_sync(dispatch_get_main_queue(), ^{
                StrongSelf;
                if (strongSelf.failedHandler) {
                    strongSelf.failedHandler(_jsonObj);
                }
            });
        }
    }
}
@end
