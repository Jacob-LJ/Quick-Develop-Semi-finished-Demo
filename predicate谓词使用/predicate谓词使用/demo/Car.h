//
//  Car.h
//  predicate谓词使用
//
//  Created by Jacob_Liang on 16/10/20.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Engine;

@interface Car : NSObject

@property (nonatomic, copy) NSString *name; //车名
@property (nonatomic, copy) NSString *brandName; //品牌
@property (nonatomic, strong) Engine *engine; //引擎名称
@property (nonatomic, assign) NSInteger yearNum; //年份
@property (nonatomic, assign) NSInteger doorNum;//几门
@property (nonatomic, assign) NSInteger distance;//行程

+ (instancetype)makeCarByName:(NSString *)name brandName:(NSString *)brandName enginName:(NSString *)enginName yearNum:(NSInteger)yearNum doorNum:(NSInteger)doorNum distance:(NSInteger)distance power:(NSInteger)power;

@end
