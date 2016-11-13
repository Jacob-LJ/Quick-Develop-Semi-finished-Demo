//
//  WCPediaPageControlView.h
//  hunlimao
//
//  Created by Jacob on 16/11/11.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const WCPediaPageControlViewHeight = 60;

@interface WCPediaPageControlView : UIView

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger totalPagesCount;
@end
