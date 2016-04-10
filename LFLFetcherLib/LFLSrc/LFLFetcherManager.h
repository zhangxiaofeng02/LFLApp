//
//  LFLFetcherManager.h
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/10.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFLFetcher.h"

@interface LFLFetcherManager : NSObject

+ (instancetype)shareInstance;
- (LFLFetcher *)fetcherWithObject:(id)object;
@end
