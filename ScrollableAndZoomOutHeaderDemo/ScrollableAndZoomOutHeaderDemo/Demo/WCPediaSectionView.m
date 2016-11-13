//
//  WCPediaSectionView.m
//  hunlimao
//
//  Created by Jacob on 16/11/10.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "WCPediaSectionView.h"

//背景色
#define themeBackgroundColor [UIColor colorWithRed:246/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0]

@implementation WCPediaSectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = themeBackgroundColor;
}

@end
