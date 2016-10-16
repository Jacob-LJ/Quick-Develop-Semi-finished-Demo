//
//  PackageSelectListBottomBar.h
//  hunlimao
//
//  Created by Jacob on 16/10/8.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSLShopCarButton.h"

@class PSLShadowView;
@class PSLShopCarDetailView;

static CGFloat const BottomBarH = 50;

@class PackageSelectListBottomBar;

@protocol PackageSelectListBottomBarDelegate <NSObject>

@optional
- (void)packageSelectListBottomBar:(PackageSelectListBottomBar *)bottomBar didClickShopCarBtn:(UIButton *)shopCarBtn;
- (void)packageSelectListBottomBar:(PackageSelectListBottomBar *)bottomBar didClickFinishBtn:(UIButton *)finishBtn;

@end

@interface PackageSelectListBottomBar : UIView

@property (weak, nonatomic) IBOutlet PSLShopCarButton *shopCarBtn; //购物车Btn


@property (nonatomic,strong) PSLShadowView *shadowView;//遮罩图层
@property (nonatomic,strong) PSLShopCarDetailView *shopCarDetailView;//选择的订单列表
@property (nonatomic,strong)   UIView *parentView;//背景图层
@property (nonatomic,assign) BOOL open;

@property (nonatomic, weak) id<PackageSelectListBottomBarDelegate> delegate;
+ (instancetype)bottomBarInParentView:(UIView *)parentView;

-(void)dismissAnimated:(BOOL) animated;
//-(void)setTotalMoney:(NSInteger)nTotal;


@end
