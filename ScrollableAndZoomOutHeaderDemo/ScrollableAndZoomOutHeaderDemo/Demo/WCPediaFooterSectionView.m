//
//  WCPediaFooterSectionView.m
//  hunlimao
//
//  Created by Jacob on 16/11/11.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "WCPediaFooterSectionView.h"

@interface WCPediaFooterSectionView ()
@property (weak, nonatomic) IBOutlet UILabel *tipsLB;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageV;

@end

@implementation WCPediaFooterSectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSectionView)];
    [self addGestureRecognizer:tap];
}

- (void)tapSectionView {
    if ([self.delegate respondsToSelector:@selector(showAllCategoryWordsWithPediaFooterSectionView:)]) {
        [self.delegate showAllCategoryWordsWithPediaFooterSectionView:self];
    }
}

- (void)setShowTipStr:(NSString *)showTipStr {
    _showTipStr = showTipStr;
    self.tipsLB.text = showTipStr;
    if ([showTipStr isEqualToString:@"展开所有类目"]) {
        [UIView animateWithDuration:0.2 animations:^{
            self.arrowImageV.transform = CGAffineTransformIdentity;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.arrowImageV.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }
}
@end
