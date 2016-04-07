//
//  UITableView+LFLRegister.h
//  LFLToolsLib
//
//  Created by 啸峰 on 16/4/7.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (LFLRegister)

/**
 * tableview注册cell 方法
 **/
- (void)LFLRegisterNibWithClass:(Class)class bundle:(NSString *)bundleName;
@end
