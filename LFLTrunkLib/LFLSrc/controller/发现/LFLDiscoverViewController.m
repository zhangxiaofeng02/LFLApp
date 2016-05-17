//
//  LFLDiscoverViewController.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/5/16.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLDiscoverViewController.h"
#import "LFLDiscoverFriendsReadingCell.h"

@interface LFLDiscoverViewController ()

@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation LFLDiscoverViewController {
    UIImageView *_onePixLineUnderNaigationBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView setBackgroundColor:Color(241, 242, 245, 1)];
    self.collectionView.collectionViewLayout = [self provideLayout];
    [self registerCell];
    _onePixLineUnderNaigationBar =  [self LFLFindHairlineImageViewUnder:self.navigationController.navigationBar];
    [_onePixLineUnderNaigationBar setHidden:YES];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.dataSource = [LFLLocalDataSource discoverDataSource];
}

- (void)registerCell {
    [self.collectionView LFLRegisterNibWithClass:[LFLDiscoverFriendsReadingCell class] bundle:@"LFLTrunkBundle"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar LFLSetBackgroundColor:Color(241,242,245,1)];
    [_onePixLineUnderNaigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar LFLRemoveBackgroundView];
    [_onePixLineUnderNaigationBar setHidden:NO];
}

#pragma mark UICollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LFLDiscoverFriendsReadingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LFLDiscoverFriendsReadingCell" forIndexPath:indexPath];
    NSDictionary *dic = self.dataSource[[indexPath row]];
    [cell configCellWithDictionary:dic];
    return cell;
}

#pragma mark ColletionViewLayout
- (UICollectionViewLayout *)provideLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(DiscoverCardTopMargin,DiscoverCardLeftRightMargin,DiscoverCardBottomMargin,DiscoverCardLeftRightMargin);
    layout.minimumLineSpacing = DiscoverCardLineSpacing;
    layout.minimumInteritemSpacing = 0;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    if (iPhone6) {
        layout.itemSize = CGSizeMake(DiscoverCardWidthIPhone6, ScreenHeight - NagivationBarHeight - TabBarHeight - DiscoverCardTopMargin - DiscoverCardBottomMargin);
    } else if (iPhone6Plus) {
        layout.itemSize = CGSizeMake(DiscoverCardWidthIPhone6P, ScreenHeight - NagivationBarHeight - TabBarHeight - DiscoverCardTopMargin - DiscoverCardBottomMargin);
    }
    return layout;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGPoint originalTargetContentOffset = CGPointMake(targetContentOffset->x, targetContentOffset->y);
    CGPoint targetCenter = CGPointMake(originalTargetContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2, CGRectGetHeight(self.collectionView.bounds) / 2);
    NSIndexPath *indexPath = nil;
    NSInteger i = 0;
    while (indexPath == nil) {
        targetCenter = CGPointMake(originalTargetContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2 + 10*i, CGRectGetHeight(self.collectionView.bounds) / 2);
        indexPath = [self.collectionView indexPathForItemAtPoint:targetCenter];
        i++;
    }
    //这里用attributes比用cell要好很多，因为cell可能因为不在屏幕范围内导致cellForItemAtIndexPath返回nil
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
    if (attributes) {
        *targetContentOffset = CGPointMake(attributes.center.x - CGRectGetWidth(self.collectionView.bounds)/2, originalTargetContentOffset.y);
    }
}
@end
