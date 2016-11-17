//
//  SmithPerson.m
//  在类的初始化方法中应该直接调用实例变量
//
//  Created by Jacob_Liang on 16/11/17.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "SmithPerson.h"

@implementation SmithPerson

- (void)setLastName:(NSString *)lastName {
    if (![lastName isEqualToString:@"Smith"]) {
        [NSException raise:NSInvalidArgumentException format:@"Last name must be Smith"];
    }
    self.lastName = lastName;
}

@end
