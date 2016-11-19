//
//  HLMBaseViewController.m
//  hunlimao
//
//  Created by Eugene on 15/7/20.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "HLMBaseViewController.h"
#import "UINavigationBar+KIZExtention.h"

@implementation HLMBaseViewController

NSArray *_otherViewControllers;
NSArray *_ignoreViewControllers;

+ (void)load {
    _otherViewControllers = @[@"DestinationViewController"];
    
    _ignoreViewControllers = @[];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UINavigationController *navVC = (UINavigationController *)self.navigationController;
    UINavigationBar *navBar = navVC.navigationBar;
    
    if ([navVC.visibleViewController isKindOfClass:self.class] && ![navVC.childViewControllers.firstObject isEqual:self]) {
        
        if (self.navigationItem.leftBarButtonItems.count) {
            self.navigationItem.leftBarButtonItems = nil;
            self.navigationItem.leftBarButtonItems = navVC.visibleViewController.navigationItem.leftBarButtonItems;
        }
        if (navVC.navigationItem.rightBarButtonItems.count) {
            self.navigationItem.rightBarButtonItems = nil;
            self.navigationItem.rightBarButtonItems = navVC.visibleViewController.navigationItem.rightBarButtonItems;
        }
        
    }
    
    if ([_ignoreViewControllers containsObject:NSStringFromClass([self class])]) return;
    
    navBar.lp_backgroundView.backgroundColor = [UIColor whiteColor];
    
    if ([_otherViewControllers containsObject:NSStringFromClass([self class])]) {
        
        navBar.lp_hideSeperateView = YES;
        
    } else {
        
        navBar.lp_hideSeperateView = NO;

    }
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

- (void)dealloc{
    NSLog(@"👻%s ---> %@", __PRETTY_FUNCTION__, self.class);
}


@end
