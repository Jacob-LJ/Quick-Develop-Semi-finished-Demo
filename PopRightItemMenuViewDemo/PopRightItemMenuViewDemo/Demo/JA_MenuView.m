//
//  JA_MenuView.m
//  PopRightItemMenuViewDemo
//
//  Created by Jacob_Liang on 16/11/27.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "JA_MenuView.h"
#import "JA_MenuModel.h"
#import "JA_MenuViewCell.h"

#define KRowHeight 40   // cell行高
#define KDefaultMaxValue 6  // 菜单项最大值
#define KNavigationBar_H 64 // 导航栏64
#define KIPhoneSE_ScreenW 375
#define KMargin 15

@interface JA_MenuView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UIView * backView;
@property (nonatomic,assign) CGRect rect;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) UIViewController * target;

@end

@implementation JA_MenuView

#pragma mark - Create Menu
+ (JA_MenuView *)createMenuWithFrame:(CGRect)frame target:(UIViewController *)targetController dataArray:(NSArray *)dataArray itemsClickBlock:(void (^)(NSString *, NSInteger))itemsClickBlock backViewTap:(void (^)())backViewTapBlock{
    
    // 计算frame
    CGFloat factor = [UIScreen mainScreen].bounds.size.width < KIPhoneSE_ScreenW ? 0.36 : 0.3; // 适配比例
    CGFloat width = frame.size.width ? frame.size.width : [UIScreen mainScreen].bounds.size.width * factor;
    CGFloat height = dataArray.count > KDefaultMaxValue ? KDefaultMaxValue * KRowHeight : dataArray.count * KRowHeight;
    CGFloat x = frame.origin.x ? frame.origin.x : [UIScreen mainScreen].bounds.size.width - width - KMargin * 0.5;
    CGFloat y = frame.origin.y ? frame.origin.y : KNavigationBar_H;
    CGRect rect = CGRectMake(x, y, width, height);    // 菜单中tableView的frame
    frame = CGRectMake(x, y, width, height + KMargin); // 菜单的整体frame
    
    JA_MenuView *menuView = [[JA_MenuView alloc] init];
    menuView.frame = frame;
    //改变 anchorPoint 维持 Postion 的位置
    [menuView setAnchorPoint:CGPointMake(0.9, 0.0) forView:menuView];
    
    menuView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    menuView.target = targetController;
    menuView.dataArray = [NSMutableArray arrayWithArray:dataArray];
    menuView.itemsClickBlock = itemsClickBlock;
    menuView.backViewTapBlock = backViewTapBlock;
    menuView.maxValueForItemCount = dataArray.count;
    [menuView setUpUIWithFrame:rect];
    [targetController.view addSubview:menuView];
    return menuView;
}

- (void)setAnchorPoint:(CGPoint)anchorpoint forView:(UIView *)view {
    CGRect oldFrame = view.frame;
    view.layer.anchorPoint = anchorpoint;
    view.frame = oldFrame;
}

#pragma mark - layoutSubviews
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.bounds = self.bounds;
}

#pragma mark - initMenu
- (void)setUpUIWithFrame:(CGRect)frame{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.image = [UIImage imageNamed:@"pop_black_backGround"];
    //确保imageView的 anchorPoint 与 menuView 一致;
    [self setAnchorPoint:CGPointMake(0.9, 0) forView:imageView];
    self.imageView = imageView;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KMargin, frame.size.width, frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = NO;
    self.tableView.rowHeight = KRowHeight;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[JA_MenuViewCell class] forCellReuseIdentifier:@"JA_MenuViewCellID"];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, KNavigationBar_H, self.target.view.bounds.size.width, self.target.view.bounds.size.height)];
    backView.backgroundColor = [UIColor blackColor];
    backView.userInteractionEnabled = YES;
    backView.alpha = 0.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [backView addGestureRecognizer:tap];
    self.backView = backView;
    
    [self.target.view addSubview:backView];
    [self addSubview:imageView];
    [self addSubview:self.tableView];
}

#pragma mark - UITapGestureRecognizer
- (void)tap:(UITapGestureRecognizer *)sender{
    [self showMenuWithAnimation:NO];
    if (self.backViewTapBlock) {
        self.backViewTapBlock();
    }
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JA_MenuModel *model = self.dataArray[indexPath.row];
    JA_MenuViewCell *cell = (JA_MenuViewCell *)[tableView dequeueReusableCellWithIdentifier:@"JA_MenuViewCellID" forIndexPath:indexPath];
    cell.menuModel = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JA_MenuModel *model = self.dataArray[indexPath.row];
    NSInteger tag = indexPath.row + 1;
    if (self.itemsClickBlock) {
        self.itemsClickBlock(model.itemName,tag);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KRowHeight;
}

#pragma mark - Show With Animation
- (void)showMenuWithAnimation:(BOOL)isShow{
    
    UIView *backView = self.backView;
    self.tableView.contentOffset = CGPointZero;
    [UIView animateWithDuration:0.25 animations:^{
        if (isShow) {
            self.alpha = 1;
            backView.alpha = 0.1;
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }else{
            self.alpha = 0;
            backView.alpha = 0;
            self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        }
    }];
}


#pragma mark - Append Menu Items
- (void)appendMenuItemsWith:(NSArray *)appendItemsArray{
    
    NSMutableArray *tempMutableArr = [NSMutableArray arrayWithArray:self.dataArray];
    [tempMutableArr addObjectsFromArray:appendItemsArray];
    self.dataArray = tempMutableArr;
    
    [self.tableView reloadData];
    [self adjustFrameForMenu];
}


#pragma mark - Update Menu Items
- (void)updateMenuItemsWith:(NSArray *)newItemsArray{
    
    [self.dataArray removeAllObjects];
    self.dataArray = [NSMutableArray arrayWithArray:newItemsArray];
    
    [self.tableView reloadData];
    [self adjustFrameForMenu];
}

#pragma mark - Adjust Menu Frame
- (void)adjustFrameForMenu{
    
    self.maxValueForItemCount = self.dataArray.count;
    
    CGRect rect = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, KRowHeight * self.maxValueForItemCount);
    CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,  (self.maxValueForItemCount * KRowHeight + KMargin) * 0.01);
    
    self.tableView.frame = rect;   // 根据菜单项，调整菜单内tableView的大小
    self.frame = frame;     // 根据菜单项，调整菜单的整体frame
}

#pragma mark - Hidden & Clear
- (void)hidden{
    [self showMenuWithAnimation:NO];
}

- (void)clearMenu{
    [self showMenuWithAnimation:NO];
    [self removeFromSuperview];
    [self.backView removeFromSuperview];
}

#pragma mark - getter & setter
- (void)setDataArray:(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[JA_MenuModel class]]) {
            JA_MenuModel *model = [JA_MenuModel MenuModelWithDict:(NSDictionary *)obj];
            [_dataArray addObject:model];
        }
    }];
}

- (void)setMaxValueForItemCount:(NSInteger)maxValueForItemCount{
    if (maxValueForItemCount <= KDefaultMaxValue) {
        _maxValueForItemCount = maxValueForItemCount;
    }else{
        _maxValueForItemCount = KDefaultMaxValue;
    }
}

@end
