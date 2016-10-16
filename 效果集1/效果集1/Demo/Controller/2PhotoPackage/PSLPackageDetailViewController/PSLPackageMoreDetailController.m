//
//  PSLPackageMoreDetailController.m
//  hunlimao
//
//  Created by Jacob on 16/10/10.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "PSLPackageMoreDetailController.h"
//vc
#import "PSLMoreDetailImageController.h"
//category
#import "UIView+Frame.h"
//const
//#import "HLMConstant.h"
//lib
#import "LPSegmentedView.h"

@interface PSLPackageMoreDetailController ()<UIScrollViewDelegate, LPSegmentedViewDelegate>

@property (weak, nonatomic) IBOutlet LPSegmentedView *segmentView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentView;
@property (nonatomic, strong) NSArray *viewControllers;

@property (nonatomic, assign) BOOL firstAppear;

@end

@implementation PSLPackageMoreDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    [self setUpSegment]; //当前单个子VC,Segment被隐藏了
    
    [self setUpBackToTopView];
    
}

- (void)setUpInit {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.autoresizingMask = UIViewAutoresizingNone;
    
    PSLMoreDetailImageController *VC1 = [[PSLMoreDetailImageController alloc] init];
    self.viewControllers = @[VC1];
    
    for (UIViewController *VC in self.viewControllers) {
        [self addChildViewController:VC];
    }
    
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    
}

- (void)setUpSegment {
    
    self.segmentView.segmentedDelegate = self;
    self.segmentView.items = @[@"图文介绍"];
    self.segmentView.firstButtonMairgin = ([UIScreen mainScreen].bounds.size.width - 200) * 0.5;
    self.segmentView.indicatorheight = 1;
}

- (void)setUpBackToTopView {
    
    self.backToTopView.alpha = 0;
    self.backToTopView.backgroundColor = [UIColor clearColor];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.firstAppear) {
        
        [self segmentedView:self.segmentView didChangeIndex:0];
        
        UIView *view = [[UIView alloc] init];
        [self.segmentView addSubview:view];
        view.hlm_height = 1;
        view.hlm_width = [UIScreen mainScreen].bounds.size.width;
        view.hlm_y = self.segmentView.hlm_height - 1;
        view.backgroundColor = RGBA(227, 227, 227, 1);
        self.firstAppear = YES;
        
    }
    
    self.contentView.contentSize = CGSizeMake(self.contentView.hlm_width * self.segmentView.items.count, 0);
}



#pragma mark - LPSegmentedViewDelegate

- (void)segmentedView:(LPSegmentedView *)segmentedView didChangeIndex:(NSInteger)index {
    
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.hlm_width, 0) animated:YES];
    
    if (!self.childViewControllers.count) return;
    
    UIViewController *VC = self.childViewControllers[index];
    VC.view.frame = CGRectMake(index * self.contentView.hlm_width, 0, [UIScreen mainScreen].bounds.size.width, self.contentView.hlm_height);
    if ([self.contentView.subviews containsObject:VC.view]) return;
    [self.contentView addSubview:VC.view];
}

#pragma mark - getter & setter



@end
