//
//  LFLDiscoverFriendsReadingCell.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/5/16.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLDiscoverFriendsReadingCell.h"
#import "LFLDiscoverBookBackView.h"
#import "LFLDiscoverFriendIconCell.h"

@interface LFLDiscoverFriendsReadingCell() <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet LFLDiscoverBookBackView *bookBackView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UILabel *bookDes;
@property (weak, nonatomic) IBOutlet UILabel *bookWriter;
@property (weak, nonatomic) IBOutlet UICollectionView *friendIconCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *friendReading;
@property (weak, nonatomic) IBOutlet UILabel *recommondCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bookWriterTobookNameSpacing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recommondLabelWidthCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *friendIconCollectionViewWidthCons;
@property (weak, nonatomic) IBOutlet UIView *friendView;
@property (weak, nonatomic) IBOutlet UIView *recommondView;

@property (strong, nonatomic) NSArray *friendIconArr;
@end
@implementation LFLDiscoverFriendsReadingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.borderWidth = 1 / ScreenScale;
    self.backView.layer.borderColor = Color(193, 193, 195, 1).CGColor;
    [self.friendIconCollectionView LFLRegisterNibWithClass:[LFLDiscoverFriendIconCell class] bundle:@"LFLTrunkBundle"];
    self.friendIconCollectionView.collectionViewLayout = [self provideLayout];
    [self.friendIconCollectionView setBackgroundColor:[UIColor clearColor]];
    self.friendIconCollectionView.dataSource = self;
    self.friendIconCollectionView.delegate = self;
}

- (void)configCellWithDictionary:(NSDictionary *)dict {
    NSString *bookName = dict[@"book_name"] == nil ? @"" : dict[@"book_name"];
    NSString *bookDes = dict[@"book_des"] == nil ? @"" : dict[@"book_des"];
    NSString *bookWriter = dict[@"book_writer"] == nil ? @"" : dict[@"book_writer"];
    NSString *friendReading = dict[@"friend_reading"] == nil ? @"" : dict[@"friend_reading"];
    NSString *recommond = dict[@"recommond"] == nil ? @"" : dict[@"recommond"];
//    NSString *bookImg = dict[@"book_img"] == nil ? @"" : dict[@"book_img"];
    NSArray *friendIcon = dict[@"friend_icon"] == nil ? @"" : dict[@"friend_icon"];
    //bookName
    [self.bookName setText:bookName];
    //bookDes
    if (bookDes || bookDes.length == 0) {
        [self.bookDes setHidden:YES];
        self.bookWriterTobookNameSpacing.constant = 20;
    } else {
        [self.bookDes setHidden:NO];
        self.bookWriterTobookNameSpacing.constant = 50;
        [self.bookDes setText:bookDes];
    }
    //bookWriter
    [self.bookWriter setText:bookWriter];
    //friendReading
    [self.friendReading setText:friendReading];
    //recommond
    CGFloat width = [recommond contentWidthWithHeight:11 font:11];
    self.recommondLabelWidthCons.constant = width;
    [self.recommondCountLabel setText:recommond];
    //friendIcon
    self.friendIconArr = friendIcon;
    if (friendIcon && friendIcon.count) {
        self.friendIconCollectionViewWidthCons.constant = friendIcon.count * 36 + (friendIcon.count - 1) * 7 + 7*2;
    } else {
        self.friendIconCollectionViewWidthCons.constant = 0;
    }
    [self.friendIconCollectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.friendIconArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LFLDiscoverFriendIconCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LFLDiscoverFriendIconCell" forIndexPath:indexPath];
    NSString *iconUrl = self.friendIconArr[[indexPath row]];
    [cell configCellWithUrl:iconUrl];
    return cell;
}

- (UICollectionViewLayout *)provideLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0,7,0,7);
    layout.minimumLineSpacing = 7;
    layout.minimumInteritemSpacing = 0;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.itemSize = CGSizeMake(36, 36);
    return layout;
}
@end
