//
//  LFLTrunkBundle.h
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/4/4.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LFLTrunkBundle : NSObject

+ (NSBundle *)resourceBundle;
+ (UIImage *)imageName:(NSString *)name;
+ (UINib *)nibWithName:(NSString *)name;
@end
