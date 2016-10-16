//
//  PSLShopCarPackageCell.m
//  hunlimao
//
//  Created by Jacob on 16/10/8.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "PSLShopCarPackageCell.h"

@interface PSLShopCarPackageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *styleLB;
@end

@implementation PSLShopCarPackageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
