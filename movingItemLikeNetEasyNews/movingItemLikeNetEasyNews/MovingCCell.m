//
//  MovingCCell.m
//  movingItemLikeNetEasyNews
//
//  Created by Jacob_Liang on 16/11/14.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "MovingCCell.h"

@interface MovingCCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@end

@implementation MovingCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
}

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    self.titleLB.text = titleText;
}

- (IBAction)didClikcDeleteBtn:(UIButton *)sender {
    
}

@end
