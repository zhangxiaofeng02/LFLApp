//
//  LFLUserCenterCustomTableViewCell.m
//  LFLTrunkLib
//
//  Created by 啸峰 on 16/4/7.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLUserCenterCustomTableViewCell.h"
@interface LFLUserCenterCustomTableViewCell()
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *goImageView;
@property (strong, nonatomic) IBOutlet UIView *bottomDividView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomDividViewHeightCons;
@property (strong, nonatomic) IBOutlet UIView *topDividView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topDividViewHeightCon;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomDividLeadingCons;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topDividLeadingCons;

@end

@implementation LFLUserCenterCustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bottomDividViewHeightCons.constant = 1 / ScreenScale;
    [self.bottomDividView setBackgroundColor:Color(217.0f, 217.0f, 217.0f, 1)];
    self.topDividViewHeightCon.constant = 1 / ScreenScale;
    [self.topDividView setBackgroundColor:Color(217.0f, 217.0f, 217.0f, 1)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configCellWithDictionary:(NSDictionary *)dict {
    NSString *title = dict[@"title"] == nil ? @"" : dict[@"title"];
//    NSString *icon = dict[@"icon"] == nil ? @"" : dict[@"icon"];
    NSString *location = dict[@"location"];
    [self.titleLabel setText:title];
    if (location && location.length) {
        [self.topDividView setHidden:NO];
        if ([@"top" isEqualToString:location]) {
            self.topDividLeadingCons.constant = 0;
            self.bottomDividLeadingCons.constant = 14;
        } else if ([@"bottom" isEqualToString:location]){
            [self.topDividView setHidden:YES];
            self.topDividLeadingCons.constant = 14;
            self.bottomDividLeadingCons.constant = 0;
        } else if ([@"whole" isEqualToString:location]){
            self.topDividLeadingCons.constant = 0;
            self.bottomDividLeadingCons.constant = 0;
        }
    } else {
        [self.topDividView setHidden:YES];
    }
}
@end
