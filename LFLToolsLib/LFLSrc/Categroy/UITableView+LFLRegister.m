//
//  UITableView+LFLRegister.m
//  LFLToolsLib
//
//  Created by 啸峰 on 16/4/7.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "UITableView+LFLRegister.h"

@implementation UITableView (LFLRegister)

- (void)LFLRegisterNibWithClass:(Class)class bundle:(NSString *)bundleName {
    NSString *identifenter = NSStringFromClass(class);
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"]];
    UINib *nib = [UINib nibWithNibName:identifenter bundle:bundle];
    [self registerNib:nib forCellReuseIdentifier:identifenter];
}
@end
