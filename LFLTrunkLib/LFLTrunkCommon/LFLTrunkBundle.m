//
//  LFLTrunkBundle.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/4/4.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLTrunkBundle.h"

@implementation LFLTrunkBundle

+ (NSBundle *)resourceBundle {
    static dispatch_once_t onceToken;
    static NSBundle *resourceBundle;
    dispatch_once(&onceToken, ^{
        NSString *className = NSStringFromClass([self class]);
        resourceBundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:className withExtension:@"bundle"]];
    });
    return resourceBundle;
}

+ (UIImage *)imageName:(NSString *)name {
    NSString *className = NSStringFromClass([self class]);
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@",className,name]];
}

+ (UINib *)nibWithName:(NSString *)name {
    UINib *nib = [UINib nibWithNibName:name bundle:[self resourceBundle]];
    return nib;
}
@end
