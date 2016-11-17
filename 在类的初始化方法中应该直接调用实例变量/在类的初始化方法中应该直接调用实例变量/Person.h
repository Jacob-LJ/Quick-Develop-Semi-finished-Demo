//
//  Person.h
//  在类的初始化方法中应该直接调用实例变量
//
//  Created by Jacob_Liang on 16/11/17.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

@end
