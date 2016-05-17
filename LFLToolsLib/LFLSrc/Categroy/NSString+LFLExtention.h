//
//  NSString+LFLExtention.h
//  LFLToolsLib
//
//  Created by 啸峰 on 16/5/17.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LFLExtention)

- (CGFloat)contentHeightWithWidth:(CGFloat)width font:(CGFloat)size;
- (CGFloat)contentWidthWithHeight:(CGFloat)height font:(CGFloat)size;
@end
