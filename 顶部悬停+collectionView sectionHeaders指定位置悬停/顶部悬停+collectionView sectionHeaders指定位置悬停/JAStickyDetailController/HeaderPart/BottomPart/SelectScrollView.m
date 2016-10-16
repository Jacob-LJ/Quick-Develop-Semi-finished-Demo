//
//  SelectScrollView.m
//  顶部悬停+collectionView sectionHeaders指定位置悬停
//
//  Created by Jacob_Liang on 16/10/16.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "SelectScrollView.h"

#import "SelectScrollViewCCell.h"

@interface SelectScrollView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation SelectScrollView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpCollectionView];
}


- (void)setUpCollectionView {
    
    self.flowLayout.itemSize = CGSizeMake(100, 100);
    self.flowLayout.minimumLineSpacing = 5;
    self.flowLayout.minimumInteritemSpacing = 5;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectScrollViewCCell class]) bundle:nil] forCellWithReuseIdentifier:SelectScrollViewCCellID];
}



#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SelectScrollViewCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SelectScrollViewCCellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了 -- %@ -- section %ld -- item %ld ",NSStringFromClass([self class]),indexPath.section,indexPath.item);
}


@end
