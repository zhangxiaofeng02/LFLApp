//
//  LFLUserInfo.h
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/16.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface LFLUserInfo : NSManagedObject

@property (nonatomic, retain) NSString *user_name;
@property (nonatomic, retain) NSNumber *sex;
@property (nonatomic, retain) NSNumber *age;
@end
