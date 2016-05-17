//
//  LFLDiscoverBookBackView.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/5/16.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLDiscoverBookBackView.h"

@implementation LFLDiscoverBookBackView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawLinearGradient:context];
    self.layer.cornerRadius = 3.0f;
    self.clipsToBounds = YES;
}

-(void)drawLinearGradient:(CGContextRef)context{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat compoents[12] = {
        231.0/255.0,231.0/255.0,231.0/255.0,1,
        252.0/255.0,252.0/255.0,252.0/255.0,1
    };
    CGFloat locations[2] = {0,1.0};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 2);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(self.frame.size.width/2, self.frame.size.height/2), CGPointMake(0, self.frame.size.height/2), kCGGradientDrawsAfterEndLocation);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(self.frame.size.width/2, self.frame.size.height/2), CGPointMake(self.frame.size.width, self.frame.size.height/2), kCGGradientDrawsAfterEndLocation);
    CGColorSpaceRelease(colorSpace);
}
@end
