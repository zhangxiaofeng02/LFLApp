//
//  UICollectionView+LFLRegister.m
//  LFLToolsLib
//
//  Created by 啸峰 on 16/5/16.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "UICollectionView+LFLRegister.h"

@implementation UICollectionView (LFLRegister)

- (void)LFLRegisterNibWithClass:(Class)class bundle:(NSString *)bundleName {
    NSString *identifenter = NSStringFromClass(class);
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"]];
    UINib *nib = [UINib nibWithNibName:identifenter bundle:bundle];
    [self registerNib:nib forCellWithReuseIdentifier:identifenter];
}
@end
