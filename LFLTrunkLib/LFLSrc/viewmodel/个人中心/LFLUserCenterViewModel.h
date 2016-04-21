//
//  LFLUserCenterViewModel.h
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/4/21.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLBaseViewModel.h"
#import "LFLUserCenterModel.h"

@interface LFLTestGetMethodRequest : LFLBaseRequest

@end

@interface LFLTestPostMethodRequest : LFLBaseRequest

@end

@interface LFLUserCenterViewModel : LFLBaseViewModel

@property (nonatomic, strong) LFLTestGetMethodRequest *getTestRequest;
@property (nonatomic, strong) LFLTestPostMethodRequest *postTestRequest;
@property (nonatomic, strong) LFLUserCenterModel *model;

- (void)loadNewData;
@end
