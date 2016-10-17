//
//  SelectedRefinementCCell.m
//  hunlimao
//
//  Created by Jacob on 16/10/15.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "SelectedRefinementCCell.h"

@implementation SelectedRefinementCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
}

@end
