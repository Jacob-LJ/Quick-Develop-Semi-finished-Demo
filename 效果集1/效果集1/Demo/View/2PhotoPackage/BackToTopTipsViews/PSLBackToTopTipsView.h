//
//  PSLBackToTopTipsView.h
//  hunlimao
//
//  Created by Jacob on 16/10/10.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PSLBackToTopViewStateNormal,
    PSLBackToTopViewStateBack,
} PSLBackToTopViewState;

@interface PSLBackToTopTipsView : UIView
@property (nonatomic, assign) PSLBackToTopViewState state;
@end
