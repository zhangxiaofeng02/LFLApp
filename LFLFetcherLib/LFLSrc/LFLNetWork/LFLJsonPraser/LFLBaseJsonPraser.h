//
//  LFLJsonPraser.h
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/11.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LFLJsonPraserFinishHandler)(NSDictionary *result);
typedef void(^LFLJsonPraserFailedHandler)(NSDictionary *result);

@interface LFLBaseJsonPraser : NSOperation {
    id _jsonObj;
}

+ (LFLBaseJsonPraser *)createParserWithClass:(Class)parserClass initWithData:(NSData *)data;
+ (LFLBaseJsonPraser *)createParserWithClass:(Class)parserClass initWithJson:(NSDictionary *)json;

@property (nonatomic, copy) LFLJsonPraserFinishHandler finishHandler;
@property (nonatomic, copy) LFLJsonPraserFailedHandler failedHandler;
@end
