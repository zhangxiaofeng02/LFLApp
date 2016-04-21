//
//  LFLBaseViewModel.h
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/21.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFLBaseAction.h"
#import "LFLBaseRequest.h"

@interface LFLBaseViewModel : NSObject

@property (nonatomic, strong) LFLBaseAction *action;
@property (nonatomic, strong) id owner;

+ (id)viewModelWithOwner:(id)owner;
- (void)handleActionMsg:(LFLBaseRequest *)req;
- (void)SEND_ACTION:(LFLBaseRequest *)req;
- (void)loadSceneModel;
@end
