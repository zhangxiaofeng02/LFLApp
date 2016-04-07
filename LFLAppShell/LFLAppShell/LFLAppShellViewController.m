//
//  LFLAppShellViewController.m
//  LFLAppShell
//
//  Created by 啸峰 on 16/4/4.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLAppShellViewController.h"
#import "LFLToolsLib.h"
#import "LFLTrunkLib.h"

@interface LFLAppShellViewController()<UINavigationControllerDelegate>

@property (nonatomic, strong) LFLBaseNavigationController *navigationController;
@end

@implementation LFLAppShellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LFLMainTabBarController *root = [[LFLMainTabBarController alloc] init];
//    self.navigationController = [[LFLBaseNavigationController alloc] initWithRootViewController:root];
//    self.navigationController.delegate = self;
    UIView *view = self.view;
//    UIView *subView = self.navigationController.view;
//    [self addChildViewController:self.navigationController];
    [self addChildViewController:root];
    [view addSubview:root.view];
}
@end
