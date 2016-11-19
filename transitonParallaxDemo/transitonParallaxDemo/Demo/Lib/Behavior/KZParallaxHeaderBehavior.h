//
//  KZParallaxHeaderBehavior.h
//  hunlimao
//  ScrollView 视差效果
//  Created by Eugene on 15/5/21.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "KZBehavior.h"

@interface KZParallaxHeaderBehavior : KZBehavior<UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIView* backgroundView;

@property (nonatomic, weak) IBOutlet UIView* targetView;

@property (nonatomic, assign) IBInspectable CGPoint startContentOffset;

/**
 * 背景View往上滑动时，不超出导航栏
 */
@property (nonatomic, assign) IBInspectable BOOL bgViewStopInNavBar;

@end
