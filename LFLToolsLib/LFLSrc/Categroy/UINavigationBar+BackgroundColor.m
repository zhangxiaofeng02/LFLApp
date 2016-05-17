//
//  UINavigationBar+BackgroundColor.m
//  LFLToolsLib
//
//  Created by 啸峰 on 16/5/16.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "UINavigationBar+BackgroundColor.h"
#import <objc/runtime.h>

@implementation UINavigationBar (LFLBackgroundColor)

static char backgroundView;

- (UIView *)backgroundView {
    return objc_getAssociatedObject(self, &backgroundView);
}

- (void)setBackgroundView:(UIView *)view {
    objc_setAssociatedObject(self, &backgroundView, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)LFLSetBackgroundColor:(UIColor *)color {
    if (!self.backgroundView) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [[UIScreen mainScreen] bounds].size.width, self.bounds.size.height+20)];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.backgroundView atIndex:0];
        [self.backgroundView setUserInteractionEnabled:NO];
    }
    self.backgroundView.backgroundColor = color;
}

- (void)LFLRemoveBackgroundView {
    if (self.backgroundView) {
        [self.backgroundView removeFromSuperview];
    }
    objc_removeAssociatedObjects(self);
}
@end
