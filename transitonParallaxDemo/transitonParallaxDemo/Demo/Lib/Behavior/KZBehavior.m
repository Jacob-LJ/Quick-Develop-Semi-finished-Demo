//
//  KZBehavior.m
//  hunlimao
//
//  Created by Eugene on 15/5/8.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "KZBehavior.h"
#import <objc/runtime.h>

@implementation KZBehavior

//- (void)setOwner:(id)owner
//{
//    if (_owner != owner) {
//        [self releaseLifetimeFromObject:_owner];
//        _owner = owner;
//        [self bindLifetimeToObject:_owner];
//    }
//}

- (void)bindLifetimeToObject:(id)object
{
    objc_setAssociatedObject(object, (__bridge void *)self, self,   OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)releaseLifetimeFromObject:(id)object
{
    objc_setAssociatedObject(object, (__bridge void *)self, nil,    OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)dealloc{
    NSLog(@"👻%@->%s", NSStringFromClass(self.class), __PRETTY_FUNCTION__);
}

@end
