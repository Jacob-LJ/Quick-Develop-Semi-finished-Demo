//
//  StickyCCell.m
//  顶部悬停+collectionView sectionHeaders指定位置悬停
//
//  Created by Jacob_Liang on 16/10/16.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "StickyCCell.h"

@implementation StickyCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
}

@end
