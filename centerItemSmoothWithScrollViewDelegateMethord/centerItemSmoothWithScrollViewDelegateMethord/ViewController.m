//
//  ViewController.m
//  centerItemSmoothWithScrollViewDelegateMethord
//
//  Created by Jacob_Liang on 16/11/5.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "ImageCell.h"

#define JAItemWidth 70
#define JAItemHeight 70

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *images;
@end

static NSString *const identifer = @"ImageCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置为水平滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置每个Item之间的距离
    flowLayout.minimumLineSpacing = 100;
    // 重新设置Item的尺寸，不然的话，有等比例缩小的可能
    flowLayout.itemSize = CGSizeMake(JAItemWidth, JAItemHeight);
    
    CGRect rect = CGRectMake(0, 250, self.view.frame.size.width,100);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 注册collectionView(因为是从xib中加载cell的,所以registerNib)
    [collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:identifer];
    
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
    
    CGFloat inset = (self.collectionView.frame.size.width - JAItemWidth) * 0.5;
    // 设置第一个和最后一个默认居中显示
    self.collectionView.contentInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

#pragma mark - 点击屏幕空白处，切换布局模式
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    if ([self.collectionView.collectionViewLayout isKindOfClass:[centerAndScaleFlowLayout class]]) {
//        [self.collectionView setCollectionViewLayout:[[LFNormalLayout alloc] init] animated:YES];

//    }
//    else{
//        [self.collectionView setCollectionViewLayout:[[centerAndScaleFlowLayout alloc] init] animated:YES];

//    }
//
//}

#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    
    cell.iconName = self.images[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 删除模型数据
    [self.images removeObjectAtIndex:indexPath.item];
    
    // 2. 删除UI元素
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

- (NSMutableArray *)images {
    if (!_images) {
        _images = [NSMutableArray array];
        for (int i=1;i<=31;i++) {
            [_images addObject:[NSString stringWithFormat:@"%d_full",i]];
        }
    }
    return _images;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGPoint originalTargetContentOffset = CGPointMake(targetContentOffset->x, targetContentOffset->y);
    CGPoint targetCenter = CGPointMake(originalTargetContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2, CGRectGetHeight(self.collectionView.bounds) / 2);
    NSIndexPath *indexPath = nil;
    NSInteger i = 0;
    while (indexPath == nil) {
        targetCenter = CGPointMake(originalTargetContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2 + 10*i, CGRectGetHeight(self.collectionView.bounds) / 2);
        indexPath = [self.collectionView indexPathForItemAtPoint:targetCenter];
        i++;
    }
//    self.selectedIndex = indexPath;
    //这里用attributes比用cell要好很多，因为cell可能因为不在屏幕范围内导致cellForItemAtIndexPath返回nil
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
    if (attributes) {
        *targetContentOffset = CGPointMake(attributes.center.x - CGRectGetWidth(self.collectionView.bounds)/2, originalTargetContentOffset.y);
    } else {
        NSLog(@"center is %@; indexPath is {%@, %@}; cell is %@",NSStringFromCGPoint(targetCenter), @(indexPath.section), @(indexPath.item), attributes);
    }
}

@end
