//
//  ViewController.m
//  transitonParallaxDemo
//
//  Created by Jacob on 16/11/19.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "ListCCell.h"

#import "UIViewController+BCMagicTransition.h"
#import "DestinationViewController.h"
#import "UIViewController+BCMagicTransition.h"

#define DefaultHeaderScale (200 / 375.0)
#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, BCMagicTransitionProtocol>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *hotPlacesArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.hotPlacesArray = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        NSString *picStr = [NSString stringWithFormat:@"photo_%d",i];
        [self.hotPlacesArray addObject:picStr];
    }
    [self setUpCollectionView];
}

- (void)setUpCollectionView {
    
    self.flowLayout.minimumLineSpacing = 1;
    self.flowLayout.minimumInteritemSpacing = 1;
    self.flowLayout.itemSize = CGSizeMake(ScreenW, ScreenW * DefaultHeaderScale);
}

#pragma mark UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hotPlacesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listCellID" forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:self.hotPlacesArray[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DestinationViewController *hotPlaceVC = [[DestinationViewController alloc] init];
    ListCCell *cell = (ListCCell *)[collectionView cellForItemAtIndexPath:indexPath];
    hotPlaceVC.photoStr = self.hotPlacesArray[indexPath.row];
    [hotPlaceVC view];
    
    [self pushViewController:hotPlaceVC fromView:cell.imageV toView:hotPlaceVC.backgroundImageView duration:0.5];
     /**< 必须让跳转的源控制器和目的地控制器 都遵守 BCMagicTransitionProtocol 协议 否则只是简单push而已,没有view的移动动画 */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
