//
//  testCell.m
//  CornerRadius(simpleViewOrImageView-etc)
//
//  Created by Jacob_Liang on 16/10/31.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "testCell.h"
#import "UIView+CornerTool.h"
#import "UIImageView+CornerTool.h"

@interface testCell ()


@end

@implementation testCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.view.layer.cornerRadius = 4.0f;
//    self.lable.layer.cornerRadius = 4.0f;
//    self.lable.layer.masksToBounds = YES;
//    
//    self.imageView1.layer.cornerRadius = 4.0f;
//    self.imageView1.layer.masksToBounds = YES;
//    
//    self.imageView2.layer.cornerRadius = 4.0f;
//    self.imageView2.layer.masksToBounds = YES;
    
    [self layoutIfNeeded];
    [self setUpContent];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpContent {
    
//    [self.lable ja_addingCornerWithRadius:4.0f];
    [self.lable ja_addingCornerWithRadius:4.0 andBorderWidth:0 andBackgroundColor:[UIColor orangeColor] andBorderColor:[UIColor redColor]];
    
    [self.imageView1 addingCornerWithRadius:4.0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

@end
