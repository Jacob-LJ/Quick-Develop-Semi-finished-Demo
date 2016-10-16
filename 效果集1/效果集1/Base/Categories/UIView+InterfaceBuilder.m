//
//  UIView+InterfaceBuilder.m
//  hunlimao
//
//  Created by Eugene on 15/6/29.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "UIView+InterfaceBuilder.h"

@implementation UIView (InterfaceBuilder)

- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setMasksToBounds:(BOOL)masksToBounds{
    self.layer.masksToBounds = YES;
}

- (BOOL)masksToBounds{
    return self.layer.masksToBounds;
}
@end
