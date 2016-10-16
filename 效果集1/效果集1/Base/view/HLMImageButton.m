//
//  CustomButton.m
//  hunlimao
//
//  Created by Eugene on 15/6/8.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "HLMImageButton.h"
#import "UIImage+Util.h"
#import "UIViewExt.h"

@interface HLMImageButton ()

@property (nonatomic, strong) UILabel *badgeLabel;

@end

@implementation HLMImageButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit{
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
//    [self setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
//    [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.9 alpha:1]] forState:UIControlStateHighlighted];

    
    self.imgLabelSpacing = 5.0;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (_imageWidth) {
        self.imageView.width = _imageWidth;
    }
    if (_imageHeight) {
        self.imageView.height = _imageHeight;
    }
    
    
    
    CGFloat offsetY = (self.bounds.size.height - self.imageView.frame.size.height - self.titleLabel.frame.size.height - _imgLabelSpacing) / 2.0;
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width / 2;
    center.y = self.imageView.frame.size.height / 2 + offsetY;
    self.imageView.center = center;
    
    //Center text
    [self.titleLabel sizeToFit];
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = CGRectGetMaxY(self.imageView.frame) + _imgLabelSpacing;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    if (self.badge) {
        self.badgeLabel.hidden = NO;
        self.badgeLabel.text = self.badge;
        CGRect frame = self.badgeLabel.frame;
        frame.origin = CGPointMake(self.imageView.right - frame.size.width / 2 - 5, self.imageView.top - frame.size.height / 2 + 5);
        
        CGRect rect = [self.badge boundingRectWithSize:CGSizeMake(0, frame.size.height)
                                               options:NSStringDrawingUsesFontLeading
                                            attributes:@{NSFontAttributeName : self.badgeLabel.font}
                                               context:nil
                       ];
        frame.size.width =  MAX((rect.size.width + 6), frame.size.width);
        self.badgeLabel.frame = frame;
        
    }else if(_badgeLabel){
        _badgeLabel.hidden = YES;
    }
}


- (void)setNormalBgColor:(UIColor *)normalBgColor{
    _normalBgColor = normalBgColor;
    [self setBackgroundImage:[UIImage imageWithColor:normalBgColor] forState:UIControlStateNormal];
}
- (void)setHightBgColor:(UIColor *)hightBgColor{
    _hightBgColor = hightBgColor;
    [self setBackgroundImage:[UIImage imageWithColor:hightBgColor] forState:UIControlStateHighlighted];
}

- (void)setDisabledBgColor:(UIColor *)disabledBgColor{
    _disabledBgColor = disabledBgColor;
    [self setBackgroundImage:[UIImage imageWithColor:disabledBgColor] forState:UIControlStateDisabled];
}

- (void)setImageHeight:(CGFloat)imageHeight{
    _imageHeight = imageHeight;
}

- (void)setImageWidth:(CGFloat)imageWidth{
    _imageWidth = imageWidth;
}

- (UILabel *)badgeLabel{
    if (!_badgeLabel) {
        UILabel *label            = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        label.backgroundColor     = [UIColor redColor];
        label.textColor           = [UIColor whiteColor];
        label.font                = [UIFont systemFontOfSize:14];
        label.textAlignment       = NSTextAlignmentCenter;
        label.layer.cornerRadius  = 10;
        label.layer.masksToBounds = YES;
        
        _badgeLabel              = label;
        [self addSubview:label];
    }
    return _badgeLabel;
}

- (void)setBadge:(NSString *)badge{
    _badge = badge;
    [self setNeedsLayout];
}
@end
