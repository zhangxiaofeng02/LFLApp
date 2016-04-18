//
//  LFLGlobal.h
//  LFLToolsLib
//
//  Created by 啸峰 on 16/4/7.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>

//断言
#ifdef DEBUG
#define debugAssert(e) assert(e)
#else
#define debugAssert(e) (void(0))
#endif

//日志
#ifdef DEBUG
#define LFLLog(s, ...) NSLog( @"%s - %@ - %@",__func__, NSStringFromSelector(_cmd),[NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define LFLLog(s, ...)
#endif

//屏幕宽度
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
#define ScreenHeight [[UIScreen mainScreen]bounds].size.height
#define ScreenScale [UIScreen mainScreen].scale

//颜色
#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//self的强弱引用
#define WeakSelf   __weak typeof (self) weakSelf = self
#define StrongSelf __strong typeof (weakSelf) strongSelf = weakSelf

//系统版本
#define LFL_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]==NSOrderedSame)
#define LFL_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]==NSOrderedDescending)
#define LFL_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)
#define LFL_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]==NSOrderedAscending)
#define LFL_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]!=NSOrderedDescending)
@interface LFLGlobal : NSObject
@end
