//
//  StyleSizeCCell.m
//  hunlimao
//
//  Created by Jacob on 16/10/13.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "StyleSizeCCell.h"

@interface StyleSizeCCell ()


@end

@implementation StyleSizeCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.descLB.font = [UIFont systemFontOfSize:StyleSizeCCellFontSize];
}

@end
