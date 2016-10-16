//
//  PackageSelectListBottomBar.m
//  hunlimao
//
//  Created by Jacob on 16/10/8.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "PackageSelectListBottomBar.h"
#import "PSLShopCarDetailView.h"
#import "PSLShadowView.h"

#import "UIView+Frame.h"



static CGFloat TOP_MARGIN = 250; //shopCarDetailView 距离顶部最大间距
static CGFloat SHOPCAR_BTN_HEIGHT = 70; //购物车btn宽度
static CGFloat SHOPCAR_BTN_WIDTH = 65;  //购物车btn高度
static CGFloat ANIMAITONTIME = 0.25;

@interface PackageSelectListBottomBar ()


@property (strong, nonatomic) PSLShopCarButton *shopCarBtn2; //动画用的购物车Btn

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLB; //总价LB
@property (weak, nonatomic) IBOutlet UIButton *finishBtn; //选购完成Btn

@property (nonatomic, assign) CGFloat maxHeight; /**< ShopCarDetailView最大高度 */


@end

@implementation PackageSelectListBottomBar

+ (instancetype)bottomBarInParentView:(UIView *)parentView {
    PackageSelectListBottomBar *bottomBar = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    bottomBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - BottomBarH, [UIScreen mainScreen].bounds.size.width, BottomBarH);
    bottomBar.parentView = parentView;
    
    [bottomBar layoutUI];
    
    return bottomBar;
}

- (void)layoutUI {
    
    self.maxHeight = self.parentView.frame.size.height - TOP_MARGIN;
    self.shopCarDetailView = [PSLShopCarDetailView shopCarDetailViewWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height - BottomBarH, self.bounds.size.width, self.maxHeight) withObjects:nil canReorder:YES];
    
    self.shadowView = [[PSLShadowView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - BottomBarH)];
    self.shadowView.bottomBar = self;
    [self.parentView.hlm_viewController.navigationController.view addSubview:self.shadowView];
    self.shadowView.alpha = 0.0;
    
    self.shopCarBtn2 = [[PSLShopCarButton alloc] initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height - 10 - SHOPCAR_BTN_HEIGHT, SHOPCAR_BTN_WIDTH, SHOPCAR_BTN_HEIGHT)]; //此处数值与xib中的shopCarBtn数值要保持一致,因为shopCarBtn2是用于动画使用,其所在的层级位于最顶层
    [self.parentView.hlm_viewController.navigationController.view addSubview:self.shopCarBtn2];
    [self.shopCarBtn2 setBackgroundImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateNormal];
    [self.shopCarBtn2 addTarget:self action:@selector(shopCarClick:) forControlEvents:UIControlEventTouchUpInside];
    self.shopCarBtn2.hidden = YES;
    
    
    self.open = NO;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return [super hitTest:point withEvent:event];
    }
    
    for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
        CGPoint convertedPoint = [subview convertPoint:point fromView:self];
        UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
        if (hitTestView) {
            return hitTestView;
        }
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - Action
- (IBAction)shopCarClick:(UIButton *)sender {
    
//    if (!self.badgeValue>0) {
//        [self.shopCarBtn setUserInteractionEnabled:NO];
//        return;
//    }
    
    if (self.open) {
        [self dismissAnimated:YES];
        self.open = NO;
    } else {
        self.shopCarBtn2.bageValue = self.shopCarBtn.bageValue;
        self.shopCarBtn2.hidden = NO;
        self.shopCarBtn.hidden = YES;
        
        [self updateFrame:self.shopCarDetailView];
        [self.shadowView addSubview:self.shopCarDetailView];
        [UIView animateWithDuration:ANIMAITONTIME animations:^{
            self.shadowView.alpha = 1.0;
            CGPoint point = self.shopCarBtn.center;
            point.y -= self.shopCarDetailView.frame.size.height;
            
            self.shopCarBtn2.transform = CGAffineTransformTranslate(self.shopCarBtn.transform, 0, point.y);
            self.shopCarDetailView.frame = CGRectMake(0,self.parentView.bounds.size.height - self.maxHeight - BottomBarH, self.bounds.size.width, self.maxHeight);
            
        } completion:^(BOOL finished) {
            
            self.open = YES;
        }];
    }
    
    
}


#pragma  mark - 更新 shopCarDetailView 的高度
-(void)updateFrame:(PSLShopCarDetailView *)shopCarDetailView {
    if(shopCarDetailView.selfSelectDatas.count == 0 && shopCarDetailView.packageDatas.count == 0) {
        [self dismissAnimated:YES];
        return;
    }
    
    CGFloat height = 0;
    if (shopCarDetailView.selfSelectDatas.count == 0) {
        [shopCarDetailView.segControl setSelectedSegmentIndex:1];
        height = shopCarDetailView.packageDatas.count * CELLH;
    } else {
         height = shopCarDetailView.selfSelectDatas.count * CELLH;
    }
    if (height >= self.maxHeight) {
        height = self.maxHeight;
    }
    
    shopCarDetailView.frame = CGRectMake(shopCarDetailView.frame.origin.x, self.parentView.bounds.size.height - height - BottomBarH, self.shopCarDetailView.frame.size.width, height);
    
    
}


#pragma mark - Dismiss
- (void)dismissAnimated:(BOOL)animated {
    
    
    [UIView animateWithDuration:ANIMAITONTIME animations:^{
        self.shadowView.alpha = 0.0;
        
        self.shopCarBtn2.transform = CGAffineTransformIdentity;
        self.shopCarDetailView.frame = CGRectMake(self.shopCarDetailView.frame.origin.x, [UIScreen mainScreen].bounds.size.height - BottomBarH, self.shopCarDetailView.frame.size.width, self.shopCarDetailView.frame.size.height);
        
    } completion:^(BOOL finished) {
        self.open = NO;
        
        self.shopCarBtn.hidden = NO;
        self.shopCarBtn2.hidden = YES;

    }];
}


- (IBAction)finishBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(packageSelectListBottomBar:didClickFinishBtn:)]) {
        [self.delegate packageSelectListBottomBar:self didClickFinishBtn:sender];
    }
}

@end
