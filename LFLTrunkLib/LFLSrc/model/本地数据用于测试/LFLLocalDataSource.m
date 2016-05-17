//
//  LFLLocalDataSource.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/5/17.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLLocalDataSource.h"

@implementation LFLLocalDataSource

+ (NSArray *)discoverDataSource {
    return @[@{
                 @"book_img":@"",
                 @"book_name":@"暗恋 橘生淮南",
                 @"book_des":@"",
                 @"book_writer":@"八月长安",
                 @"friend_icon":@[@"1",@"2",@"3"],
                 @"friend_reading":@"3位好友在读这本书",
                 @"recommond":@"79"},
             @{
                 @"book_img":@"",
                 @"book_name":@"白夜行",
                 @"book_des":@"",
                 @"book_writer":@"东野圭吾",
                 @"friend_icon":@[@"1"],
                 @"friend_reading":@"蔡凌波在读这本书",
                 @"recommond":@"494"},
             @{
                 @"book_img":@"",
                 @"book_name":@"按自己的意愿过一生",
                 @"book_des":@"",
                 @"book_writer":@"王潇",
                 @"friend_icon":@[@"1"],
                 @"friend_reading":@"吉培轩_Jason在读这本书",
                 @"recommond":@"443"},
             @{
                 @"book_img":@"",
                 @"book_name":@"货币战争",
                 @"book_des":@"",
                 @"book_writer":@"宋鸿兵",
                 @"friend_icon":@[@"1"],
                 @"friend_reading":@"金仫亨嘉在读这本书",
                 @"recommond":@"262"}];
}
@end
