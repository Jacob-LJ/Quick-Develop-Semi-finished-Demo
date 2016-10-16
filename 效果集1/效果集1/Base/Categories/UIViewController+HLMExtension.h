//
//  UIViewController+HLMExtension.h
//  hunlimao
//
//  Created by Eugene on 15/7/24.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const HLMLinkRouteParameterEntrance;//通过URL的方式来跳转时，标示入口的Key

@interface UIViewController (HLMExtension)


- (UIViewController *)hlm_topViewController;

/**
 *  判断当前controller是否是present出来的Modal controller
 *
 *  @return
 */
- (BOOL)hlm_isModal;


/**
 *  如果没有登录，则弹出登录界面
 *
 *  @param block    登录界面消失时
 */
- (void)invokeBlockAfterLogin:(void(^)(BOOL loginSuccess))block withUserInfo:(NSDictionary *)userInfo;

/**
 *  友盟社区登陆
 *
 *  @param block    登录界面消失时
 *  loginMessage    error       婚礼猫登陆失败
 *                  umengErroe  友盟登陆失败
 *                  success     登陆成功
 */
- (void)invokeBlockAfterCommunityLogin:(void(^)(NSString *loginMessage))communityBlock;

@end
