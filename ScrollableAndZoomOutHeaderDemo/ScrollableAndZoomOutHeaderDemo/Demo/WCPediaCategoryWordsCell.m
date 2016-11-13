//
//  WCPediaCategoryWordsCell.m
//  hunlimao
//
//  Created by Jacob on 16/11/10.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "WCPediaCategoryWordsCell.h"
#import "WCPediaCategoryWordCCell.h"

//屏幕宽高
#define HLMScreenW [UIScreen mainScreen].bounds.size.width
#define HLMScreenH [UIScreen mainScreen].bounds.size.height
#define HLMNavBarH (64)

static int const Column = 3;
static CGFloat const MarginLeft = 14;
static CGFloat const MarginTop = 16;
static CGFloat const MarginItem = 13;
static CGFloat const LineMargin = 10;
static NSInteger const defultShowItemCount = 6;

@interface WCPediaCategoryWordsCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

//test
@property (nonatomic, strong) NSArray *firstArray;


@end

@implementation WCPediaCategoryWordsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.firstArray = [NSArray arrayWithObjects:@"编码法规",@"编码习俗",@"编码政策",@"编码心理",@"编码摄影",@"编码酒店",@"编码服务",@"编码造型",@"编码来宾",@"编码旅行",@"编码法规",@"编码习俗",@"编码政策",@"编码心理",@"编码摄影", nil];
    [self setUpCollectionView];
}

- (void)setUpCollectionView {
    self.flowLayout.itemSize = CGSizeMake((HLMScreenW - 2 * MarginLeft - MarginItem * (Column - 1))/Column, ItemCCellHeight);
    self.flowLayout.minimumInteritemSpacing = MarginItem;
    self.flowLayout.minimumLineSpacing = LineMargin;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(MarginTop, MarginLeft, 0, MarginLeft);
    self.collectionView.scrollEnabled = NO;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WCPediaCategoryWordCCell class]) bundle:nil] forCellWithReuseIdentifier:WCPediaCategoryWordCCellID];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.firstArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WCPediaCategoryWordCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WCPediaCategoryWordCCellID forIndexPath:indexPath];
    cell.titleLB.text = self.firstArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
}

- (CGFloat)cellHeight {
    [self.collectionView layoutIfNeeded];
    CGFloat height = 0;
    if (self.openAll) {
        UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:self.firstArray.count-1 inSection:0]];
        height = CGRectGetMaxY(attributes.frame);
    } else {
        UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:defultShowItemCount-1 inSection:0]];
        height = CGRectGetMaxY(attributes.frame);
    }
    return height +self.collectionView.contentInset.top;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
