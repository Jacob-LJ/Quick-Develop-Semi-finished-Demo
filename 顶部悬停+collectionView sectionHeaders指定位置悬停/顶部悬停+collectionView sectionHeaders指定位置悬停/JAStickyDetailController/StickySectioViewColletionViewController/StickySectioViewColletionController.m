//
//  StickySectioViewColletionController.m
//  顶部悬停+collectionView sectionHeaders指定位置悬停
//
//  Created by Jacob_Liang on 16/10/16.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "StickySectioViewColletionController.h"
//vc
#import "OutterContainerController.h"
//view
#import "StickyCCell.h"
#import "StickyHeaderReusableView.h"
//category
#import "UIView+Frame.h"


static CGFloat NavgationBackButtonMaxoffset = 200.f;

@interface StickySectioViewColletionController ()

@end

@implementation StickySectioViewColletionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpCollectionView];
}

- (void)setUpCollectionView {
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    self.collectionView.contentInset = UIEdgeInsetsMake(TableHeaderViewHeight - 64, 0, 0, 0);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(TableHeaderViewHeight - 64, 0, 0, 0);
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([StickyCCell class]) bundle:nil] forCellWithReuseIdentifier:StickyCCellID];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([StickyHeaderReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:StickyHeaderReusableViewID];
}



#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StickyCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:StickyCCellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(0.f, 30.f);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        StickyHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                            withReuseIdentifier:StickyHeaderReusableViewID
                                                                                                   forIndexPath:indexPath];
        headerView.descLB.text = [NSString stringWithFormat:@"section - %ld ; item - %ld",indexPath.section, indexPath.item];
        return headerView;
    } else {
        return nil;
    }
    return nil;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击了 -- %@ -- section %ld -- item %ld ",NSStringFromClass([self class]),indexPath.section,indexPath.item);
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.collectionView) {
        
        OutterContainerController *parentVC = (OutterContainerController *)self.parentViewController;
        UINavigationBar *navBar = parentVC.navigationController.navigationBar;
        
        //处理nav
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat specilaValue = TableHeaderViewHeight - 64;
        
        NSLog(@" ---- +++++  %f",offsetY);
        
        UIColor *tintColor = nil;
        UIColor *selectedTintColor = nil;
        if ( offsetY > -specilaValue ) {
            
            CGFloat alpha  = 1;
            
            CGFloat offset = NavgationBackButtonMaxoffset / 2.0;
            
            if (offsetY < offset) {
                alpha = 1 - offsetY / offset;
                tintColor = [UIColor colorWithWhite:1 alpha:alpha];
                selectedTintColor = [UIColor colorWithWhite:1 alpha:alpha];
                
            }else{
                
                alpha = offsetY / offset - 1;
                tintColor   = [UIColor colorWithRed:102 green:102 blue:102 alpha:alpha];
                selectedTintColor = [UIColor colorWithRed:255 green:115 blue:133 alpha:alpha];
              
            }
            parentVC.normalTintColor = tintColor;
            parentVC.selectedTintColor = selectedTintColor;
            parentVC.navigationItem.leftBarButtonItem.tintColor = tintColor;
        }
        
        
        CGFloat y = (offsetY + scrollView.contentInset.top); //将特殊值抽出来然后使用 是防止直接使用变化过快的 offset y 值进行赋值而产生偏移位置不正确结果
        NSLog(@" ---- y %f",y);
        //此处不应设置两个判断条件(如 : y <= 0 && y >= -(TableHeaderViewHeight - 64)), 因为这样会导致偏移正确结果
        if (y >= specilaValue) {
            y = specilaValue;
        }
        navBar.alpha = y/specilaValue;
        parentVC.containerHeaderView.hlm_y = -y;
    }
    
}



@end
