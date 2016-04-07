//
//  LFLBaseTabelView.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/4/6.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLBaseTableView.h"

@implementation LFLBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
@end
