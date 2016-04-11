//
//  LFLJsonPraserManager.h
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/11.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString *JsonPraserGroupID;
@interface LFLJsonPraserManager : NSObject

+ (instancetype)shareInstance;
- (NSInteger)addPraserToQueue:(LFLBaseJsonPraser *)praser withGroupID:(JsonPraserGroupID)groupid;
- (void)cancleAllParsers;
- (void)canclePraserInGroup:(JsonPraserGroupID)groupid;
@end
