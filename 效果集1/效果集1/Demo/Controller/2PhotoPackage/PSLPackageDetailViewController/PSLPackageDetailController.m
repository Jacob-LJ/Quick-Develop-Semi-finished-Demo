//
//  PSLPackageDetailController.m
//  hunlimao
//
//  Created by Jacob on 16/10/9.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "PSLPackageDetailController.h"
//vc
#import "PSLPackageMoreDetailController.h"
//view
#import "LPAutoScrollView.h"
#import "LPImageContentView.h"
#import "PLSZoomOutBackgroundView.h"
#import "TransformUserInteractionView.h"
#import "PackageSelectListBottomBar.h"
#import "PSLDetailStyleSizeInfoView.h"
//cell
#import "PSLUpDargShowTipCell.h"
//model
#import "MiniImage.h"
//tool
#import "ThrowLineTool.h"
//const

//category
#import "UIView+Frame.h"
//lib
//#import "UIImageView+WebCache.h"
//lib nav Action
#import "KZBehavior.h"

#import "KZParallaxHeaderBehavior.h"
#import "KZNavBarGradientBehavior.h"
#import "KZMutipleProxyBehavior.h"

/*test*/
//Net

static CGFloat HLMNavgationBackButtonMaxoffset = 200;

static CGFloat backgroundImageVH = 200;

static NSString * const PSLUpDargShowTipCellID = @"PSLUpDargShowTipCell";

@interface PSLPackageDetailController ()<UITableViewDelegate, UITableViewDataSource,LPAutoScrollViewDatasource, LPAutoScrollViewDelegate, PSLDetailStyleSizeInfoViewDelegate, ThrowLineToolDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CAGradientLayer *coverLayer;

@property (nonatomic, strong) KZParallaxHeaderBehavior *headerBehavior;
@property (nonatomic, strong) KZMutipleProxyBehavior *behavior;
@property (nonatomic, strong) KZNavBarGradientBehavior *NavBarBehavior;

@property (nonatomic, strong) UIColor *normalTintColor;
@property (nonatomic, strong) UIColor *selectedTintColor;

@property (nonatomic, strong) PLSZoomOutBackgroundView *zoomBackgroundView;
@property (nonatomic, weak) LPAutoScrollView *adBannerScrollView;
@property (nonatomic, weak) UIImageView *zoomOutImageV;
@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, weak) PSLPackageMoreDetailController *moreDetailVC;
@property (nonatomic, weak) UIView *moreDetailView;
@property (nonatomic, assign) BOOL tableViewAnimate;

@property (nonatomic, weak) PackageSelectListBottomBar *bottomBar; /**< 底部栏 */

@property (nonatomic, strong) PSLDetailStyleSizeInfoView *detailStyleSizeInfoView; /**< 选择款式尺寸view */

@property (nonatomic, weak) UILabel *scrollCountLB;

@property (nonatomic, strong) UIView *anmiationV;


@end

@implementation PSLPackageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setUpBackgroundImg];
    
    [self setUpTableView];
    
    [self setUpBehaviorAction];
    
    
    [self setUpBottomBar];
    
    //test
    [self requestGetBannerData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //导航栏底部黑色半透明渐变层
    [self setNavigationBarBlackHud];
    
    [self.NavBarBehavior initializeOrRecover];
    if (self.tableView.contentOffset.y == 0) {
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    }
    
    self.adBannerScrollView.lp_shouldAutoScroll = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.coverLayer.opacity = 1;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.NavBarBehavior reset];
    self.coverLayer.opacity = 0;
    self.coverLayer = nil;
    
    self.adBannerScrollView.lp_shouldAutoScroll = NO;
}


#pragma mark - 设置头像和navBar行为
- (void)setUpBehaviorAction {
    KZNavBarGradientBehavior *navBarBeHavior = [[KZNavBarGradientBehavior alloc] init];
    self.NavBarBehavior = navBarBeHavior;
    self.NavBarBehavior.owner = self;
    
    
    KZParallaxHeaderBehavior *headerBehavior = [[KZParallaxHeaderBehavior alloc] init];
    self.headerBehavior = headerBehavior;
    self.headerBehavior.owner = self;
    self.headerBehavior.backgroundView = self.zoomBackgroundView;
    self.headerBehavior.targetView = self.tableView.tableHeaderView;
    
    KZMutipleProxyBehavior *behavior = [[KZMutipleProxyBehavior alloc] init];
    self.behavior = behavior;
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:self.headerBehavior];
    [array addObject:self];
    [array addObject:self.NavBarBehavior];
    self.behavior.delegateTargets = array;
    self.tableView.delegate = (id<UITableViewDelegate>)self.behavior;
    self.tableView.dataSource = (id<UITableViewDataSource>) self.behavior;
}

