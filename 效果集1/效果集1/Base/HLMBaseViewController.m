//
//  HLMBaseViewController.m
//  hunlimao
//
//  Created by Eugene on 15/7/20.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "HLMBaseViewController.h"
#import "HLMImageButton.h"
#import "UIImage+Util.h"
#import "UINavigationBar+KIZExtention.h"
#import "HLMBaseNavigationController.h"

@implementation HLMBaseViewController

NSArray *_otherViewControllers;
NSArray *_ignoreViewControllers;

+ (void)load {
    _otherViewControllers = @[@"WeddingPhotoMainController", @"SearchHotelViewController", @"PhotoWorkListDoubleLineController", @"PhotographerListViewController", @"PhotographerListContentController", @"PhotographerDetailViewController", @"UserLoginViewController", @"LoginWithPasswordController", @"CompletePhoneNumController", @"CommunityMainController", @"MallMainController", @"MallBusinessListController", @"MallWorksListController", @"MallServiceListController", @"PhotoSetMainController", @"PhotoTravelDetailController", @"GlobalPhotoMainController", @"GlobalHotPlaceListController" ,@"GlobalOtherPhotoListController", @"LuckyDayController", @"UserTableViewController"];
    
    _ignoreViewControllers = @[@"PhotoPackPackageController", @"PhotoTravelMoreDetailImageController", @"PhotoTravelMoreDetailWebController", @"PhotoTravelMoreDetailTeamController", @"PhototTravelMoreDetailController", @"PhotoSetMoreDetailController", @"PhotoSetMoreDetailImageController", @"PhotoSetMoreDetailTeamController", @"PSLPackageDetailController", @"PSLPackageMoreDetailController", @"PSLMoreDetailImageController"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    HLMBaseNavigationController *navVC = (HLMBaseNavigationController *)self.navigationController;
    UINavigationBar *navBar = navVC.navigationBar;
    
    if ([navVC.currentVCClass isEqual:self.class] && ![navVC.childViewControllers.firstObject isEqual:self]) {
        
        if (navVC.leftItems.count) {
            self.navigationItem.leftBarButtonItems = nil;
            self.navigationItem.leftBarButtonItems = navVC.leftItems;
        }
        if (navVC.rightItems.count) {
            self.navigationItem.rightBarButtonItems = nil;
            self.navigationItem.rightBarButtonItems = navVC.rightItems;
        }
        
    }
    
    navBar.lp_backgroundView.backgroundColor = [UIColor whiteColor];
    
    if ([_ignoreViewControllers containsObject:NSStringFromClass([self class])]) return;
    
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
