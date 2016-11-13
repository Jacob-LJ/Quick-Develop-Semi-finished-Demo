//
//  WCPediaPageControlView.m
//  hunlimao
//
//  Created by Jacob on 16/11/11.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "WCPediaPageControlView.h"

@interface WCPediaPageControlView ()
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *descLB;

@end

@implementation WCPediaPageControlView


- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    self.pageControl.currentPage = currentIndex;
}

- (void)setTotalPagesCount:(NSInteger)totalPagesCount {
    _totalPagesCount = totalPagesCount;
    self.pageControl.numberOfPages = totalPagesCount;
}

@end
