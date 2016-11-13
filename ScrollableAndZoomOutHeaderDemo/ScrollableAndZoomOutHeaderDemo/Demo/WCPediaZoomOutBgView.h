//
//  WCPediaZoomOutBgView.h
//  hunlimao
//
//  Created by Jacob on 16/11/11.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LPAutoScrollView;

@interface WCPediaZoomOutBgView : UIView
@property (nonatomic, weak) UIImageView *subBgImageV; /**< 自己的背景图subView */
@property (nonatomic, strong) LPAutoScrollView *adBannerScrollView;
@end
