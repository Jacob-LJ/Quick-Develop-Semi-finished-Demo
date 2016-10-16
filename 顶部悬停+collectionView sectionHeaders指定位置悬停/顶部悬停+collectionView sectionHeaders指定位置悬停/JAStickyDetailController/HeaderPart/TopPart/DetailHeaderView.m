//
//  DetailHeaderView.m
//  顶部悬停+collectionView sectionHeaders指定位置悬停
//
//  Created by Jacob_Liang on 16/10/16.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "DetailHeaderView.h"

@implementation DetailHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
}

@end
