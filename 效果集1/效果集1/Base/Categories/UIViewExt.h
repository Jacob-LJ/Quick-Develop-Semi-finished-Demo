/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)
@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

- (void)roundCorners:(UIRectCorner)corner radius:(CGFloat)radius;

- (void)roundTopCornersRadius:(CGFloat)radius;
- (void)roundBottomCornersRadius:(CGFloat)radius;
- (void)roundLeftCornerRadius:(CGFloat)radius;
- (void)roundRightCornerRadius:(CGFloat)radius;

- (void)topBorderWidth:(CGFloat)width color:(UIColor *)color;
- (void)leftBorderWidth:(CGFloat)width color:(UIColor *)color;
- (void)bottomBorderWidth:(CGFloat)width color:(UIColor *)color;
- (void)rightBorderWidth:(CGFloat)width color:(UIColor *)color;

- (UIViewController *)viewController;
@end