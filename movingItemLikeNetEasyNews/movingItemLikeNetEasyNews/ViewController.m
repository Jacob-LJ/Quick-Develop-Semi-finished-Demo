//
//  ViewController.m
//  movingItemLikeNetEasyNews
//
//  Created by Jacob_Liang on 16/11/14.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "MovingCCell.h"
#import "ReusableSectionView.h"

#define JAScreenW [UIScreen mainScreen].bounds.size.width
#define JAScreenH [UIScreen mainScreen].bounds.size.height
#define Column 4
#define Margin 10

static NSString *const MovingCCellID = @"MovingCCell";
static NSString *const ReusableSectionViewID = @"ReusableSectionView";

@interface ViewController ()<UICollectionViewDelegate ,UICollectionViewDataSource>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *firstList;
@property (nonatomic, strong) NSMutableArray *secondList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.firstList = [NSMutableArray array];
    for (int i = 0; i < 10; ++i) {
        NSString *titleText = [NSString stringWithFormat:@"section1-%d",i];
        [self.firstList addObject:titleText];
    }
    
    self.secondList = [NSMutableArray array];
    for (int i = 0; i < 10; ++i) {
        NSString *titleText = [NSString stringWithFormat:@"section2-%d",i];
        [self.secondList addObject:titleText];
    }
    
    [self setUpCollectionView];
}

- (void)setUpCollectionView {
    
    CGFloat ItemW = (JAScreenW - (Column - 1)*Margin)/Column;
    CGFloat ItemH = 50;
    self.flowLayout.itemSize = CGSizeMake(ItemW, ItemH);
    self.flowLayout.minimumLineSpacing = Margin;
    self.flowLayout.minimumInteritemSpacing = Margin;
    
    //storyboard中的cell 无需 register, 直接 dequeue 即可
//    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MovingCCell class]) bundle:nil] forCellWithReuseIdentifier:MovingCCellID];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPressed:)];
    [self.collectionView addGestureRecognizer:longPress];
    
}

- (void)onLongPressed:(UILongPressGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:sender.view];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    
    // 只允许第一区可移动
    if (indexPath.section != 0) {
        return;
    }
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
                MovingCCell *cell = (MovingCCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
                cell.contentView.backgroundColor = [UIColor redColor];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self.collectionView updateInteractiveMovementTargetPosition:point];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self.collectionView endInteractiveMovement];
            MovingCCell *cell = (MovingCCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            cell.contentView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
            break;
        }
        default: {
            [self.collectionView cancelInteractiveMovement];
            break;
        }
    }
}


#pragma mark - UICollectionViewDelegate ,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.firstList.count;
    } else if (section == 1) {
        return self.secondList.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovingCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MovingCCellID forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.titleText = self.firstList[indexPath.item];
    }
    if (indexPath.section == 1) {
        cell.titleText = self.secondList[indexPath.item];
    }
    return cell;
}



//移动 API
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return YES;
    }
    
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.section == 0 && destinationIndexPath.section == 0) {
        [self.firstList exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //添加删除移动效果
    if (indexPath.section == 0) {
        
        NSString *model = [self.firstList objectAtIndex:indexPath.item];
        [self.secondList addObject:model];
        [self.firstList removeObject:model];
        
        NSInteger index = self.secondList.count - 1;
        if (self.secondList.count == 0) {
            index = 0;
        }
        
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:index inSection:1]];
        
    } else {

        
        NSString *model = [self.secondList objectAtIndex:indexPath.item];
        [self.firstList addObject:model];
        [self.secondList removeObject:model];
        
        NSInteger index = self.firstList.count - 1;
        if (self.firstList.count == 0) {
            index = 0;
        }
        
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        
    }
    
    [collectionView reloadData];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    ReusableSectionView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ReusableSectionViewID forIndexPath:indexPath];
    view.titleLB.text = [NSString stringWithFormat:@"section - %ld",indexPath.section];
    return view;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
