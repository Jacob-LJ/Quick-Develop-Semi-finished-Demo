//
//  PLSMoreDetailBaseContentController.m
//  hunlimao
//
//  Created by Jacob on 16/10/10.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "PLSMoreDetailBaseContentController.h"

#import "PSLPackageMoreDetailController.h"
#import "PSLPackageDetailController.h"

@interface PLSMoreDetailBaseContentController () <UIScrollViewDelegate>

@end

@implementation PLSMoreDetailBaseContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = -scrollView.contentOffset.y;
    
    if (offsetY < 0) return;
    
    PSLPackageMoreDetailController *moreDetailVC = (PSLPackageMoreDetailController *)self.parentViewController;
    
    CGFloat alpha = (offsetY / BackToTopMaxOffetY);
    
    moreDetailVC.backToTopView.alpha = (alpha <= 1 ? alpha : 1);
    
    if (offsetY >= BackToTopMaxOffetY) {
        
        moreDetailVC.backToTopView.state = PSLBackToTopViewStateBack;
        
    } else {
        
        moreDetailVC.backToTopView.state = PSLBackToTopViewStateNormal;
    }
    
    CGFloat height = offsetY;
    
    moreDetailVC.backToTopHeightLayout.constant = (height >= BackToTopMaxOffetY ? height : BackToTopMaxOffetY);
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    CGFloat offsetY = -scrollView.contentOffset.y;
    
    if (offsetY >= BackToTopMaxOffetY) {
        
        PSLPackageDetailController *detailVC = (PSLPackageDetailController *)self.parentViewController.parentViewController;
        [detailVC resetAnimate];
        
    }
    
    
}

@end
