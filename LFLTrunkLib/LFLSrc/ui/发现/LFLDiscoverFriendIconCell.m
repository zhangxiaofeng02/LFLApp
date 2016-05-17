//
//  LFLDiscoverFriendIconCell.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/5/17.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLDiscoverFriendIconCell.h"
@interface LFLDiscoverFriendIconCell()
@property (weak, nonatomic) IBOutlet UIImageView *friendIconImageView;

@end

@implementation LFLDiscoverFriendIconCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.friendIconImageView.layer.cornerRadius = self.friendIconImageView.frame.size.width / 2;
}

- (void)configCellWithUrl:(NSString *)url {
    [self.friendIconImageView setImage:[LFLTrunkBundle imageName:@"test"]];
}
@end
