//
//  LFLMainTabBarController.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/4/5.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLMainTabBarController.h"
#import "LFLTestAppController.h"

@interface LFLMainTabBarController ()

@property (nonatomic, strong) LFLTestAppController *vc;
@property (nonatomic, strong) LFLTestAppController *vc2;
@property (nonatomic, strong) LFLTestAppController *vc3;
@property (nonatomic, strong) LFLTestAppController *vc4;
@end

@implementation LFLMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initChildControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initChildControllers {
    _vc = [[LFLTestAppController alloc] init];
    [self addChildController:_vc image:@"test" selectedImageName:@"test" title:@"精选"];
    
    _vc2 = [[LFLTestAppController alloc] init];
    [self addChildController:_vc2 image:@"test" selectedImageName:@"test" title:@"客服"];

    
    _vc3 = [[LFLTestAppController alloc] init];
    [self addChildController:_vc3 image:@"test" selectedImageName:@"test" title:@"发现"];

    _vc4 = [[LFLTestAppController alloc] init];
    [self addChildController:_vc4 image:@"test" selectedImageName:@"test" title:@"我"];
}

- (void)addChildController:(UIViewController *)vc image:(NSString *)imageName selectedImageName:(NSString *)selectedImageName title:(NSString *)title {
    vc.title = title;
    vc.tabBarItem.selectedImage = [LFLTrunkBundle imageName:@"test"];
    vc.tabBarItem.image = [LFLTrunkBundle imageName:@"test"];
    LFLBaseNavigationController *nav = [[LFLBaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
