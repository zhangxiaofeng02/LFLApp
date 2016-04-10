//
//  LFLURLMaker.m
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/10.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLURLMaker.h"
//无
NSString *const kLFLServerInterfaceUnkonw = @"kLFLServerInterfaceUnkonw";
//测试用
NSString *const kLFLServerInterfaceForTest = @"kLFLServerInterfaceForTest";
//地址
const NSString *const lfl_App_Address = @"http://www.lfl.com";
//测试地址
//const NSString *const lfl_App_address = @"http://www.lfl.test.com";

@implementation LFLURLMaker

static NSDictionary *urls = nil;

//获取主地址
+ (NSString *)LFLAppAddress {
    return [NSString stringWithFormat:@"%@",lfl_App_Address];
}

//设置请求路径
+ (NSString *)urlWithPath:(NSString *)path {
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@/%@?",[self LFLAppAddress],path];
    return url;
}

+ (NSString *)LFLURLwithServerInterfaceKey:(NSString *)key {
    if (!urls) {
        urls = @{
                 kLFLServerInterfaceForTest:[LFLURLMaker urlWithPath:@"lfl/test"]
                 };
    }
    return urls[key];
}
@end
