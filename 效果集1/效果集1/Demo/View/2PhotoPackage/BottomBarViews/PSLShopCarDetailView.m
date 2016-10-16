//
//  PSLShopCarDetailView.m
//  hunlimao
//
//  Created by Jacob on 16/10/8.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "PSLShopCarDetailView.h"
#import "PSLShopCarDetailCell.h"
#import "PSLShopCarPackageCell.h"

static NSString * const PSLShopCarDetailCellID = @"PSLShopCarDetailCell";
static NSString * const PSLShopCarPackageCellID = @"PSLShopCarPackageCell";

@interface PSLShopCarDetailView ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, PSLShopCarDetailCellDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listContainerVWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (nonatomic, assign, getter=isEditAble) BOOL editAble; /**< cell内可做加减操作 */

@end

@implementation PSLShopCarDetailView

+ (instancetype)shopCarDetailViewWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects {
    
    return [self shopCarDetailViewWithFrame:frame withObjects:objects canReorder:NO];
}

+ (instancetype)shopCarDetailViewWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects canReorder:(BOOL)reOrder {
    
    PSLShopCarDetailView *shopCarDetailV = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PSLShopCarDetailView class]) owner:nil options:nil].firstObject;
    shopCarDetailV.frame = frame;
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"];
    shopCarDetailV.selfSelectDatas = [NSMutableArray arrayWithArray:array];
    shopCarDetailV.packageDatas = [NSMutableArray arrayWithArray:array];
    [shopCarDetailV layoutUI];
    return shopCarDetailV;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.listContainerVWidth.constant = [UIScreen mainScreen].bounds.size.width * 2;
    
}


- (void)layoutUI {
    
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    
    self.selfSelectTableView.bounces = NO;
    self.selfSelectTableView.showsHorizontalScrollIndicator = NO;
    self.selfSelectTableView.showsVerticalScrollIndicator = NO;
    self.selfSelectTableView.backgroundColor = [UIColor clearColor];
    
    self.packageTableView.bounces = NO;
    self.packageTableView.showsHorizontalScrollIndicator = NO;
    self.packageTableView.showsVerticalScrollIndicator = NO;
    self.packageTableView.backgroundColor = [UIColor clearColor];
    
    [self.selfSelectTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PSLShopCarDetailCell class]) bundle:nil] forCellReuseIdentifier:PSLShopCarDetailCellID];
    [self.packageTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PSLShopCarPackageCell class]) bundle:nil] forCellReuseIdentifier:PSLShopCarPackageCellID];
    
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.selfSelectTableView) {
        return self.selfSelectDatas.count;
    }
    if (tableView == self.packageTableView) {
        return self.packageDatas.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELLH;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == self.selfSelectTableView) {
        PSLShopCarDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:PSLShopCarDetailCellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.operationView.hidden = !self.editAble;
        
        return cell;
    }
    if (tableView == self.packageTableView) {
        PSLShopCarPackageCell *cell = [tableView dequeueReusableCellWithIdentifier:PSLShopCarPackageCellID forIndexPath:indexPath];
        
        return cell;
    }
//    OrderModel *model = [[OrderModel alloc]initWithDictionary:[self.objects objectAtIndex:indexPath.row]];
//    
//    [cell ListModel:model];
//    cell.operationBlock=^(NSInteger number,BOOL plus){
//        
//        NSMutableDictionary * dic = self.objects[indexPath.row];
//        //更新选中订单列表中的数量
//        [dic setValue:[NSNumber numberWithInteger:number] forKey:@"orderCount"];
//        
//        NSMutableDictionary *notification = [[NSMutableDictionary alloc]init];
//        [notification setValue:[NSNumber numberWithBool:plus] forKey:@"isAdd"];
//        [notification setValue:dic forKey:@"update"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUI" object:self userInfo:notification];
//    };
    return nil;

}

#pragma mark -

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        if (scrollView.contentOffset.x == 0) {
            [self.segControl setSelectedSegmentIndex:0];
            self.editBtn.hidden = NO;
        } else {
            [self.segControl setSelectedSegmentIndex:1];
            self.editBtn.hidden = YES;
        }
    }
}

#pragma mark - Action

- (IBAction)singleOrPackageSegmentSelected:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.editBtn.hidden = NO;
    } else if (sender.selectedSegmentIndex == 1) {
        [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0) animated:YES];
        self.editBtn.hidden = YES;
    }
    
}

- (IBAction)editBtnClick:(UIButton *)sender {
    self.editAble = !self.editAble;
    if (self.editAble) {
        [sender setTitle:@"完成" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
    }
    [self.selfSelectTableView reloadData];
    [self.packageTableView reloadData];
}

#pragma mark - PSLShopCarDetailCellDelegate
- (void)PSLShopCarDetailCell:(PSLShopCarDetailCell *)shopCarDetailCell didClickDeleteButton:(UIButton *)deleBtn {
    
    [self.selfSelectTableView beginUpdates];
    NSIndexPath *indexP = [self.selfSelectTableView indexPathForCell:shopCarDetailCell];
    [self.selfSelectDatas removeObjectAtIndex:indexP.row];
    [self.selfSelectTableView deleteRowsAtIndexPaths:@[indexP] withRowAnimation:UITableViewRowAnimationLeft];
    [self.selfSelectTableView endUpdates];
}

@end
