//
//  HLMBaseNavigationController.m
//  hunlimao
//
//  Created by Eugene on 15/7/28.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "HLMBaseNavigationController.h"
#import "UIViewExt.h"
#import "UIImage+Util.h"
#import "UINavigationBar+Awesome.h"
#import "UINavigationBar+KIZExtention.h"

//全局颜色
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

@interface HLMBaseNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) id oldDelegate;

@end

@implementation HLMBaseNavigationController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass{
    self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit{
    self.navigationBarStyle = HLMNavigationBarStyleWhite;
    
}


- (void)setNavigationBarStyle:(HLMNavigationBarStyle)navigationBarStyle{
    if (navigationBarStyle == self.navigationBarStyle) {
        return;
    }
    _navigationBarStyle = navigationBarStyle;
    [self configureNaviBarStyle:navigationBarStyle];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //使用一个变量来记录
    _oldDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
//    UIScreenEdgePanGestureRecognizer
    [self configureNaviBarStyle:self.navigationBarStyle];
}

- (void)configureNaviBarStyle:(HLMNavigationBarStyle)style{
    switch (style) {
        case HLMNavigationBarStylePink: {
            
            break;
        }
        case HLMNavigationBarStyleWhite: {
            
            self.navigationBar.barTintColor = [UIColor whiteColor];
            self.navigationBar.tintColor = RGBA(61, 61, 61, 1);
            self.navigationBar.titleTextAttributes = @{
                                                       NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                                       NSFontAttributeName : [UIFont systemFontOfSize:16]
                                                       };
            break;
        }
        default: {
            break;
        }
    }
}

//统一修改左边按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.childViewControllers.count) {
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Path 120"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
//        更改这个就能实现左滑效果
        self.interactivePopGestureRecognizer.delegate = self;
        viewController.navigationItem.leftBarButtonItem.tintColor = RGBA(102, 102, 102, 1);
        
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}



#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    self.currentVCClass = viewController.class;
    
    if (self.childViewControllers.count > 1) {
    
        self.leftItems = viewController.navigationItem.leftBarButtonItems;
        self.rightItems = viewController.navigationItem.rightBarButtonItems;
    }
    
    
    if (self.childViewControllers.count == 1) {
        //把代理变回来,防止bug出现
        self.interactivePopGestureRecognizer.delegate = _oldDelegate;
        
    }
}

@end



