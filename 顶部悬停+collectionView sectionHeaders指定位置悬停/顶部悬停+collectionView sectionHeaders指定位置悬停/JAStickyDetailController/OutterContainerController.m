//
//  OutterContainerController.m
//  顶部悬停+collectionView sectionHeaders指定位置悬停
//
//  Created by Jacob_Liang on 16/10/16.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "OutterContainerController.h"
//
#import "StickyHeaderFlowLayout.h"
#import "StickySectioViewColletionController.h"
//headerPart
#import "SelectScrollView.h"
#import "DetailHeaderView.h"
//category
#import "UIView+Frame.h"

@interface OutterContainerController ()

@end

@implementation OutterContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.alpha = 0;
    
    [self setUpInit];
    
    [self setUpHeaderView];
}


- (void)setUpInit {
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UICollectionViewFlowLayout *flowLayout = [[StickyHeaderFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    StickySectioViewColletionController *VC1 = [[StickySectioViewColletionController alloc] initWithCollectionViewLayout:flowLayout];
        [self addChildViewController:VC1];
    VC1.view.frame = CGRectMake(0, SelectScrollViewHeight + 64, HLMScreenW, HLMScreenH - (SelectScrollViewHeight + 64));
    [self.view addSubview:VC1.view];
    
    
}

- (void)setUpHeaderView {
    
    UIView *containerHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HLMScreenW, TableHeaderViewHeight + SelectScrollViewHeight)];
    
    [self.view addSubview:containerHeaderView];
    self.containerHeaderView = containerHeaderView;
    
    DetailHeaderView *imageHeaderV = [DetailHeaderView viewFromXib];
    imageHeaderV.frame = CGRectMake(0, 0, HLMScreenW, TableHeaderViewHeight);
    
    
    SelectScrollView *selectView = [SelectScrollView viewFromXib];
    selectView.frame = CGRectMake(0, TableHeaderViewHeight, HLMScreenW, SelectScrollViewHeight);
    
    [containerHeaderView addSubview:imageHeaderV];
    [containerHeaderView addSubview:selectView];
    
}


@end
