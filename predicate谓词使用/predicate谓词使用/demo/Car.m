//
//  Car.m
//  predicate谓词使用
//
//  Created by Jacob_Liang on 16/10/20.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "Car.h"
#import "Engine.h"

@implementation Car
+ (instancetype)makeCarByName:(NSString *)name brandName:(NSString *)brandName enginName:(NSString *)enginName yearNum:(NSInteger)yearNum doorNum:(NSInteger)doorNum distance:(NSInteger)distance power:(NSInteger)power {
    
    Car *car = [[Car alloc ] init];
    
    Engine *engine = [[Engine alloc] init];
    engine.name = enginName;
    engine.horsepower = power;
    
    car.name = name;
    car.brandName = brandName;
    car.engine = engine;
    car.yearNum = yearNum;
    car.doorNum = doorNum;
    car.distance = distance;
    return car;
}
    
@end
