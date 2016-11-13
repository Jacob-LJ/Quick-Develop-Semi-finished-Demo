//
//  WeddingCyclopediaController.m
//  hunlimao
//
//  Created by Jacob on 16/11/10.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "WeddingCyclopediaController.h"
//view
#import "LPAutoScrollView.h"
#import "LPImageContentView.h"
#import "WCPediaZoomOutBgView.h"
#import "TransformUserInteractionView.h"
#import "WCPediaCategoryWordsCell.h"
#import "WCPediaEditHotWordCell.h"
#import "WCPediaSectionView.h"
#import "WCPediaFooterSectionView.h"
#import "WCPediaPageControlView.h"
//category
#import "UIView+Frame.h"
//lib nav Action
#import "KZBehavior.h"
#import "KZParallaxHeaderBehavior.h"
#import "KZMutipleProxyBehavior.h"

//屏幕宽高
#define HLMScreenW [UIScreen mainScreen].bounds.size.width
#define HLMScreenH [UIScreen mainScreen].bounds.size.height
#define HLMNavBarH (64)

#define backgroundImageVH (HLMScreenW*0.56)

@interface WeddingCyclopediaController ()<UITableViewDelegate, UITableViewDataSource,LPAutoScrollViewDatasource, LPAutoScrollViewDelegate, WCPediaFooterSectionViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) KZParallaxHeaderBehavior *headerBehavior;
@property (nonatomic, strong) KZMutipleProxyBehavior *behavior;

@property (nonatomic, strong) WCPediaZoomOutBgView *zoomBackgroundView;
@property (nonatomic, strong) LPAutoScrollView *adBannerScrollView;
@property (nonatomic, weak) UIImageView *zoomOutImageV;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) BOOL openAll; /**< 展开所有类目 */
@property (nonatomic, strong) WCPediaCategoryWordsCell *temCell; /**< 历史记录用于调用cell内部的方法 */
@property (nonatomic, weak) WCPediaPageControlView *pageControlView;

@end

@implementation WeddingCyclopediaController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBackgroundImg];
    
    [self setUpTableView];
    
    [self setUpBehaviorAction];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"可滚动放大header";
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItem.frame = CGRectMake(0, 0, 44, 44);
    [rightItem setImage:[UIImage imageNamed:@"magnifier"] forState:UIControlStateNormal];
    [rightItem addTarget:self action:@selector(didClickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.adBannerScrollView.lp_shouldAutoScroll = NO;
}

#pragma mark - 设置背景大图
- (void)setUpBackgroundImg {
    
    WCPediaZoomOutBgView *zoomBackgroundView = [[WCPediaZoomOutBgView alloc] initWithFrame: CGRectMake(0, HLMNavBarH, HLMScreenW, backgroundImageVH)];
    [self.view addSubview:zoomBackgroundView];
    self.zoomBackgroundView = zoomBackgroundView;
    
    UIImageView *zoomOutImageV = [[UIImageView alloc] initWithFrame:self.zoomBackgroundView.frame];
    zoomOutImageV.hidden = YES;
    zoomOutImageV.contentMode = UIViewContentModeScaleAspectFill;
    zoomOutImageV.clipsToBounds = YES;
    [self.zoomBackgroundView addSubview:zoomOutImageV];
    self.zoomBackgroundView.subBgImageV = zoomOutImageV;
    self.zoomOutImageV = zoomOutImageV;
    
    [self.zoomBackgroundView addSubview:self.adBannerScrollView];
    
}

//滚动变数PageControl
- (void)setUpScrollPageControl {
    WCPediaPageControlView *pageControlView = [WCPediaPageControlView viewFromXib];
    pageControlView.frame = CGRectMake(0, CGRectGetMaxY(self.zoomBackgroundView.frame)-HLMNavBarH-WCPediaPageControlViewHeight, HLMScreenW, WCPediaPageControlViewHeight);
    pageControlView.totalPagesCount = 3;
    [self.tableView.tableHeaderView addSubview:pageControlView];
    self.pageControlView = pageControlView;
}

#pragma mark - 设置tableview
- (void)setUpTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HLMNavBarH, HLMScreenW, HLMScreenH) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.scrollsToTop = NO;
    self.tableView = tableView;
    
    //设置tableHeaderView
    TransformUserInteractionView *tableViewHeadV = [[TransformUserInteractionView alloc] initWithFrame:self.zoomBackgroundView.frame];
    tableViewHeadV.targetView = self.adBannerScrollView;
    tableViewHeadV.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = tableViewHeadV;
    self.tableView.autoresizingMask = UIViewAutoresizingNone;
    
    //滚动变数PageControl
    [self setUpScrollPageControl];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WCPediaCategoryWordsCell class]) bundle:nil] forCellReuseIdentifier:WCPediaCategoryWordsCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WCPediaEditHotWordCell class]) bundle:nil] forCellReuseIdentifier:WCPediaEditHotWordCellID];
}

