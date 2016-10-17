//
//  SelectedRefinementPhotoController.m
//  hunlimao
//
//  Created by Jacob on 16/10/15.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "SelectedRefinementPhotoController.h"
//view
#import "SelectedRefinementCCell.h"

#define oKButtonTitleColorNormal [UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:1.0]
#define oKButtonTitleColorDisabled [UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:0.5]
#define columnCount (3.0)

static NSString *const SelectedRefinementCCellID = @"SelectedRefinementCCell";

@interface SelectedRefinementPhotoController ()

@property (strong, nonatomic) UIButton *okButton;
@property (strong, nonatomic) UIImageView *numberImageView;
@property (strong, nonatomic) UILabel *numberLable;

@property (nonatomic, strong) NSMutableArray *selectedModels;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation SelectedRefinementPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpInit];
    [self setUpCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpNav];
}

- (void)setUpInit {
    self.title = @"已选精修照片";
    self.selectedModels = [NSMutableArray arrayWithObjects:@"1", nil];
}

- (void)setUpNav {
    
}

- (void)okButtonClick {
    
}

- (void)setUpCollectionView {
    
    CGFloat margin = 5;
    CGFloat itemHW = (([UIScreen mainScreen].bounds.size.width - 2*margin) - (columnCount - 1)*margin) / columnCount;
    self.flowLayout.minimumLineSpacing = margin;
    self.flowLayout.minimumInteritemSpacing = margin;
    self.flowLayout.itemSize = CGSizeMake(itemHW, itemHW);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectedRefinementCCell class]) bundle:nil] forCellWithReuseIdentifier:SelectedRefinementCCellID];
}



#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SelectedRefinementCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SelectedRefinementCCellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
