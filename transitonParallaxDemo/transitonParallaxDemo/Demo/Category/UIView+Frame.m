//
//  UIView+Frame.m
//  transitonParallaxDemo
//
//  Created by Jacob on 16/11/19.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)


- (void)setHlm_x:(CGFloat)hlm_x {
    CGRect frame = self.frame;
    frame.origin.x = hlm_x;
    self.frame = frame;
}

- (void)setHlm_y:(CGFloat)hlm_y {
    CGRect frame = self.frame;
    frame.origin.y = hlm_y;
    self.frame = frame;
}

- (void)setHlm_width:(CGFloat)hlm_width {
    CGRect frame = self.frame;
    frame.size.width = hlm_width;
    self.frame = frame;
}

- (void)setHlm_height:(CGFloat)hlm_height {
    CGRect frame = self.frame;
    frame.size.height = hlm_height;
    self.frame = frame;
}

- (CGFloat)hlm_x {
    return self.frame.origin.x;
}

- (CGFloat)hlm_y {
    return self.frame.origin.y;
}

- (CGFloat)hlm_width {
    return self.frame.size.width;
}

- (CGFloat)hlm_height {
    return self.frame.size.height;
}

- (CGFloat)hlm_bottom {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)hlm_right {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)hlm_centerX {
    return self.center.x;
}

- (CGFloat)hlm_centerY {
    return self.center.y;
}

- (void)setHlm_centerX:(CGFloat)hlm_centerX {
    CGPoint center = self.center;
    center.x = hlm_centerX;
    self.center = center;
}

- (void)setHlm_centerY:(CGFloat)hlm_centerY {
    CGPoint center = self.center;
    center.y = hlm_centerY;
    self.center = center;
}

+ (instancetype)viewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (UIViewController *)hlm_viewController {
    UIResponder *nextRes = [self nextResponder];
    
    do {
        if ([nextRes isKindOfClass:[UIViewController class]]) {
            return  (UIViewController *)nextRes;
            
        }
        nextRes = [nextRes nextResponder];
    } while (nextRes != nil);
    return nil;
}

- (void)detectScrollsToTopViews {
    for (UIView* view in self.subviews) {
        if ([view isKindOfClass:UIScrollView.class]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            scrollView.scrollsToTop = NO;
        }
        
        [view detectScrollsToTopViews];
    }
}

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(JAOscillatoryAnimationType)type{
    NSNumber *animationScale1 = type == JAOscillatoryAnimationToBigger ? @(1.15) : @(0.5);
    NSNumber *animationScale2 = type == JAOscillatoryAnimationToBigger ? @(0.92) : @(1.15);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}

@end
