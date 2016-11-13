//
//  WCPediaFooterSectionView.h
//  hunlimao
//
//  Created by Jacob on 16/11/11.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const PediaFooterSectionViewHeight = 52.0;

@class WCPediaFooterSectionView;

@protocol WCPediaFooterSectionViewDelegate <NSObject>

- (void)showAllCategoryWordsWithPediaFooterSectionView:(WCPediaFooterSectionView *)pediaFooterSectionView;

@end

@interface WCPediaFooterSectionView : UIView
@property (nonatomic, copy) NSString *showTipStr;
@property (nonatomic, weak) id<WCPediaFooterSectionViewDelegate> delegate;
@end
