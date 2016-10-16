//
//  HLMBaseNavigationController.h
//  hunlimao
//
//  Created by Eugene on 15/7/28.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  导航栏风格
 */
typedef NS_ENUM(NSUInteger, HLMNavigationBarStyle){
    /**
     *  白色风格
     */
    HLMNavigationBarStyleWhite = 0,
    /**
     *  粉色风格
     */
    HLMNavigationBarStylePink
};

@interface HLMBaseNavigationController : UINavigationController

#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSUInteger navigationBarStyle;
#else
@property (nonatomic, assign) HLMNavigationBarStyle navigationBarStyle;
#endif

@property (nonatomic, strong) NSArray <UIBarButtonItem *> *leftItems;
@property (nonatomic, strong) NSArray <UIBarButtonItem *> *rightItems;

@property (nonatomic, assign) Class currentVCClass;

@end
