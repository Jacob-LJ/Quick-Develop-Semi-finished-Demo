//
//  UIViewController+HLMExtension.m
//  hunlimao
//
//  Created by Eugene on 15/7/24.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "UIViewController+HLMExtension.h"
//#import "LogInViewController.h"
#import <objc/runtime.h>
#import "HLMBaseNavigationController.h"

NSString *const HLMLinkRouteParameterEntrance = @"entrance";//通过URL的方式来跳转时，标示入口的Key

@implementation UIViewController (HLMExtension)

- (UIViewController *)hlm_topViewController{
    if ([self isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)self;
        return [tabBarController.selectedViewController hlm_topViewController];
        
    } else if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)self;
        return [navigationController.visibleViewController hlm_topViewController];
        
    } else if (self.presentedViewController) {
        UIViewController* presentedViewController = self.presentedViewController;
        return [presentedViewController hlm_topViewController];
        
    } else {
        return self;
    }
}

/**
 *  判断当前controller是否是present出来的Modal controller
 *
 
 */
- (BOOL)hlm_isModal{
    if([self presentingViewController])
        return YES;
    if([[self presentingViewController] presentedViewController] == self)
        return YES;
    if([[[self navigationController] presentingViewController] presentedViewController] == [self navigationController])
        return YES;
    if([[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]])
        return YES;
    
    return NO;
}

- (void)invokeBlockAfterLogin:(void(^)(BOOL loginSuccess))block withUserInfo:(NSDictionary *)userInfo{

}


- (void)invokeBlockAfterCommunityLogin:(void(^)(NSString *loginMessage))communityBlock {
    
    
}

- (void)umengLogin:(void(^)(BOOL isSuccess))comletedBlock {
    
}

@end

