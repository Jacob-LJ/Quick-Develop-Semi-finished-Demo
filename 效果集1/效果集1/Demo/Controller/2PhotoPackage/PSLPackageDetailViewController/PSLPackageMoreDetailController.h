//
//  PSLPackageMoreDetailController.h
//  hunlimao
//
//  Created by Jacob on 16/10/10.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "HLMBaseViewController.h"
#import "PSLBackToTopTipsView.h"

#define BackToTopMaxOffetY (50)

@interface PSLPackageMoreDetailController : HLMBaseViewController

@property (weak, nonatomic) IBOutlet PSLBackToTopTipsView *backToTopView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backToTopHeightLayout;

@end
