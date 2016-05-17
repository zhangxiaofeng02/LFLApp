//
//  LFLBaseCollectionViewController.h
//  LFLToolsLib
//
//  Created by 啸峰 on 16/5/16.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFLBaseViewController.h"

@interface LFLBaseCollectionViewController : LFLBaseViewController <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@end
