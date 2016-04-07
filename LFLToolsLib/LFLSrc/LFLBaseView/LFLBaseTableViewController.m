//
//  LFLBaseTableViewController.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/4/6.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLBaseTableViewController.h"
@interface LFLBaseTableViewController ()

@end

@implementation LFLBaseTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tableViewStyle = UITableViewStylePlain;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.tableViewStyle = UITableViewStylePlain;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tableViewStyle = UITableViewStylePlain;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    if (self.tableViewStyle != UITableViewStylePlain) {
        self.tableViewStyle = UITableViewStylePlain;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configTableView {
    LFLBaseTableView *tableView = [[LFLBaseTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)
                                                                    style:self.tableViewStyle];
    self.tableView = tableView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *viewsDic = NSDictionaryOfVariableBindings(self.view,tableView);
    NSMutableArray *contsArr = [NSMutableArray array];
    [contsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-(%f)-[tableView]-(%f)-|",self.tableViewMargin.left,self.tableViewMargin.right]
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDic]];
    [contsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-(%f)-[tableView]-(%f)-|",self.tableViewMargin.top,self.tableViewMargin.bottom]
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDic]];
    [self.view addConstraints:contsArr];
    tableView.delegate = self;
    tableView.dataSource = self;
}

- (UIEdgeInsets)tableViewMargin {
    if (self.navigationController.navigationBar.translucent) {
        return UIEdgeInsetsMake(64, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}
@end
