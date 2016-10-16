//
//  UIView+InterfaceBuilder.h
//  hunlimao
//
//  Created by Eugene on 15/6/29.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (InterfaceBuilder)

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable BOOL masksToBounds;
@end
