//
//  LFLMainTabBarController.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/4/5.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLMainTabBarController.h"
#import "LFLTestAppController.h"
#import "LFLUserCenterViewController.h"
#import "LFLFetcher.h"
#import "LFLFetcherManager.h"

@interface LFLMainTabBarController ()

@property (nonatomic, strong) LFLFetcher *fetcher;
@end

@implementation LFLMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initChildControllers];
    [[LFLFetcherManager shareInstance] initCoreData];
    self.fetcher = [[LFLFetcherManager shareInstance] fetcherWithObject:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initChildControllers {
    LFLTestAppController *vc = [[LFLTestAppController alloc] init];
    [self addChildController:vc image:@"test" selectedImageName:@"test" title:@"精选"];
    
    LFLTestAppController *vc2 = [[LFLTestAppController alloc] init];
    [self addChildController:vc2 image:@"test" selectedImageName:@"test" title:@"客服"];

    
    LFLTestAppController *vc3 = [[LFLTestAppController alloc] init];
    [self addChildController:vc3 image:@"test" selectedImageName:@"test" title:@"发现"];

    LFLUserCenterViewController *userCenterViewController = [[LFLUserCenterViewController alloc] init];
    [self addChildController:userCenterViewController image:@"test" selectedImageName:@"test" title:@"我"];
}

- (void)addChildController:(UIViewController *)vc image:(NSString *)imageName selectedImageName:(NSString *)selectedImageName title:(NSString *)title {
    vc.title = title;
    vc.tabBarItem.selectedImage = [LFLTrunkBundle imageName:@"test"];
    vc.tabBarItem.image = [LFLTrunkBundle imageName:@"test"];
    LFLBaseNavigationController *nav = [[LFLBaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
