//
//  LFLFetcher.h
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/10.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol LFLFetcherDelegate <NSFetchedResultsControllerDelegate>

@end

@interface LFLFetcher : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) id<LFLFetcherDelegate> fetcherDelegate;
@end
