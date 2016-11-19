//
//  KZBlurBehavior.h
//  hunlimao
//  模糊效果
//  Created by Eugene on 15/5/23.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "KZBehavior.h"

@interface KZBlurBehavior : KZBehavior

//! view we are about to blur
@property IBOutlet UIView* targetView;
//! scroll view to follow
@property(nonatomic, weak) IBOutlet UIScrollView *leadingScrollView;
//! the point where the view is fully blurred
@property IBInspectable CGPoint fullBlurOffset;
//! blur radius
@property IBInspectable CGFloat blurRadius;

//! make blurred snapshot
-(IBAction)refresh;

@end
