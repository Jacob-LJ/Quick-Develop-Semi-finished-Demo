//
//  PSLShopCarDetailView.h
//  hunlimao
//
//  Created by Jacob on 16/10/8.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat CELLH = 100.0;

@interface PSLShopCarDetailView : UIView

@property (weak, nonatomic) IBOutlet UITableView *selfSelectTableView;
@property (weak, nonatomic) IBOutlet UITableView *packageTableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;

@property (nonatomic,strong) NSMutableArray *selfSelectDatas;
@property (nonatomic,strong) NSMutableArray *packageDatas;

+ (instancetype)shopCarDetailViewWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects;

+ (instancetype)shopCarDetailViewWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects canReorder:(BOOL)reOrder;

@end
