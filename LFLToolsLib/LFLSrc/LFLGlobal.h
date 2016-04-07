//
//  LFLGlobal.h
//  LFLToolsLib
//
//  Created by 啸峰 on 16/4/7.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
#define ScreenHeight [[UIScreen mainScreen]bounds].size.height
#define ScreenScale [UIScreen mainScreen].scale

#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
@interface LFLGlobal : NSObject
@end
