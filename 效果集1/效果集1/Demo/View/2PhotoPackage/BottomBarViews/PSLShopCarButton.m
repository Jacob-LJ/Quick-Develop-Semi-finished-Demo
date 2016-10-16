//
//  PSLShopCarButton.m
//  hunlimao
//
//  Created by Jacob on 16/10/12.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "PSLShopCarButton.h"

@interface PSLShopCarButton ()

@property (nonatomic, assign) CGFloat fistW;

@end

@implementation PSLShopCarButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUpInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit {
    
    self.badgeLB = [[UILabel alloc] init];
    self.badgeLB.backgroundColor = [UIColor redColor];
    self.badgeLB.font = [UIFont systemFontOfSize:10.0f];
    self.badgeLB.textColor = [UIColor whiteColor];
    self.badgeLB.textAlignment = NSTextAlignmentCenter;
    [self.badgeLB sizeToFit];
    self.badgeLB.layer.masksToBounds = YES;
    
    
    [self addSubview:self.badgeLB];
    self.fistW = self.badgeLB.frame.size.width;
    
    self.badgeLB.hidden = YES;
}

- (void)setBageValue:(NSInteger)bageValue {
    _bageValue = bageValue;
    self.badgeLB.hidden = !bageValue;
    self.badgeLB.text = [NSString stringWithFormat:@"%ld",bageValue];
    [self.badgeLB sizeToFit];
    
    CGRect frame = self.badgeLB.frame;
    frame.origin.x = self.frame.size.width - 20;
    frame.origin.y = 5;
    frame.size.width = frame.size.width + 8;
    self.badgeLB.frame = frame;
    self.badgeLB.layer.cornerRadius = self.badgeLB.frame.size.height / 2.0;
}

@end
