//
//  LFLBaseViewModel.m
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/21.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLBaseViewModel.h"

@implementation LFLBaseViewModel

+ (id)viewModelWithOwner:(id)owner {
    return [[self alloc] initWithOwner:owner];
}

- (id)initWithOwner:(id)owner {
    self = [super init];
    if (self) {
        [self loadSceneModel];
        self.owner = owner;
    }
    return self;
}

- (void)handleActionMsg:(LFLBaseRequest *)req {
    if (req.sending) {
        LFLLog(@"sending:%@",req.message);
    } else if (req.success) {
        LFLLog(@"success:%@",req.message);
    } else if (req.failed) {
        LFLLog(@"failed:%@",req.message);
    }
}

- (void)SEND_ACTION:(LFLBaseRequest *)req {
    if (req != nil) {
        [self.action Send:req];
    }
}

- (void)loadSceneModel {
    self.action = [LFLBaseAction Action];
}
@end
