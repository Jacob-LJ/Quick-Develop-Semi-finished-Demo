//
//  Person.m
//  在类的初始化方法中应该直接调用实例变量
//
//  Created by Jacob_Liang on 16/11/17.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)init {
    if (self =  [super init]) {
//        self.lastName = nil; //通过 setter 方法在父类中置nil,子类 复写了 setter 方法的 子类 SmithPerson 创建的时候就会报错, 所以"不应该在 init 或 dealloc 方法中调用 getter&setter 方法,而应该直接使用实例变量进行初始化赋值"
        _lastName = nil; //正确做法
    }
    return self;
}

@end
