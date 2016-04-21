//
//  LFLBaseAction.h
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/21.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFLBaseRequest.h"
#import "LFLFetcher+NetWork.h"

@protocol ActionDelegate <NSObject>

- (void)handleActionMsg:(LFLBaseRequest *)req;
@end

@interface LFLBaseAction : NSObject

@property (nonatomic, weak) id<ActionDelegate> delegate;

+ (instancetype)shareInstance;
+ (id)Action;
- (LFLURLSesstionTask *)Send:(LFLBaseRequest *)msg;
@end
