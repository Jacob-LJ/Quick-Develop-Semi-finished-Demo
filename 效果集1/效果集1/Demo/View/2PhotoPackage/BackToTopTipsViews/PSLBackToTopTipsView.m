//
//  PSLBackToTopTipsView.m
//  hunlimao
//
//  Created by Jacob on 16/10/10.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "PSLBackToTopTipsView.h"

@interface PSLBackToTopTipsView ()

@property (nonatomic, weak) IBOutlet UILabel *descLabel;

@property (nonatomic, weak) UILabel *descLabel2;

@end

@implementation PSLBackToTopTipsView
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
    
    self.userInteractionEnabled = NO;
    
    self.descLabel.text = @"下拉,回到顶部";
    
}

- (void)setState:(PSLBackToTopViewState)state {
    
    if (_state == state) return;
    
    _state = state;
    
    if (state == PSLBackToTopViewStateNormal) {
        
        self.descLabel.text = @"下拉,回到顶部";
        
    } else if (state == PSLBackToTopViewStateBack) {
        
        self.descLabel.text = @"释放,回到顶部";
        
    }
    
}


@end