#pragma mark - 设置背景大图
- (void)setUpBackgroundImg {
    
    PLSZoomOutBackgroundView *zoomBackgroundView = [[PLSZoomOutBackgroundView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, backgroundImageVH)];
    [self.view addSubview:zoomBackgroundView];
    self.zoomBackgroundView = zoomBackgroundView;
    
    UIImageView *zoomOutImageV = [[UIImageView alloc] initWithFrame:self.zoomBackgroundView.frame];
    zoomOutImageV.hidden = YES;
    [self.zoomBackgroundView addSubview:zoomOutImageV];
    self.zoomBackgroundView.subBgImageV = zoomOutImageV;
    zoomOutImageV.contentMode = UIViewContentModeScaleAspectFill;
    self.zoomOutImageV = zoomOutImageV;
    
    
    LPAutoScrollView *adBannerScrollView = [[LPAutoScrollView alloc] initWithStyle:LPAutoScrollViewStyleHorizontal];
    adBannerScrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, backgroundImageVH);
    [adBannerScrollView lp_registerClass:[LPImageContentView class]];
    adBannerScrollView.lp_scrollDelegate = self;
    adBannerScrollView.lp_scrollDataSource = self;
    adBannerScrollView.backgroundColor = [UIColor clearColor];
    
    [self.zoomBackgroundView addSubview:adBannerScrollView];
    self.adBannerScrollView = adBannerScrollView;
    
}

#pragma mark - 设置tableview
- (void)setUpTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorColor = RGBA(242, 242, 242, 1);
    tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    self.tableView = tableView;
    tableView.scrollsToTop = NO;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
    //设置tableHeaderView
    TransformUserInteractionView *tableViewHeadV = [[TransformUserInteractionView alloc] initWithFrame:self.zoomBackgroundView.frame];
    tableViewHeadV.targetView = self.adBannerScrollView;
    tableViewHeadV.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = tableViewHeadV;
    self.tableView.autoresizingMask = UIViewAutoresizingNone;
    
    //滚动变数LB
    [self setUpScrollCountLB];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PSLUpDargShowTipCell class]) bundle:nil] forCellReuseIdentifier:PSLUpDargShowTipCellID];
}

//滚动变数LB
- (void)setUpScrollCountLB {
    
    CGFloat scrollCountLBWH = 50;
    CGFloat marginLR = 20;
    UILabel *scrollCountLB = [[UILabel alloc] initWithFrame:CGRectMake(self.zoomBackgroundView.hlm_width - scrollCountLBWH - marginLR, self.zoomBackgroundView.hlm_height - scrollCountLBWH - marginLR , scrollCountLBWH, scrollCountLBWH)];
    scrollCountLB.textAlignment = NSTextAlignmentCenter;
    scrollCountLB.text = [NSString stringWithFormat:@"0/0"];
    scrollCountLB.font = [UIFont systemFontOfSize:10];
    scrollCountLB.textColor = [UIColor lightTextColor];
    scrollCountLB.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    scrollCountLB.layer.cornerRadius = scrollCountLBWH / 2.0;
    scrollCountLB.clipsToBounds = YES;
    [self.tableView.tableHeaderView addSubview:scrollCountLB];
    self.scrollCountLB = scrollCountLB;
}

#pragma mark - 导航栏底部黑色半透明渐变层
- (void)setNavigationBarBlackHud {
    
    if (!self.coverLayer) {
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.frame =  CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width * 2, 64);
        layer.colors = @[(id)[[UIColor blackColor] colorWithAlphaComponent:0.6].CGColor, (id)[UIColor clearColor].CGColor];
        layer.startPoint = CGPointMake(0.5, 0.0);
        layer.endPoint = CGPointMake(0.5, 1.0);
        self.coverLayer = layer;
        self.coverLayer.opacity = 0;
    }
     [self.zoomBackgroundView.layer addSublayer:self.coverLayer];
    
}

