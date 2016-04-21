//
//  LFLUserCenterViewController.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/4/7.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLUserCenterViewController.h"
#import "LFLUserCenterCustomTableViewCell.h"
#import "LFLFetcher+CoreData.h"
#import "LFLUserInfo.h"
#import <MagicalRecord/MagicalRecord.h>
#import "LFLUserCenterViewModel.h"
#import "LFLUserCenterModel.h"

@interface LFLUserCenterViewController()

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) LFLFetcher *fetcher;
@property (nonatomic, strong) LFLUserCenterViewModel *viewModel;
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
    
    [self addRAC];
    [self testGet];
}

#pragma mark MVVM
- (void)addRAC {
    @weakify(self);
    [RACObserve(self.viewModel,model)
     subscribeNext:^(LFLUserCenterModel *model) {
         @strongify(self)
         [self updateUI];
     }];
    
    [RACObserve(self.viewModel.getTestRequest, state) subscribeNext:^(NSString *state) {
        @strongify(self)
        if (self.viewModel.getTestRequest.failed) {
            LFLLog(@"failed");
        } else if (self.viewModel.getTestRequest.sending) {
            LFLLog(@"sending");
        } else if (self.viewModel.getTestRequest.success) {
            [self.viewModel loadNewData];
        }
    }];
    
    [RACObserve(self.viewModel.postTestRequest, state) subscribeNext:^(NSString *state) {
        @strongify(self);
        if (self.viewModel.postTestRequest.failed) {
            LFLLog(@"failed");
        } else if (self.viewModel.postTestRequest.sending) {
            LFLLog(@"sending");
        } else if (self.viewModel.getTestRequest.success) {
            LFLLog(@"success");
        }
    }];
}

- (void)testPost {
    self.viewModel.postTestRequest.requestNeedActive = YES;
}

- (void)testGet {
    self.viewModel.getTestRequest.requestNeedActive = YES;
}

- (void)updateUI {
    LFLLog(@"success");
}

- (LFLUserCenterViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [LFLUserCenterViewModel viewModelWithOwner:self];
    }
    return _viewModel;
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

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([indexPath section] == 3) {
        NSDictionary *postDict = @{ @"urls": @"http://www.henishuo.com/git-use-inwork/",
                                    @"goal" : @"site",
                                    @"total" : @(123)
                                    };
        [self.fetcher postToUrl:@"http://data.zz.baidu.com/urls?site=www.henishuo.com&token=bRidefmXoNxIi3Jp" withParamer:postDict withRequestHeader:nil isSerialQueue:YES withProgressHandler:nil
             withSuccessHandler:^(NSDictionary *dict,NSError *error) {
                 LFLLog(@"1");
        } withFailedHandler:^(NSError *error) {
                LFLLog(@"1");
        }];
    } else if ([indexPath section] == 2) {
        [self fetchUserInfoFromCoreData];
    } else if ([indexPath section] == 1) {
        if ([indexPath row] == 0) {
            
        }
    }
}

- (void)fetchUserInfoFromCoreData {
    id newObject = nil;
    Class entityClass = [self provideClass];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"user_name = 'zxf'"]];
    newObject = [entityClass MR_findFirstWithPredicate:predicate inContext:[[LFLFetcherManager shareInstance] context]];
    if (!newObject) {
        newObject = [entityClass MR_createEntityInContext:[[LFLFetcherManager shareInstance] context]];
        [newObject setValue:@"zxf" forKey:@"user_name"];
        [newObject setValue:@(1) forKey:@"sex"];
        [newObject setValue:@(23) forKey:@"age"];
        if ([[[LFLFetcherManager shareInstance] context] hasChanges]) {
            [[[LFLFetcherManager shareInstance] context] MR_saveToPersistentStoreAndWait];
        }
    } else {
        LFLUserInfo *userInfo = [LFLFetcher firstObjectWithPredicate:predicate sortedBy:nil entityClass:[LFLUserInfo class]];
        userInfo.age = @(26);
        [LFLFetcher updateObjectPropertyWith:userInfo];
    }
}

- (Class)provideClass {
    return NSClassFromString(@"LFLUserInfo");
}
@end
