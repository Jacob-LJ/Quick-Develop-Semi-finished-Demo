//
//  DestinationViewController.m
//  transitonParallaxDemo
//
//  Created by Jacob on 16/11/19.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "DestinationViewController.h"
//category
#import "UIView+Frame.h"
//lib
#import "KZBehavior.h"
#import "KZParallaxHeaderBehavior.h"
#import "KZNavBarGradientBehavior.h"
#import "KZMutipleProxyBehavior.h"

#import "UIViewController+BCMagicTransition.h"


#define DefaultHeaderScale (200 / 375.0)
#define DefaultPackageCellHeight ((18 / 35.0) * HLMScreenW + 70)
#define DefaultWorkCellHeight (((HLMScreenW - 25) * 0.5) + 65)
#define DefaultStoryCellHeight ((16 / 35.0) * HLMScreenW + 90)


static CGFloat backgroundImageVH = 0;
static CGFloat headerViewMargin = 20;

@interface DestinationViewController ()<UITableViewDelegate, UITableViewDataSource, BCMagicTransitionProtocol>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) KZParallaxHeaderBehavior *headerBehavior;
@property (nonatomic, strong) KZMutipleProxyBehavior *behavior;
@property (nonatomic, strong) KZNavBarGradientBehavior *NavBarBehavior;

@property (nonatomic, strong) CAGradientLayer *coverLayer;
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, assign) BOOL headViewAnimateFinished;

@end

@implementation DestinationViewController


- (instancetype)init {
    if (self = [super init]) {
        backgroundImageVH = HLMScreenW * DefaultHeaderScale;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeBackgroundColor;
    
    [self setUpBackgroundImg];
    
    [self setUpTableView];
    
    [self setUpBehaviorAction];
    
    //导航栏底部黑色半透明渐变层
    [self setNavigationBarBlackHud];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.NavBarBehavior initializeOrRecover];
    
    
    //可能用于再次 push 然后回来的效果设置
//    if (self.tableView.contentOffset.y == - (backgroundImageVH - headerViewMargin)) {
//        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
//    }
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.coverLayer.opacity = 1;
    
    
    if (!self.headViewAnimateFinished) {
        [self requestCityDetail];
    }
    
}

- (void)customAnimate {
    
    self.tableView.hlm_y = HLMScreenH;
    self.tableView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.tableView.hlm_y = 0;
        
    } completion:^(BOOL finished) {
        
        self.tableView.userInteractionEnabled = YES;
        self.headViewAnimateFinished = YES;
        [self.tableView reloadData];
        
        
    }];
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.tableView.tableHeaderView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.NavBarBehavior reset];
    
    self.coverLayer.opacity = 0;
}

#pragma mark - 设置头像和navBar行为
- (void)setUpBehaviorAction {
    KZNavBarGradientBehavior *navBarBeHavior = [[KZNavBarGradientBehavior alloc] init];
    self.NavBarBehavior = navBarBeHavior;
    self.NavBarBehavior.owner = self;
    self.NavBarBehavior.criticalOffset = backgroundImageVH;
    
    
    KZParallaxHeaderBehavior *headerBehavior = [[KZParallaxHeaderBehavior alloc] init];
    self.headerBehavior = headerBehavior;
    self.headerBehavior.owner = self;
    self.headerBehavior.backgroundView = self.backgroundImageView;
    self.headerBehavior.targetView = self.tableView.tableHeaderView;
    headerBehavior.startContentOffset = CGPointMake(0, - (backgroundImageVH - headerViewMargin));
    
    KZMutipleProxyBehavior *behavior = [[KZMutipleProxyBehavior alloc] init];
    self.behavior = behavior;
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:self.headerBehavior];
    [array addObject:self];
    [array addObject:self.NavBarBehavior];
    self.behavior.delegateTargets = array;
    self.tableView.delegate =(id<UITableViewDelegate>)self.behavior;
    self.tableView.dataSource =(id<UITableViewDataSource>) self.behavior;
}

#pragma mark - 设置背景大图
- (void)setUpBackgroundImg {
    UIImageView *bgImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, HLMScreenW, backgroundImageVH)];
    bgImageV.clipsToBounds = YES;
    bgImageV.image = [UIImage imageNamed:self.photoStr];
    bgImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgImageV];
    self.backgroundImageView = bgImageV;
}

#pragma mark - 设置tableview
- (void)setUpTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, HLMScreenW, HLMScreenH) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    self.headerView = headerView;
    headerView.alpha = 0;
    headerView.frame = CGRectMake(0, 0, HLMScreenW, 190);
    self.tableView.tableHeaderView = headerView;
    
    
    tableView.contentInset = UIEdgeInsetsMake(backgroundImageVH - headerViewMargin, 0, 0, 0);
}


#pragma mark - 导航栏底部黑色半透明渐变层

- (void)setNavigationBarBlackHud {
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame =  CGRectMake(0, 0, HLMScreenW * 2, 64);
    layer.colors = @[(id)[[UIColor blackColor] colorWithAlphaComponent:0.6].CGColor, (id)[UIColor clearColor].CGColor];
    layer.startPoint = CGPointMake(0.5, 0.0);
    layer.endPoint = CGPointMake(0.5, 1.0);
    self.coverLayer = layer;
    self.coverLayer.opacity = 0;
    [self.backgroundImageView.layer insertSublayer:layer atIndex:0];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if ( offsetY > 0 ) {
        
        UIColor *tintColor = nil;
        CGFloat alpha  = 1;
        
        CGFloat offset = backgroundImageVH / 2.0;
        
        if (offsetY < offset) {
            alpha = 1 - offsetY / offset;
            tintColor = [UIColor colorWithWhite:1 alpha:alpha];
            
        }else{
            
            alpha = offsetY / offset - 1;
            tintColor   = RGBA(102, 102, 102, alpha);
        }
        
        self.navigationItem.leftBarButtonItem.tintColor = tintColor;
        self.navigationItem.rightBarButtonItem.tintColor = tintColor;
    }
    
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat rowHeight = 0;
    
    if (indexPath.section == 0) {
        rowHeight = DefaultPackageCellHeight;
    } else if (indexPath.section == 1) {
        rowHeight = DefaultWorkCellHeight;
    } else if (indexPath.section == 2) {
        rowHeight = DefaultStoryCellHeight;
    }
    
    return rowHeight + 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.headViewAnimateFinished) {
        cell.contentView.alpha = 0.0;
    }
    
    if (self.headViewAnimateFinished && cell.contentView.alpha == 0.0) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            cell.contentView.alpha = 1.0;
            
            
        }];
        
    }
    
}



#pragma mark - NetWork Request

- (void)requestCityDetail {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self customAnimate];
        
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
