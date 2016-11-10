//
//  ViewController.m
//  keepOffsetPositionBySwitchBetweenDifferentDataSourceCollectionView
//
//  Created by Jacob_Liang on 16/11/10.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "SimpleMarkCCell.h"

#define TableHeaderViewHeight 200
#define Column 4 //目前根据实际运行效果得到列数,并不通过计算获取该值

static NSString * const cellID = @"cellID";

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray1;
@property (nonatomic, strong) NSMutableArray *dataArray2;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray1 = [NSMutableArray array];
    for (int i = 0; i < 20; ++i) {
        [self.dataArray1 addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    self.dataArray2 = [NSMutableArray array];
    for (int i = 0; i < 40; ++i) {
        [self.dataArray2 addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.dataArray = self.dataArray2;
}


- (IBAction)didClickSegmentControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.dataArray = self.dataArray1;
    } else {
        self.dataArray = self.dataArray2;
    }
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SimpleMarkCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    cell.markLB.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    
    
    /********* 碉堡的不同数据源切换CollectionView维持对应的位置效果 star ***********/
    CGPoint offset = self.collectionView.contentOffset;
    NSLog(@"^^^&&&& %@",NSStringFromCGPoint(offset));
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded]; // Force layout so things are updated before resetting the contentOffset.
    [self.collectionView setContentOffset:offset];
    if (offset.y > 0) {
        if (self.collectionView.contentSize.height < self.collectionView.frame.size.height) {
            self.collectionView.contentInset = UIEdgeInsetsMake(TableHeaderViewHeight - 64, 0, self.collectionView.frame.size.height-self.collectionView.contentSize.height, 0);
        } else {
            self.collectionView.contentInset = UIEdgeInsetsMake(TableHeaderViewHeight - 64, 0, 0, 0);
        }
        [self.collectionView setContentOffset:CGPointZero];
    } else if (offset.y > -(TableHeaderViewHeight - 64)) {
        if (self.collectionView.contentSize.height < self.collectionView.frame.size.height) {
            self.collectionView.contentInset = UIEdgeInsetsMake(TableHeaderViewHeight - 64, 0, self.collectionView.frame.size.height-self.collectionView.contentSize.height, 0);
        } else {
            self.collectionView.contentInset = UIEdgeInsetsMake(TableHeaderViewHeight - 64, 0, 0, 0);
        }
    } else {
        self.collectionView.contentInset = UIEdgeInsetsMake(TableHeaderViewHeight - 64, 0, 0, 0);
    }
    
//    //如果超出2行即在底部再添加95的contentInset
//    if ((self.dataArray.count + Column - 1)/Column >= 2 || (self.dataArray.count + Column - 1)/Column >= 2) {
//        self.collectionView.contentInset = UIEdgeInsetsMake(TableHeaderViewHeight - 64, 0, self.collectionView.contentInset.bottom + 95, 0);
//    }
    /********* 碉堡的不同数据源切换CollectionView维持对应的位置效果 end ***********/
    
    
    
    
}


@end
