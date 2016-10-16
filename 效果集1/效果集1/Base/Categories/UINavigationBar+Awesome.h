//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Awesome)
/**
 *  设置导航栏背景颜色
 *
 *  @param backgroundColor
 */
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
/**
 *  设置导航栏上按钮的透明度
 *
 *  @param alpha
 */
- (void)lt_setContentAlpha:(CGFloat)alpha;
/**
 *  设置导航栏Y坐标偏移量
 *
 *  @param translationY
 */
- (void)lt_setTranslationY:(CGFloat)translationY;
/**
 *  重置导航栏状态，恢复到原来的状态
 */
- (void)lt_reset;
@end
