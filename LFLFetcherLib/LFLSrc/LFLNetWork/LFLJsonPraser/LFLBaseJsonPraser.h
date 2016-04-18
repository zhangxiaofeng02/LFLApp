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

/**
 * 根据praser类型生成对应的json解析器队列，传入的是NSData
 **/
+ (LFLBaseJsonPraser *)createParserWithClass:(Class)parserClass initWithData:(NSData *)data;

/**
 * 根据praser类型生成对应的json解析器队列，传入的是Json
 **/
+ (LFLBaseJsonPraser *)createParserWithClass:(Class)parserClass initWithJson:(NSDictionary *)json;

/**
 * 解析完成回调
 **/
@property (nonatomic, copy) LFLJsonPraserFinishHandler finishHandler;

/**
 * 解析失败回调
 **/
@property (nonatomic, copy) LFLJsonPraserFailedHandler failedHandler;
@end
