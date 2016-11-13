//
//  KZParallaxHeaderBehavior.m
//  hunlimao
//
//  Created by Eugene on 15/5/21.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "KZParallaxHeaderBehavior.h"

@interface KZParallaxHeaderBehavior ()

//@property (nonatomic) CGPoint startContentOffset;
@property (nonatomic) CGFloat bgImageHeight;
@property (nonatomic) CGPoint bgImageOrigin;
@property (nonatomic) CGSize  bgImageSize;

@end

@implementation KZParallaxHeaderBehavior{
    
    BOOL _isInitialHeightSet;

}

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(!_isInitialHeightSet)
    {
        self.bgImageHeight = CGRectGetHeight(self.backgroundView.frame);
        self.bgImageSize   = self.backgroundView.bounds.size;
        self.bgImageOrigin = self.backgroundView.frame.origin;
        _isInitialHeightSet=YES;
    }
    
//    CGFloat absoluteY = ABS(scrollView.contentOffset.y + scrollView.contentInset.top);
//    
//    if (scrollView.contentOffset.y + scrollView.contentInset.top <= _startContentOffset.y)
//    {
//        CGFloat height = self.bgImageSize.height + absoluteY;
//        CGFloat width  = height * self.bgImageSize.width / self.bgImageSize.height;
//        
//        CGFloat diff = width - self.bgImageSize.width; //_startContentOffset.y - scrollView.contentOffset.y;
//        
//        [self.backgroundView setFrame:CGRectMake(0.0f - diff / 2.0f, 0/*CGRectGetMinY(scrollView.frame)*/, width/*CGRectGetWidth(self.targetView.frame)+ absoluteY*/, self.bgImageHeight + absoluteY)];
//    }
//    else
//    {
//        CGFloat y = /*CGRectGetMinY(scrollView.frame)*/ - absoluteY * 0.6;
//        if(self.bgViewStopInNavBar){
//            y = MAX(y, 64 - _bgImageHeight);
//        }
//        [self.backgroundView setFrame:CGRectMake(0, y, self.bgImageSize.width, self.bgImageHeight)];
//
//    }
    
    
    CGFloat absoluteY = ABS(scrollView.contentOffset.y - _startContentOffset.y);

    if (scrollView.contentOffset.y <= _startContentOffset.y)
    {
        CGFloat height = self.bgImageSize.height + absoluteY;
        CGFloat width  = height * self.bgImageSize.width / self.bgImageSize.height;

        CGFloat diff = width - self.bgImageSize.width; //_startContentOffset.y - scrollView.contentOffset.y;

        [self.backgroundView setFrame:CGRectMake(0.0f - diff / 2.0f, 0/*CGRectGetMinY(scrollView.frame)*/, width/*CGRectGetWidth(self.targetView.frame)+ absoluteY*/, self.bgImageHeight + absoluteY)];
        
    }
    else
    {
        CGFloat y = /*CGRectGetMinY(scrollView.frame)*/ - absoluteY * 0.6;
        if(self.bgViewStopInNavBar){
            y = MAX(y, 64 - _bgImageHeight);
        }
        [self.backgroundView setFrame:CGRectMake(0, y, self.bgImageSize.width, self.bgImageHeight)];

    }
    
}
@end
