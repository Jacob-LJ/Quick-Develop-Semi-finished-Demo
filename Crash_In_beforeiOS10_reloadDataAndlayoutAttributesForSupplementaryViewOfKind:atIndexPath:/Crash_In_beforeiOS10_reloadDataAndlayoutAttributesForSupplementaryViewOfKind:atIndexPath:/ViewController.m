//
//  ViewController.m
//  Crash_In_beforeiOS10_reloadDataAndlayoutAttributesForSupplementaryViewOfKind:atIndexPath:
//
//  Created by Jacob on 16/11/21.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "MyHeaderOrFooterView.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    
    [self.collectionView reloadData];
    
#warning    1:iOS10之前系统, 当CollectionView 调用 reloadData 时(在不太确定的时间范围内)即刻调用layoutAttributesForSupplementaryViewOfKind:atIndexPath时 会 崩溃
    
#warning    2:iOS10之前系统, 当CollectionView 先调用layoutAttributesForSupplementaryViewOfKind:atIndexPath 时即刻调用reloadData时 不会 崩溃
    
#warning    3:一般在界面加载时候回默认进行一次collectionView的 reloadData, 所以在此期间要确保不要调用 layoutAttributesForSupplementaryViewOfKind:atIndexPath 方法
    UICollectionViewLayoutAttributes *attributes;
    attributes = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:(arc4random() % 4)]];
    
    [self.collectionView setContentOffset:CGPointMake(0, attributes.frame.origin.y - self.collectionView.contentInset.top) animated:YES];
    
}

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4 + (arc4random() % 12);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MyHeaderOrFooterView *view;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        view.backgroundColor = [UIColor orangeColor];
        
    } else {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
        view.backgroundColor = [UIColor blueColor];
    }
    view.descLB1.text = [NSString stringWithFormat:@"section - %ld //// item - %ld",indexPath.section,indexPath.item];
    return view;
}


@end