#pragma mark - 设置头像和navBar行为
- (void)setUpBehaviorAction {
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
    self.behavior.delegateTargets = array;
    self.tableView.delegate = (id<UITableViewDelegate>)self.behavior;
    self.tableView.dataSource = (id<UITableViewDataSource>) self.behavior;
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WCPediaCategoryWordsCell *cell = [tableView dequeueReusableCellWithIdentifier:WCPediaCategoryWordsCellID];
        cell.openAll = self.openAll;
        self.temCell = cell;
        return cell;
    } else {
        WCPediaEditHotWordCell *cell = [tableView dequeueReusableCellWithIdentifier:WCPediaEditHotWordCellID];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self.temCell cellHeight];
    }
    return 71; 
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return PediaFooterSectionViewHeight;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        WCPediaSectionView *sectionView = [WCPediaSectionView viewFromXib];
        return sectionView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        WCPediaFooterSectionView *footerView = [WCPediaFooterSectionView viewFromXib];
        footerView.delegate = self;
        footerView.showTipStr = self.openAll?@"收起所有类目":@"展开所有类目";
        return footerView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


#pragma mark - LPAutoScrollViewDatasource & LPAutoScrollViewDelegate

- (NSUInteger)lp_numberOfNewsDataInScrollView:(LPAutoScrollView *)scrollView {
    return 3;
}

- (void)lp_scrollView:(LPAutoScrollView *)scrollView didTappedContentViewAtIndex:(NSUInteger)index {
    
}

- (void)lp_scrollView:(LPAutoScrollView *)scrollView didDidScrollToPage:(NSUInteger)page {
    self.currentPage = page;
    self.pageControlView.currentIndex = page;
    
}

- (void)lp_scrollView:(LPAutoScrollView *)scrollView newsDataAtIndex:(NSUInteger)index forContentView:(LPImageContentView *)contentView {
    
//    MiniImage *curImage = self.weddingItem.coverImages[index];
//    [contentView.imageView sd_setImageWithURL:[NSURL URLWithString:curImage.url] placeholderImage:[UIImage imageNamed:@"loading_image"]];
    
    contentView.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"launch%ld",index]];
}

#pragma mark - scrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView) {
        //处理bannerView
        self.adBannerScrollView.hidden = YES;
        self.zoomOutImageV.hidden = NO;
//        MiniImage* curImage = self.weddingItem.coverImages[self.currentPage];
//        [self.zoomOutImageV sd_setImageWithURL:[NSURL URLWithString:curImage.url] placeholderImage:[UIImage imageNamed:@"loading_image"]];
        self.zoomOutImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"launch%ld",self.currentPage]];
    }
    
    if (scrollView == self.adBannerScrollView) {
        self.zoomOutImageV.hidden = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView) {
        
        //处理bannerView
        self.adBannerScrollView.hidden = YES;
        self.zoomOutImageV.hidden = NO;
        
        CGFloat offsetY = scrollView.contentOffset.y;
        self.zoomBackgroundView.hidden = (offsetY > backgroundImageVH);
        if (offsetY <= 0) {
            self.zoomBackgroundView.hlm_y = HLMNavBarH;
        } else if (offsetY < HLMNavBarH) {
            self.zoomBackgroundView.hlm_y = HLMNavBarH - offsetY;
        } else if (offsetY >= HLMNavBarH) {
            self.zoomBackgroundView.hlm_y = HLMNavBarH - offsetY;
        }
    }
    
}

//减速停止滚动的时候展示
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView != self.tableView) return;
    
    [self scrollViewDidEndDecelerating:scrollView];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView != self.tableView) return;
    //处理bannerView
    if (scrollView.contentOffset.y == 0 || self.zoomBackgroundView.hlm_width == HLMScreenW) {
        self.adBannerScrollView.hidden = NO;
        self.zoomOutImageV.hidden = YES;
    }
    
}

#pragma mark - WCPediaFooterSectionViewDelegate
- (void)showAllCategoryWordsWithPediaFooterSectionView:(WCPediaFooterSectionView *)pediaFooterSectionView {
    self.openAll = !self.openAll;
    [self.tableView reloadData];
}

#pragma mark - Action
- (void)didClickSearchBtn {
    NSLog(@"点击搜索@!!!!!");
}

#pragma mark - getter & setter
- (LPAutoScrollView *)adBannerScrollView {
    if (!_adBannerScrollView) {
        
        LPAutoScrollView *adBannerScrollView = [[LPAutoScrollView alloc] initWithStyle:LPAutoScrollViewStyleHorizontal];
        adBannerScrollView.frame = CGRectMake(0, 0, HLMScreenW, backgroundImageVH);
        [adBannerScrollView lp_registerClass:[LPImageContentView class]];
        adBannerScrollView.lp_scrollDelegate = self;
        adBannerScrollView.lp_scrollDataSource = self;
        adBannerScrollView.backgroundColor = [UIColor clearColor];
        adBannerScrollView.lp_shouldAutoScroll = NO;
        _adBannerScrollView = adBannerScrollView;
    }
    return _adBannerScrollView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
