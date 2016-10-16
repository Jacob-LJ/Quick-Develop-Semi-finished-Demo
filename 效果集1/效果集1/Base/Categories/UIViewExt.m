/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import "UIViewExt.h"

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView (ViewGeometry)

// Retrieve and set the origin
- (CGPoint) origin
{
	return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
	CGRect newframe = self.frame;
	newframe.origin = aPoint;
	self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) size
{
	return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
	CGRect newframe = self.frame;
	newframe.size = aSize;
	self.frame = newframe;
}

// Query other frame locations
- (CGPoint) bottomRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint) bottomLeft
{
	CGFloat x = self.frame.origin.x;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint) topRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y;
	return CGPointMake(x, y);
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

// Retrieve and set height, width, top, bottom, left, right
- (CGFloat) height
{
	return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight
{
	CGRect newframe = self.frame;
	newframe.size.height = newheight;
	self.frame = newframe;
}

- (CGFloat) width
{
	return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth
{
	CGRect newframe = self.frame;
	newframe.size.width = newwidth;
	self.frame = newframe;
}

- (CGFloat) top
{
	return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
	CGRect newframe = self.frame;
	newframe.origin.y = newtop;
	self.frame = newframe;
}

- (CGFloat) left
{
	return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
	CGRect newframe = self.frame;
	newframe.origin.x = newleft;
	self.frame = newframe;
}

- (CGFloat) bottom
{
	return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
	CGRect newframe = self.frame;
	newframe.origin.y = newbottom - self.frame.size.height;
	self.frame = newframe;
}

- (CGFloat) right
{
	return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
	CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
	CGRect newframe = self.frame;
	newframe.origin.x += delta ;
	self.frame = newframe;
}

// Move via offset
- (void) moveBy: (CGPoint) delta
{
	CGPoint newcenter = self.center;
	newcenter.x += delta.x;
	newcenter.y += delta.y;
	self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
	CGRect newframe = self.frame;
	newframe.size.width *= scaleFactor;
	newframe.size.height *= scaleFactor;
	self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
	CGFloat scale;
	CGRect newframe = self.frame;
	
	if (newframe.size.height && (newframe.size.height > aSize.height))
	{
		scale = aSize.height / newframe.size.height;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	if (newframe.size.width && (newframe.size.width >= aSize.width))
	{
		scale = aSize.width / newframe.size.width;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	self.frame = newframe;	
}

- (void)roundCorners:(UIRectCorner)corner radius:(CGFloat)radius{
    
    CGRect bounds = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:corner
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    
    CAShapeLayer*   frameLayer = [CAShapeLayer layer];
    frameLayer.frame = bounds;
    frameLayer.path = maskPath.CGPath;
//    frameLayer.strokeColor = [UIColor redColor].CGColor;
    frameLayer.fillColor = nil;
    
    [self.layer addSublayer:frameLayer];
}

-(void)roundTopCornersRadius:(CGFloat)radius
{
    [self roundCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) radius:radius];
}

-(void)roundBottomCornersRadius:(CGFloat)radius
{
    [self roundCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) radius:radius];
}

- (void)roundLeftCornerRadius:(CGFloat)radius{
    [self roundCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) radius:radius];
}

- (void)roundRightCornerRadius:(CGFloat)radius{
    [self roundCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) radius:radius];
}

- (void)topBorderWidth:(CGFloat)width color:(UIColor *)color{
    CALayer* layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, self.width, width);
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}
- (void)leftBorderWidth:(CGFloat)width color:(UIColor *)color{
    CALayer* layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, width, self.height);
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}
- (void)bottomBorderWidth:(CGFloat)width color:(UIColor *)color{
    CALayer* layer = [CALayer layer];
    layer.frame = CGRectMake(0, self.height - width, self.width, width);
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}
- (void)rightBorderWidth:(CGFloat)width color:(UIColor *)color{
    CALayer* layer = [CALayer layer];
    layer.frame = CGRectMake(self.width - width, 0, width, self.height);
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}

- (UIViewController *)viewController{
    UIResponder *nextRes = [self nextResponder];
    
    do {
        if ([nextRes isKindOfClass:[UIViewController class]]) {
            return  (UIViewController *)nextRes;
            
        }
        nextRes = [nextRes nextResponder];
    } while (nextRes != nil);
    return nil;
}



@end