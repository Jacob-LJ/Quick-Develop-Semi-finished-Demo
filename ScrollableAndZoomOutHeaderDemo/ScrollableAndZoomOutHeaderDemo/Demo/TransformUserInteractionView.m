//
//  TransformUserInteractionView.m
//  hunlimao
//
//  Created by Jacob on 16/10/9.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "TransformUserInteractionView.h"

@implementation TransformUserInteractionView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return [super hitTest:point withEvent:event];
    }
    
    //判断触摸事件点击的点是否在当前的view上
    if ([self pointInside:point withEvent:event]) {
        if (self.targetView) {
            
            for (UIView *subview in [self.targetView.subviews reverseObjectEnumerator]) {
                CGPoint convertedPoint = [subview convertPoint:point fromView:self];
                UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
                if (hitTestView) {
                    return hitTestView;
                }
            }
            
            return self.targetView;
        }
    }
    
    return [super hitTest:point withEvent:event];
}

@end
