//
//  LFLUserCenterViewModel.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/4/21.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLUserCenterViewModel.h"
#import "LFLBaseRequest.h"

@implementation LFLTestGetMethodRequest

- (void)loadRequestWithOwner:(id)owner {
    [super loadRequestWithOwner:owner];
    self.METHOD = @"GET";
    self.url = [NSURL URLWithString:@"http://apistore.baidu.com/microservice/cityinfo?cityname=beijing"];
}

@end

@implementation LFLTestPostMethodRequest

- (void)loadRequestWithOwner:(id)owner {
    [super loadRequestWithOwner:owner];
    self.METHOD = @"POST";
    self.url = [NSURL URLWithString:@""];
    NSDictionary *requestHeader = @{};
    self.params = @{}.mutableCopy;
    self.httpHeaderFields = requestHeader;
}

@end

@implementation LFLUserCenterViewModel

- (void)loadSceneModel {
    [super loadSceneModel];
    @weakify(self);
    _getTestRequest = [LFLTestGetMethodRequest RequestWithOwner:self.owner handlerBlock:^{
        @strongify(self);
        [self SEND_ACTION:self.getTestRequest];
    }];
    
    _postTestRequest = [LFLTestPostMethodRequest RequestWithOwner:self.owner handlerBlock:^{
        @strongify(self);
        [self SEND_ACTION:self.getTestRequest];
    }];
}

- (void)loadNewData {
    NSError *error;
    self.model = [[LFLUserCenterModel alloc] initWithDictionary:self.getTestRequest.output[@"data"] error:&error];
}
@end
