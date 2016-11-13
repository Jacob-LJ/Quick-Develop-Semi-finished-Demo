//
//  UINavigationBar+KIZExtention.h
//  KIZParallaTableDemo
//
//  Created by kingizz on 15/10/3.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (KIZExtention)

@property (nonatomic, weak) UIView *lp_backgroundView; //nav的背景view

@property (nonatomic, assign) BOOL lp_hideSeperateView; //是否隐藏nav底部分割线的view

- (void)kiz_setBackgroundAlpha:(CGFloat)alpha;

- (void)kiz_setBackgroundColor:(UIColor *)color;

- (void)kiz_reset;

@end
