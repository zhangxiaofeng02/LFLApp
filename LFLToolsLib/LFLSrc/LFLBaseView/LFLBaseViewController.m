//
//  LFLBaseViewController.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/4/6.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLBaseViewController.h"

@interface LFLBaseViewController ()

@end

@implementation LFLBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIImageView *)LFLFindHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self LFLFindHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
@end