#pragma mark - 底部栏
- (void)setUpBottomBar {
    PackageSelectListBottomBar *bottomBar = [PackageSelectListBottomBar bottomBarInParentView:self.view];
//    bottomBar.delegate = self;
    [self.view addSubview:bottomBar];
    self.bottomBar = bottomBar;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    } else if (section == 1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;

    if (section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text = [NSString stringWithFormat:@"section - %lu   row - %lu",indexPath.section, indexPath.row];
        cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
        return cell;
    } else if (section == 1) {
        PSLUpDargShowTipCell *cell = [tableView dequeueReusableCellWithIdentifier:PSLUpDargShowTipCellID];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        return 100;
    } else if (section == 1) {
        return 100;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[UIApplication sharedApplication].keyWindow addSubview:self.detailStyleSizeInfoView];
    [self.detailStyleSizeInfoView showPopupAllContainerView];
}

#pragma mark - LPAutoScrollViewDatasource & LPAutoScrollViewDelegate

- (NSUInteger)lp_numberOfNewsDataInScrollView:(LPAutoScrollView *)scrollView {
    return 10;
}

- (void)lp_scrollView:(LPAutoScrollView *)scrollView didTappedContentViewAtIndex:(NSUInteger)index {
    
    
}

- (void)lp_scrollView:(LPAutoScrollView *)scrollView didDidScrollToPage:(NSUInteger)page {
    self.currentPage = page;
    self.scrollCountLB.text = [NSString stringWithFormat:@"%ld/%ld",page,10];
}

- (void)lp_scrollView:(LPAutoScrollView *)scrollView newsDataAtIndex:(NSUInteger)index forContentView:(LPImageContentView *)contentView {
//    MiniImage *curImage = self.photoTravel.images[index];
//    [contentView.imageView sd_setImageWithURL:[NSURL URLWithString:curImage.url] placeholderImage:[UIImage imageNamed:@"loading_image"]];
}


#pragma mark - scrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView) {
        //处理bannerView
        self.adBannerScrollView.lp_shouldAutoScroll = NO;
        self.adBannerScrollView.hidden = YES;
        self.zoomOutImageV.hidden = NO;
//        MiniImage* curImage = self.photoTravel.images[self.currentPage];
//         [self.zoomOutImageV sd_setImageWithURL:[NSURL URLWithString:curImage.url] placeholderImage:[UIImage imageNamed:@"loading_image"]];
        
    }
    
    if (scrollView == self.adBannerScrollView) {
        self.zoomOutImageV.hidden = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView) {
        
        //处理bannerView
        self.adBannerScrollView.lp_shouldAutoScroll = NO;
        self.adBannerScrollView.hidden = YES;
        self.zoomOutImageV.hidden = NO;
        
        //处理nav
        CGFloat offsetY = scrollView.contentOffset.y;
        
        UIColor *tintColor = nil;
        UIColor *selectedTintColor = nil;
        if ( offsetY > 0 ) {
            
            CGFloat alpha  = 1;
            
            CGFloat offset = HLMNavgationBackButtonMaxoffset / 2.0;
            
            if (offsetY < offset) {
                alpha = 1 - offsetY / offset;
                tintColor = [UIColor colorWithWhite:1 alpha:alpha];
                selectedTintColor = [UIColor colorWithWhite:1 alpha:alpha];
                
            }else{
                
                alpha = offsetY / offset - 1;
                tintColor   = RGBA(102, 102, 102, alpha);
                selectedTintColor = RGBA(255, 115, 133, alpha);
            }
            self.normalTintColor = tintColor;
            self.selectedTintColor = selectedTintColor;
            self.navigationItem.leftBarButtonItem.tintColor = tintColor;
        }
        
        self.zoomBackgroundView.hidden = (offsetY > HLMNavgationBackButtonMaxoffset);
        
//        NSLog(@"offsetY -----  %f", offsetY);
//        NSLog(@"y ++++++  %f", scrollView.frame.origin.y);
        
        if (offsetY < 0) return;
    
        CGFloat contentHeight = scrollView.contentSize.height - [UIScreen mainScreen].bounds.size.height + scrollView.contentInset.bottom;
    
        CGFloat newY = offsetY - contentHeight;
    
        if (offsetY >= contentHeight && !self.tableViewAnimate && self.tableView.hlm_y == 0) {
    
            self.moreDetailView.hlm_y = self.bottomBar.hlm_y - newY;
            
        }
    }
    
    
}

