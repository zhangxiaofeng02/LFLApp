//
//  LFLUserCenterViewController.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/4/7.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLUserCenterViewController.h"
#import "LFLUserCenterCustomTableViewCell.h"

@interface LFLUserCenterViewController()

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) LFLFetcher *fetcher;
@end

@implementation LFLUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@[@{@"headIcon":@"",@"userName":@"",@"userPhone":@"",@"userLevel":@""}],
                     @[@{@"icon":@"",@"title":@"相册",@"location":@"top"},@{@"icon":@"",@"title":@"收藏"},@{@"icon":@"",@"title":@"钱包"},@{@"icon":@"",@"title":@"优惠券",@"location":@"bottom"}],
                     @[@{@"icon":@"",@"title":@"表情",@"location":@"whole"}],
                     @[@{@"icon":@"",@"title":@"设置",@"location":@"whole"}]];
    [self.tableView setBackgroundColor:Color(239.0f, 239.0f, 244.0f, 1)];
    [self registerCell];
    
    self.fetcher = [[LFLFetcherManager shareInstance] fetcherWithObject:self];
}

#pragma mark - 注册cell
- (void)registerCell {
    [self.tableView LFLRegisterNibWithClass:[LFLUserCenterCustomTableViewCell class] bundle:@"LFLTrunkBundle"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LFLUserCenterCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LFLUserCenterCustomTableViewCell" forIndexPath:indexPath];
    NSArray *targetArr = self.dataArr[[indexPath section]];
    [cell configCellWithDictionary:targetArr[[indexPath row]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == [indexPath section]) {
        return 88.0f;
    } else {
        return 44.0f;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 15.0f;
    } else {
        return 20;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    [headerView setBackgroundColor:[UIColor clearColor]];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([indexPath section] == 3) {
        [self.fetcher getFromUrl:@"http://apistore.baidu.com/microservice/cityinfo?cityname=beijing"
                     withParamer:nil
               withRequestHeader:nil
                   inSerialQueue:YES
             withProgressHandler:nil
              withSuccessHandler:^(NSDictionary *dict) {
                  LFLLog(@"1");
              }
               withFailedHandler:^(NSError *error) {
                   LFLLog(@"2");
               }];
//        NSDictionary *postDict = @{ @"urls": @"http://www.henishuo.com/git-use-inwork/",
//                                    @"goal" : @"site",
//                                    @"total" : @(123)
//                                    };
//        [self.fetcher postToUrl:@"http://data.zz.baidu.com/urls?site=www.henishuo.com&token=bRidefmXoNxIi3Jp" withParamer:postDict withRequestHeader:nil isSerialQueue:YES withProgressHandler:nil
//             withSuccessHandler:^(NSDictionary *dict) {
//                 LFLLog(@"1");
//        } withFailedHandler:^(NSError *error) {
//                LFLLog(@"1");
//        }];
    }
}
@end
