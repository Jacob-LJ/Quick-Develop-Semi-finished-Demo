//
//  UIImage+ImageCornerTool.m
//  CornerRadius(simpleViewOrImageView-etc)
//
//  Created by Jacob_Liang on 16/10/31.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "UIImage+ImageCornerTool.h"

@implementation UIImage (ImageCornerTool)

- (UIImage *)imageAddindCornerWithRadius:(CGFloat)radius andSize:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *RoundedPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(context,RoundedPath.CGPath);
    CGContextClip(context);
    [self drawInRect:rect];
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *cornerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return cornerImage;
}

@end