//减速停止滚动的时候展示
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView != self.tableView) return;
    
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height - [UIScreen mainScreen].bounds.size.height + scrollView.contentInset.bottom;
    
    if (offset > contentHeight + MAXOffetY) {
        
        if (![self.view.subviews containsObject:self.moreDetailVC.view]) {
            
            [self.view insertSubview:self.moreDetailView belowSubview:self.bottomBar];
            self.moreDetailView.hlm_x = 0;
            self.moreDetailView.hlm_width = [UIScreen mainScreen].bounds.size.width;
            self.moreDetailView.hlm_height = [UIScreen mainScreen].bounds.size.height;
            self.moreDetailView.hlm_y = self.bottomBar.hlm_y;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.tableView.hlm_y = - [UIScreen mainScreen].bounds.size.height;
            self.moreDetailView.hlm_y = 64;
            self.tableViewAnimate = YES;
            
        } completion:^(BOOL finished) {
            
            self.tableViewAnimate = NO;
            
        }];
        
    }
    
    [self scrollViewDidEndDecelerating:scrollView];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView != self.tableView) return;
    //处理bannerView
    if (scrollView.contentOffset.y == 0 || self.zoomBackgroundView.hlm_width == [UIScreen mainScreen].bounds.size.width) {
        self.adBannerScrollView.lp_shouldAutoScroll = YES;
        self.adBannerScrollView.hidden = NO;
        self.zoomOutImageV.hidden = YES;
    }
}

#pragma mark - PSLDetailStyleSizeInfoViewDelegate
- (void)PSLDetailStyleSizeInfoView:(PSLDetailStyleSizeInfoView *)detailStyleSizeInfoView didClickThrowToShopCarBtn:(UIButton *)throwBtn {
    CGFloat btnW = throwBtn.bounds.size.width;
    CGFloat btnH = throwBtn.bounds.size.height;
    CGRect newRect = [throwBtn convertRect:CGRectMake(0, 0, btnW, btnH) toView:nil];
    UIView *animationV = [[UIView alloc] initWithFrame:newRect];
    animationV.backgroundColor = throwBtn.backgroundColor;
    [[UIApplication sharedApplication].keyWindow addSubview:animationV];
    self.anmiationV = animationV;
    
    //获取购物车按钮相对于window的位置
    CGRect shopCarNewRect = [self.bottomBar.shopCarBtn convertRect:CGRectMake(0, 0, self.bottomBar.shopCarBtn.hlm_width, self.bottomBar.shopCarBtn.hlm_height) toView:nil];
    //抛物线落点
    CGPoint shopCarCenterPoint = CGPointMake(shopCarNewRect.origin.x, shopCarNewRect.origin.y);
    //抛物线工具
    ThrowLineTool *throwLineTool = [ThrowLineTool sharedTool];
    throwLineTool.delegate = self;
    
    [UIView animateWithDuration:kAnimationTime animations:^{
        animationV.layer.cornerRadius = btnH/2.0;
        animationV.layer.bounds = CGRectMake(0, 0, btnH, btnH);
    } completion:^(BOOL finished) {
        [throwLineTool throwObject:animationV from:animationV.center to:shopCarCenterPoint];
    }];
}

#pragma mark - ThrowLineToolDelegate
//抛物线跌落完成后
- (void)animationDidFinish {
    [self.anmiationV removeFromSuperview];
    self.bottomBar.shopCarBtn.bageValue += 1;
    [UIView animateWithDuration:0.1 animations:^{
        self.bottomBar.shopCarBtn.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.bottomBar.shopCarBtn.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
        }];
        
    }];
}

#pragma mark - Action

- (void)resetAnimate {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.tableViewAnimate = YES;
        self.tableView.hlm_y = 0;
        self.moreDetailView.hlm_y = self.bottomBar.hlm_y;
        
    } completion:^(BOOL finished) {
        
        self.tableViewAnimate = NO;
    }];
    
}

//test
#pragma mark - NetWork
/**
 *  从服务器获取广告
 */
- (void)requestGetBannerData {
    
    
}


#pragma mark - getter & setter
- (PSLPackageMoreDetailController *)moreDetailVC {
    if (!_moreDetailVC) {
        PSLPackageMoreDetailController *moreVC = [[PSLPackageMoreDetailController alloc] init];
        _moreDetailVC = moreVC;
        _moreDetailView = moreVC.view;
        [self addChildViewController:_moreDetailVC];
    }
    return _moreDetailVC;
}

- (PSLDetailStyleSizeInfoView *)detailStyleSizeInfoView {
    if (!_detailStyleSizeInfoView) {
        _detailStyleSizeInfoView = [PSLDetailStyleSizeInfoView viewFromXib];
        _detailStyleSizeInfoView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _detailStyleSizeInfoView.delegate = self;
    }
    return _detailStyleSizeInfoView;
}

@end
