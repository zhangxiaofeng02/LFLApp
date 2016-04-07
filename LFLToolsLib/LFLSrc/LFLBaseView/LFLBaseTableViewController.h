//
//  LFLBaseTableViewController.h
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/4/6.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLBaseViewController.h"

@interface LFLBaseTableViewController : LFLBaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) LFLBaseTableView *tableView;
@property (nonatomic) UITableViewStyle tableViewStyle;
@end
