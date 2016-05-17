//
//  NSString+LFLExtention.m
//  LFLToolsLib
//
//  Created by 啸峰 on 16/5/17.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "NSString+LFLExtention.h"

@implementation NSString (LFLExtention)

- (CGFloat)contentHeightWithWidth:(CGFloat)width font:(CGFloat)size {
    CGRect r = CGRectZero;
    r = [self boundingRectWithSize:CGSizeMake(width, HUGE_VAL)
                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                         attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size],NSParagraphStyleAttributeName:[NSParagraphStyle defaultParagraphStyle]}
                            context:nil];
    return r.size.height + 1;
}

- (CGFloat)contentWidthWithHeight:(CGFloat)height font:(CGFloat)size {
    CGRect r = CGRectZero;
    r = [self boundingRectWithSize:CGSizeMake(HUGE_VAL, height)
                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                        attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size],NSParagraphStyleAttributeName:[NSParagraphStyle defaultParagraphStyle]}
                           context:nil];
    return r.size.width + 1;
}
@end
