//
//  CustomButton.h
//  hunlimao
//
//  Created by Eugene on 15/6/8.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE

@interface HLMImageButton : UIButton

@property (nonatomic, strong) IBInspectable UIColor *hightBgColor;
@property (nonatomic, strong) IBInspectable UIColor *normalBgColor;
@property (nonatomic, strong) IBInspectable UIColor *disabledBgColor;

@property (nonatomic, assign) IBInspectable CGFloat imageWidth;
@property (nonatomic, assign) IBInspectable CGFloat imageHeight;

@property (nonatomic, assign) IBInspectable CGFloat imgLabelSpacing;//图片和文字之间的间距，默认为5

@property (nonatomic, copy) IBInspectable NSString *badge;

@end
