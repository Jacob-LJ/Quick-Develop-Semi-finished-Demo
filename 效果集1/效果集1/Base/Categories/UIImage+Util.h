//
//  UIImage+Util.h
//  hunlimao
//
//  Created by Eugene on 15/4/22.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

+ (UIImage*) imageWithColor: (UIColor*) color;

+ (UIImage*) imageWithColor: (UIColor*) color alpha:(CGFloat)alpha;

+ (UIImage *)captureScreen;

- (UIImage *)roundImage;

- (UIImage *)roundImageWithSize:(CGSize)size;

- (UIImage *)clipImageWithSize:(CGSize)size andCornerRadius:(CGFloat)corRadius;

- (UIImage *)roundImageWithCornerRadius:(CGFloat)corRadius;

- (void)roundImageBlock:(void (^) (UIImage *image))imageBlock;

/**
 *  等比例缩放
 *
 *  @param
 *
 *  @return
 */
-(UIImage*)scaleTo:(CGFloat)scale;

/**
 *  判断图片是否有透明通道
 *
 *  @return
 */
- (BOOL)hasAlpha;

@end
