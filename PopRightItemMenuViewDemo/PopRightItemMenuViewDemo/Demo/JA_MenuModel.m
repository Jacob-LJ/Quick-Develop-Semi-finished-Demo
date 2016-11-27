//
//  JA_MenuModel.m
//  PopRightItemMenuViewDemo
//
//  Created by Jacob_Liang on 16/11/27.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "JA_MenuModel.h"

@implementation JA_MenuModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)MenuModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


@end
