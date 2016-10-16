//
//  UIImage+UIColor.m
//  hunlimao
//
//  Created by Eugene on 15/4/22.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "UIImage+Util.h"

static const CGFloat MAX_UPLOAD_SIZE = 1024 * 1024 * 1.5;

@implementation UIImage (Util)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage*) imageWithColor: (UIColor*) color alpha:(CGFloat)alpha{
    color = [color colorWithAlphaComponent:alpha];
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)captureScreen{
    
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootVC = keywindow.rootViewController;
    
    if(rootVC == nil || keywindow.windowLevel >= UIWindowLevelAlert){
        rootVC = [[UIApplication sharedApplication].windows[0] rootViewController];
    }
    
    UIView *showingView;
    if (rootVC.presentedViewController) {
        showingView = rootVC.presentedViewController.view;
    }else{
        showingView = rootVC.view;
    }
    
    UIGraphicsBeginImageContextWithOptions(showingView.bounds.size, showingView.opaque, 0.0);
    [showingView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
    
}

- (void)roundImageBlock:(void (^) (UIImage *image))imageBlock {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        CGFloat side = MIN(self.size.width, self.size.height);
        CGSize size = CGSizeMake(side, side);
        CGFloat corRadius = MIN(size.width, size.height) * 0.5;
        
        UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //去锯齿处理
        CGContextSetAllowsAntialiasing(context, true);
        CGContextSetShouldAntialias(context, true);
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:corRadius] addClip];
        [self drawInRect:rect];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
       
        dispatch_async(dispatch_get_main_queue(), ^{
           
            if (imageBlock) {
                imageBlock(image);
            }
            
        });
        
    });

    
}

- (UIImage *)roundImage{
    CGFloat side = MIN(self.size.width, self.size.height);
    return [self roundImageWithSize:CGSizeMake(side, side)];
}

- (UIImage *)roundImageWithSize:(CGSize)size{
    return [self clipImageWithSize:size andCornerRadius:MIN(size.width, size.height) * 0.5];
}

- (UIImage *)roundImageWithCornerRadius:(CGFloat)corRadius {
    if (self.size.width != self.size.height) {
        return nil;
    }
    CGFloat side = MIN(self.size.width, self.size.height);
    return [self clipImageWithSize:CGSizeMake(side, side) andCornerRadius:corRadius];
}

- (UIImage *)clipImageWithSize:(CGSize)size andCornerRadius:(CGFloat)corRadius{
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //去锯齿处理
//    CGContextSetAllowsAntialiasing(context, true);
//    CGContextSetShouldAntialias(context, true);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    rect.origin = origin;
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:corRadius] addClip];
    // Draw your image
    [self drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}


/**
 *  等比例缩放
 *
 *  @param
 *
 *  @return
 */
-(UIImage*)scaleTo:(CGFloat)scale
{
    CGSize size = CGSizeMake(self.size.width * scale, self.size.height * scale);
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(size, ![self hasAlpha], 0);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}


// Returns true if the image has an alpha layer
- (BOOL)hasAlpha {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}
@end
