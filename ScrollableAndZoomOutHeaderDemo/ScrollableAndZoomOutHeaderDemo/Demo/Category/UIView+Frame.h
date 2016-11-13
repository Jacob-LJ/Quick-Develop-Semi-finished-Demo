//
//  UIView+Frame.h
//  hunlimao
//
//  Created by Allen on 16/3/3.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>

//屏幕宽高
#define HLMScreenW [UIScreen mainScreen].bounds.size.width
#define HLMScreenH [UIScreen mainScreen].bounds.size.height
#define HLMNavBarH (64)
//全局颜色
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

typedef enum : NSUInteger {
    JAOscillatoryAnimationToBigger,
    JAOscillatoryAnimationToSmaller,
} JAOscillatoryAnimationType;

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat hlm_x;
@property (nonatomic, assign) CGFloat hlm_y;
@property (nonatomic, assign) CGFloat hlm_width;
@property (nonatomic, assign) CGFloat hlm_height;

@property (nonatomic, assign, readonly) CGFloat hlm_bottom;
@property (nonatomic, assign, readonly) CGFloat hlm_right;
@property (nonatomic, assign) CGFloat hlm_centerX;
@property (nonatomic, assign) CGFloat hlm_centerY;

+ (instancetype)viewFromXib;
- (UIViewController *)hlm_viewController;
- (void)detectScrollsToTopViews;


/**
 放大缩小的震动效果
 
 @param layer view的layer
 @param type  放大 / 缩小 类型
 */
+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(JAOscillatoryAnimationType)type;

@end
