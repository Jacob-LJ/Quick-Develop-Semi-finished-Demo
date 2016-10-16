//
//  MiniImage.m
//  hunlimao
//
//  Created by Eugene on 15/5/25.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "MiniImage.h"

@implementation MiniImage

+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+ (BOOL)propertyIsIgnored:(NSString *)propertyName{
    return [propertyName isEqualToString:@"imageSize"];
}


- (CGFloat)imageHeight {
    if (_imageScale <= 0) return 0;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat scale = _imageScale;
    CGFloat height = width / scale;
    
    return height;
}

/**
 *  获取指定size的缩略图的URL
 *
 *  @param size
 *
 *  @return
 */
- (NSURL *)thumbnailImageURLWithSize:(CGSize)size{
    CGFloat scale = [UIScreen mainScreen].scale;
    if (self.url && ![self.url containsString:@"?"]) {
        return [NSURL URLWithString:[self.url stringByAppendingFormat:@"?imageView2/2/w/%0.f/h%0.f",size.width * scale, size.height * scale]];
    }
    return nil;
}
@end
