//
//  PSLShopCarDetailCell.m
//  hunlimao
//
//  Created by Jacob on 16/10/8.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "PSLShopCarDetailCell.h"

@interface PSLShopCarDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *styleLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB; //选择的数量LB

@property (weak, nonatomic) IBOutlet UIView *minusBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLB; //加减的数量LB
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;

@end

@implementation PSLShopCarDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.operationView.hidden = YES;
}


- (IBAction)minusBtnClick:(UIButton *)sender {
    
}

- (IBAction)plusBtnClick:(UIButton *)sender {
    
}

- (IBAction)deleteBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(PSLShopCarDetailCell:didClickDeleteButton:)]) {
        [self.delegate PSLShopCarDetailCell:self didClickDeleteButton:sender];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
