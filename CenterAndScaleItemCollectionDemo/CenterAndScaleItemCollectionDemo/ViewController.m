//
//  ViewController.m
//  CenterAndScaleItemCollectionDemo
//
//  Created by Jacob_Liang on 16/11/3.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "centerAndScaleFlowLayout.h"
#import "ImageCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *images;
@end

static NSString *const identifer = @"ImageCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     CGRect rect = CGRectMake(0, 250, self.view.frame.size.width,100);
     UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[[centerAndScaleFlowLayout alloc] init]];
     collectionView.dataSource = self;
     collectionView.delegate = self;

     // 注册collectionView(因为是从xib中加载cell的,所以registerNib)
     [collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:identifer];

     [self.view addSubview:collectionView];

     self.collectionView = collectionView;
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

@end
