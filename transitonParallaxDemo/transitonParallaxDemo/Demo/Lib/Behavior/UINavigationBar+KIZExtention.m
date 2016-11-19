//
//  UINavigationBar+KIZExtention.m
//  KIZParallaTableDemo
//
//  Created by kingizz on 15/10/3.
//  Copyright © 2015年 kingizz. All rights reserved.
//

#import "UINavigationBar+KIZExtention.h"
#import <objc/runtime.h>
//#import "UIImage+Util.h"

static char originBackgroundImage;
static char originShadowImage;
static char backgroundView;

@implementation UINavigationBar (KIZExtention)

#pragma mark- getters & setters
- (UIImage *)kiz_originBackgroundImage{
    return objc_getAssociatedObject(self, &originBackgroundImage);
}
- (void)kiz_setOriginBackgroundImage:(UIImage *)image{
    objc_setAssociatedObject(self, &originBackgroundImage, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)kiz_originShadowImage{
    return objc_getAssociatedObject(self, &originShadowImage);
}

- (void)kiz_setOriginShadowImage:(UIImage *)image{
    objc_setAssociatedObject(self, &originShadowImage, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)kiz_backgroundView{
    return objc_getAssociatedObject(self, &backgroundView);
}

- (void)kiz_setBackgroundView:(UIView *)view{
    objc_setAssociatedObject(self, &backgroundView, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/**
 当弹出第一个 控制器的时候，navItem会出现莫名的frame问题，第一个控制器的navItem的设置最好放在viewWillAppear里面
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self insertSubview:self.lp_backgroundView atIndex:0];
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGFloat alpha, white;
    
    [self.lp_backgroundView.backgroundColor getWhite:&white alpha:&alpha];
    
    if (alpha == 0 || white == 0) {
        return nil;
    }
    
    return [super hitTest:point withEvent:event];
}

- (UIView *)lp_backgroundView {
    
    [self checkoutBackgroundView];
    
    return self.kiz_backgroundView;
}

- (void)checkoutBackgroundView {
    
    if (![self kiz_backgroundView]) {
        
        [self kiz_setOriginBackgroundImage:[self backgroundImageForBarMetrics:UIBarMetricsDefault]];
        [self kiz_setOriginShadowImage:self.shadowImage];
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new]];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + 20)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.userInteractionEnabled = NO;
        [self insertSubview:bgView atIndex:0];
        [self kiz_setBackgroundView:bgView];
        
        UIView *seperateView = [[UIView alloc] initWithFrame:CGRectMake(0, bgView.bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0.5)];
        [bgView addSubview:seperateView];
        seperateView.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    }
    
}

- (void)setLp_hideSeperateView:(BOOL)lp_hideSeperateView {
    
    self.lp_backgroundView.subviews.firstObject.hidden = lp_hideSeperateView;
    
}

#pragma mark -

- (void)kiz_setBackgroundAlpha:(CGFloat)alpha{
    
    if (alpha >= 0 && alpha <= 0.01) {
        alpha = 0.01;
    }
    
    [self kiz_setBackgroundColor:[self.barTintColor colorWithAlphaComponent:alpha]];
}

- (void)kiz_setBackgroundColor:(UIColor *)color{
    
    [self checkoutBackgroundView];
    
    self.kiz_backgroundView.backgroundColor = color;

}

- (void)kiz_reset{
    [self setBackgroundImage:self.kiz_originBackgroundImage ?: [UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:self.kiz_originShadowImage ?: [UIImage new]];
    
    [self kiz_setOriginBackgroundImage:nil];
    [self kiz_setOriginShadowImage:nil];
    
    self.lp_backgroundView.backgroundColor = [UIColor whiteColor];

    
}


@end
