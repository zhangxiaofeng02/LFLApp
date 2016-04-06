//
//  LFLMainTabBarController.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/4/5.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLMainTabBarController.h"
#import "LFLTestAppController.h"
#import "LFLMainNavigationController.h"

@interface LFLMainTabBarController ()

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
    LFLTestAppController *vc = [[LFLTestAppController alloc] init];
    [self addChildController:vc image:@"test" selectedImageName:@"test" title:@"第1页"];
    
    LFLTestAppController *vc2 = [[LFLTestAppController alloc] init];
    [self addChildController:vc2 image:@"test" selectedImageName:@"test" title:@"第2页"];
    
    LFLTestAppController *vc3 = [[LFLTestAppController alloc] init];
    [self addChildController:vc3 image:@"test" selectedImageName:@"test" title:@"第3页"];
    
    LFLTestAppController *vc4 = [[LFLTestAppController alloc] init];
    [self addChildController:vc4 image:@"test" selectedImageName:@"test" title:@"第4页"];
    
    LFLTestAppController *vc5 = [[LFLTestAppController alloc] init];
    [self addChildController:vc5 image:@"test" selectedImageName:@"test" title:@"第5页"];
}

- (void)addChildController:(UIViewController *)vc image:(NSString *)imageName selectedImageName:(NSString *)selectedImageName title:(NSString *)title {
    vc.title = title;
    vc.tabBarItem.selectedImage = [LFLTrunkBundle imageName:@"test"];
    vc.tabBarItem.image = [LFLTrunkBundle imageName:@"test"];
    LFLMainNavigationController *nav = [[LFLMainNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}
@end
