//
//  KZNavBarGradientBehavior.h
//  hunlimao
//  导航栏渐变效果
//  Created by Eugene on 15/8/21.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "KZBehavior.h"

@interface KZNavBarGradientBehavior : KZBehavior <UIScrollViewDelegate>

//状态栏是否颜色是否动态改变，默认为YES，需要在info.plist中设置 View controller-based status bar appearance 为 NO才有效果
@property (nonatomic, assign) IBInspectable BOOL statusBarStyleChange;
//导航栏tintColor变化的临界值默认为200
@property (nonatomic, assign) IBInspectable CGFloat criticalOffset;

- (void)onViewWillAppear;

- (void)onViewWillDisAppear;

/**
 *  初始化状态，在Controller的viewDidLoad中调用
 */
- (void)initialize;
/**
 *  恢复状态，恢复到重置时的状态，在Controller中的viewWillAppear中调用
 */
- (void)recover;
/**
 *  重置状态，回到初始化时的状态，在Controller的viewWillDisAppear中调用
 */
- (void)reset;


/**
 *  根据当前状态自动调用initialize或者recover方法，在viewWillAppear方法中调用
 */
- (void)initializeOrRecover;

@end
