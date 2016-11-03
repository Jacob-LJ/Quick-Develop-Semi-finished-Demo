//
//  UIView+CornerTool.h
//  CornerRadius(simpleViewOrImageView-etc)
//
//  Created by Jacob_Liang on 16/11/1.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerTool)

- (void)ja_addingCornerWithRadius:(CGFloat)radius;
- (void)ja_addingCornerWithRadius:(CGFloat)radius andBorderWidth:(CGFloat)borderWidth andBackgroundColor:(UIColor *)backgroundColor andBorderColor:(UIColor *)borderColor;
@end
