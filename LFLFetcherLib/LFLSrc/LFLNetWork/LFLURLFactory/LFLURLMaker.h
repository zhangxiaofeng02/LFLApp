//
//  LFLURLMaker.h
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/10.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kLFLServerInterfaceUnkonw;
extern NSString *const kLFLServerInterfaceForTest;

@interface LFLURLMaker : NSObject

/**
 * 工厂方法，根据定义的key生成对应的url
 */
+ (NSString *)LFLURLwithServerInterfaceKey:(NSString *)key;
@end
