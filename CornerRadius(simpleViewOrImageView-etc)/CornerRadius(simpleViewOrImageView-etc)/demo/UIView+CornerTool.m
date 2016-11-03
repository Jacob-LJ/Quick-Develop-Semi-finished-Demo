//
//  UIView+CornerTool.m
//  CornerRadius(simpleViewOrImageView-etc)
//
//  Created by Jacob_Liang on 16/11/1.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "UIView+CornerTool.h"
#import "UIImageView+CornerTool.h"

@implementation UIView (CornerTool)

- (double)roundbyunitWithNum:(double)num andUnit:(double *)unit {
    double remian = modf(num, unit);
    if (remian > *unit / 2.0) {
        return [self ceilByUnit:num andUnit:unit];
    } else {
        return [self floorByUnit:num andUnit:unit];
    }
    
}

- (double)ceilByUnit:(double)num andUnit:(double *)unit {
    return num - modf(num, unit) + *unit;
}

- (double)floorByUnit:(double)num andUnit:(double *)unit {
    return num - modf(num, unit);
}

- (double)pixel:(double)num {
    double unit = 0.0;
    switch ((int)[UIScreen mainScreen].scale) {
        case 1:
            unit = 1.0 / 1.0;
            break;
        case 2:
            unit = 1.0 / 2.0;
            break;
        case 3:
            unit = 1.0 / 3.0;
            break;
            
        default:
            unit = 0.0;
            break;
    }
    return [self roundbyunitWithNum:num andUnit:&unit];
    
}

- (void)ja_addingCornerWithRadius:(CGFloat)radius {
    [self ja_addingCornerWithRadius:radius andBorderWidth:1 andBackgroundColor:[UIColor clearColor] andBorderColor:[UIColor blackColor]];
}

- (void)ja_addingCornerWithRadius:(CGFloat)radius andBorderWidth:(CGFloat)borderWidth andBackgroundColor:(UIColor *)backgroundColor andBorderColor:(UIColor *)borderColor {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self ja_drawRectWithRoundedCornerImageWithRadius:radius borderWidth:borderWidth backgroundColor:backgroundColor borderColor:borderColor]];
    
    [self insertSubview:imageView atIndex:0];
}

- (UIImage *)ja_drawRectWithRoundedCornerImageWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor {
    
    CGSize sizeToFit = CGSizeMake([self pixel:(double)self.bounds.size.width], [self pixel:(double)self.bounds.size.height]);
    CGFloat halfBorderWidth = (CGFloat)borderWidth/2.0;
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    
    CGFloat width = sizeToFit.width;
    CGFloat height = sizeToFit.height;
    
    CGContextMoveToPoint(context, width - halfBorderWidth, radius + halfBorderWidth);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);  // 右下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius); // 右上角
    
    CGContextDrawPath(context, kCGPathFillStroke);
//    CGContextDrawPath(UIGraphicsGetCurrentContext(), .FillStroke)
    UIImage *roundedCornerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return roundedCornerImage;
    
}

@end
