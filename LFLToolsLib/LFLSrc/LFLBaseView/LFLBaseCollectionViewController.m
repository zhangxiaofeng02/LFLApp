//
//  LFLBaseCollectionViewController.m
//  LFLToolsLib
//
//  Created by 啸峰 on 16/5/16.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLBaseCollectionViewController.h"
#import "LFLBaseCollectionView.h"

@interface LFLBaseCollectionViewController ()

@end

@implementation LFLBaseCollectionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark private method
- (void)configCollectionView {
    LFLBaseCollectionView *collectionView = [[LFLBaseCollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:[self provideLayout]];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    [collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *viewsDict = NSDictionaryOfVariableBindings(self.view,collectionView);
    NSMutableArray *contsArr = [NSMutableArray array];
    [contsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-(%f)-[collectionView]-(%f)-|",self.collectionViewMargin.left,self.collectionViewMargin.right] options:0 metrics:nil views:viewsDict]];
    [contsArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-(%f)-[collectionView]-(%f)-|",self.collectionViewMargin.top,self.collectionViewMargin.bottom] options:0 metrics:nil views:viewsDict]];
    [self.view addConstraints:contsArr];
    collectionView.delegate = self;
    collectionView.dataSource = self;
}

- (UIEdgeInsets)collectionViewMargin {
    if (self.navigationController.navigationBar.translucent) {
        return UIEdgeInsetsMake(64, 0, 49, 0);
    }
    return UIEdgeInsetsMake(0, 0, 49, 0);
}

- (UICollectionViewLayout *)provideLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.itemSize = CGSizeMake(0, 0);
    return layout;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark <UICollectionViewDelegate>
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
@end
