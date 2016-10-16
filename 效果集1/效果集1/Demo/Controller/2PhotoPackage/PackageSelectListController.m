//
//  PackageSelectListController.m
//  hunlimao
//
//  Created by Jacob on 16/9/30.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "PackageSelectListController.h"
//vc
#import "PSLPackageDetailController.h"
//view
#import "LPSegmentedView.h"
#import "PackageSelectListCCell.h"
#import "SelectListHeaderView.h"
#import "PackageSelectListBottomBar.h"
#import "PSLShopCarDetailView.h"

static CGFloat const SegmentedViewH = 44;
static CGFloat const ItemBetweenMargin = 10;
static CGFloat const ColumnNum = 2.0;
static CGFloat const CollectionViewHeaderViewH = 70;

static NSString * const packageSelectListCCellID = @"PackageSelectListCCell";
static NSString * const packageSelectListHeaderViewID = @"packageSelectListHeaderViewID";

@interface PackageSelectListController ()<LPSegmentedViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, PackageSelectListBottomBarDelegate>

@property (nonatomic, weak) LPSegmentedView *segmentedView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign, getter=isRespondScroll) BOOL respondScroll; /**< 响应滚动 */
@property (nonatomic, weak) UIView *shadowView; /**< 蒙板 */
@property (nonatomic, weak) PackageSelectListBottomBar *bottomBar; /**< 底部栏 */
@property (nonatomic, weak) PSLShopCarDetailView *shopCarDetailV; /**< 购物车详情 */

@end

@implementation PackageSelectListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.respondScroll = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUpNav];
    [self setUpSeg];
    [self setUpCollectionView];
    [self setUpBottomBar];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.segmentedView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, SegmentedViewH);
    
}

- (void)setUpNav {
    self.title = @"选购婚件";
}

- (void)setUpSeg {
    
    LPSegmentedView *segmentedView = [[LPSegmentedView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, SegmentedViewH)];
    segmentedView.backgroundColor = [UIColor whiteColor];
    self.segmentedView = segmentedView;
    segmentedView.segmentedDelegate = self;
    segmentedView.items = @[@"婚件套装", @"相册", @"相框", @"照片墙",@"摆台", @"msidsg", @"sdfsdg"];
    segmentedView.firstButtonMairgin = 10;
    segmentedView.indicatorheight = 2;
    segmentedView.showHalfItemStyle = YES;
    segmentedView.halfItemIndex = 4;
    [self.view addSubview:segmentedView];
}

- (void)setUpCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = ItemBetweenMargin;
    flowLayout.minimumInteritemSpacing = ItemBetweenMargin;
    CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - 2*ItemBetweenMargin - (ColumnNum -1)*ItemBetweenMargin)/ColumnNum;
    CGFloat itemH = itemW * 3.0/2.0;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, ItemBetweenMargin, 0, ItemBetweenMargin);
    flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, CollectionViewHeaderViewH);
    
    CGFloat CVy = 64 + SegmentedViewH;
    CGFloat CVH = [UIScreen mainScreen].bounds.size.height - CVy - BottomBarH;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CVy, [UIScreen mainScreen].bounds.size.width, CVH) collectionViewLayout:flowLayout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    collectionView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PackageSelectListCCell class]) bundle:nil] forCellWithReuseIdentifier:packageSelectListCCellID];
    //注册header
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectListHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:packageSelectListHeaderViewID];
}

- (void)setUpBottomBar {
    PackageSelectListBottomBar *bottomBar = [PackageSelectListBottomBar bottomBarInParentView:self.view];
    bottomBar.delegate = self;
    [self.view addSubview:bottomBar];
    self.bottomBar = bottomBar;
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.segmentedView.items.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4 +  (arc4random() % 4); //4~7
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PackageSelectListCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:packageSelectListCCellID forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        SelectListHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:packageSelectListHeaderViewID forIndexPath:indexPath];
        
        headerView.titleLB.text = [NSString stringWithFormat:@"section %lu %@",indexPath.section,self.segmentedView.items[indexPath.section]];
        headerView.descLB.text = [NSString stringWithFormat:@"----- ------ rowcount %lu ----- ------",[self.collectionView numberOfItemsInSection:indexPath.section]];
        
        reusableview = headerView;

    }
    
    return reusableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PSLPackageDetailController *packageDetailVC = [[PSLPackageDetailController alloc] init];
    [self.navigationController pushViewController:packageDetailVC animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!self.isRespondScroll) return;
    
    if (scrollView.contentOffset.y < 20) {
        self.segmentedView.scrollToIndex = 0;
        return;
    }
    
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height - 20) {
        self.segmentedView.scrollToIndex = self.segmentedView.items.count-1;
        return;
    }
    
    NSArray<NSIndexPath *> *indexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *minIP = nil;
    NSIndexPath *maxIP = nil;
    
    indexPaths = [indexPaths sortedArrayUsingComparator:^NSComparisonResult(NSIndexPath * obj1, NSIndexPath * obj2) {
        NSComparisonResult result = [[NSNumber numberWithInteger:obj1.section] compare:[NSNumber numberWithInteger:obj2.section]];
        return result;
    }];
    
    minIP = indexPaths.firstObject;
    maxIP = indexPaths.lastObject;
    
    
    NSUInteger suitIndex = ceilf((minIP.section + maxIP.section) /2.0);
    if (suitIndex <= indexPaths.count-1) {
        NSIndexPath *suitIndexPath = indexPaths[suitIndex];
        if (suitIndexPath.section != self.segmentedView.selectedIndex) {
            self.segmentedView.scrollToIndex = suitIndexPath.section;
        }
    }
    

}

//减速停止滚动的时候展示
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.respondScroll = YES;
}

#pragma mark - LPSegmentedViewDelegate
- (void)segmentedView:(LPSegmentedView *)segmentedView didChangeIndex:(NSInteger)index {
    
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]];
    self.respondScroll = NO;
    [self.collectionView setContentOffset:CGPointMake(0, attributes.frame.origin.y - self.collectionView.contentInset.top) animated:YES];
    
}

#pragma mark - PackageSelectListBottomBarDelegate
- (void)packageSelectListBottomBar:(PackageSelectListBottomBar *)bottomBar didClickFinishBtn:(UIButton *)finishBtn {
    
}

#pragma mark - getter & setter
- (UIView *)shadowView {
    if (!_shadowView) {
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _shadowView = shadowView;
        [self.view insertSubview:shadowView belowSubview:self.bottomBar];
    }
    return _shadowView;
}



@end
