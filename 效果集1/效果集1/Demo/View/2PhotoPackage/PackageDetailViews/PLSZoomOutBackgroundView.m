//
//  PLSZoomOutBackgroundView.m
//  hunlimao
//
//  Created by Jacob on 16/10/9.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "PLSZoomOutBackgroundView.h"

@implementation PLSZoomOutBackgroundView

- (void)layoutSubviews {
    self.subBgImageV.frame = self.bounds;
    [super layoutSubviews];
}



@end
