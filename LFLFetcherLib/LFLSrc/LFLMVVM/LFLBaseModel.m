//
//  LFLBaseModel.m
//  LFLFetcherLib
//
//  Created by 啸峰 on 16/4/21.
//  Copyright © 2016年 张啸峰. All rights reserved.
//

#import "LFLBaseModel.h"
#import <objc/runtime.h>
#import "EasyTransModel.h"

@implementation LFLBaseModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadModel];
    }
    return self;
}

+ (id)Model {
    return [[self alloc] init];
}

- (void)loadModel {
    
}

- (BOOL)isEmpty {
    NSArray *array = [self getPropertyList:[self class]];
    __block BOOL isEmpty = YES;
    [array each:^(NSString *key) {
        if ([self valueForKey:key]) {
            isEmpty = NO;
        }
    }];
    return isEmpty;
}


- (NSArray *)getPropertyList:(Class)klass{
    NSMutableArray *propertyNamesArray = [NSMutableArray array];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(klass, &propertyCount);
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        [propertyNamesArray addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    return propertyNamesArray;
}
@end
