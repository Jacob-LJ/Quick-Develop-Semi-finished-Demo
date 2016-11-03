//
//  ImageCell.m
//  CenterAndScaleItemCollectionDemo
//
//  Created by Jacob_Liang on 16/11/3.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end


@implementation ImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIconName:(NSString *)iconName {
    _iconName = iconName;
    self.imageView.image = [UIImage imageNamed:iconName];
}

@end
