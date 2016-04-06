//
//  LFLAppShellViewController.m
//  LFLAppShell
//
//  Created by 啸峰 on 16/4/4.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLAppShellViewController.h"
#import "LFLTestAppController.h"
#import "LFLTrunkLib.h"
@interface LFLAppShellViewController()<UINavigationControllerDelegate>

@property (nonatomic, strong) LFLMainNavigationController *navigationController;
@end

@implementation LFLAppShellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LFLMainTabBarController *root = [[LFLMainTabBarController alloc] init];
    self.navigationController = [[LFLMainNavigationController alloc] initWithRootViewController:root];
    self.navigationController.delegate = self;
    UIView *view = self.view;
    UIView *subView = self.navigationController.view;
    [self addChildViewController:self.navigationController];
    [view addSubview:subView];
}
@end
