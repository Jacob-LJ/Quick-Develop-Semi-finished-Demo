//
//  PSLShadowView.m
//  hunlimao
//
//  Created by Jacob on 16/10/8.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "PSLShadowView.h"
#import "PackageSelectListBottomBar.h"

@implementation PSLShadowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    UIView *view = touch.view;
    
    if (view == self) {
        [self.bottomBar dismissAnimated:YES];
    }
}

@end
