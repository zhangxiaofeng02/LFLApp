//
//  LFLBaseModel.h
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/21.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface LFLBaseModel : JSONModel

+ (id)Model;
- (void)loadModel;
- (BOOL)isEmpty;
@end
