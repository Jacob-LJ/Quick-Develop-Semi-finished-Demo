//
//  MiniImage.h
//  hunlimao
//
//  Created by Eugene on 15/5/25.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "JSONModel.h"
#import <UIKit/UIKit.h>

@protocol MiniImage <NSObject>

@end


@interface MiniImage : JSONModel

@property (nonatomic, copy) NSString<Optional> *url;

@property (nonatomic, assign) CGSize imageSize;//缓存imageSize

@property (nonatomic, assign) CGFloat imageScale;//缓存图片的宽高比例；

@property (nonatomic, assign) CGFloat imageHeight;

/**
 *  获取指定size的缩略图的URL
 *
 *  @param size
 *
 *  @return
 */
- (NSURL *)thumbnailImageURLWithSize:(CGSize)size;

@end
