//
//  UIImageView+CornerTool.m
//  CornerRadius(simpleViewOrImageView-etc)
//
//  Created by Jacob_Liang on 16/11/1.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "UIImageView+CornerTool.h"
#import "UIImage+ImageCornerTool.h"

@implementation UIImageView (CornerTool)
/**
 / !!!只有当 imageView 不为nil 时，调用此方法才有效果

 :param: radius 圆角半径
 */
- (void)addingCornerWithRadius:(CGFloat)radius {
    self.image = [self.image imageAddindCornerWithRadius:radius andSize:self.bounds.size];
}

@end
