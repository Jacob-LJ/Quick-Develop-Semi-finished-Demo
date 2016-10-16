//
//  PSLDetailStyleSizeInfoView.m
//  hunlimao
//
//  Created by Jacob on 16/10/10.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "PSLDetailStyleSizeInfoView.h"
#import "StyleSizeCCell.h"
#import "StyleSizeCVFlowLayout.h"



static NSString * const StyleSizeCCellID = @"StyleSizeCCell";

@interface PSLDetailStyleSizeInfoView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *allContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *allContainerViewHeight;

@property (weak, nonatomic) IBOutlet UIView *actionContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *ImageV;

@property (nonatomic, assign, getter=isShow) BOOL show;
@property (weak, nonatomic) IBOutlet UICollectionView *styleSelectCollectionView;
@property (weak, nonatomic) IBOutlet StyleSizeCVFlowLayout *styleSelectFlowLayout;

@property (weak, nonatomic) IBOutlet UICollectionView *sizeSelectCollectionView;
@property (weak, nonatomic) IBOutlet StyleSizeCVFlowLayout *sizeSelectFlowLaout;


@end

@implementation PSLDetailStyleSizeInfoView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    
    UIView *tapRemoveActV = [[UIView alloc] initWithFrame:self.frame];
    tapRemoveActV.backgroundColor = [UIColor clearColor];
    [self insertSubview:tapRemoveActV atIndex:0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeMySelf:)];
    [tapRemoveActV addGestureRecognizer:tap];
    
    [self allContainerViewStartState];
    
    [self setUpColletionView];
    
    self.styleSelectDatas = [NSMutableArray arrayWithObjects:@"磨砂白",@"深空灰",@"土豪金",@"亮黑色",@"玫瑰红", nil];
    self.sizeSelectDatas = [NSMutableArray arrayWithObjects:@"16寸（406*305mm）",@"20寸（508*406mm）",@"24寸（61*508cm）",@"30寸（762*610mm）",@"36寸（914*610mm）",@"40寸（1016*762mm）", nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

//动画view的初始状态
- (void)allContainerViewStartState {
    self.allContainerView.layer.opacity = 0;
    self.allContainerView.layer.affineTransform = CGAffineTransformMakeScale(0.2, 0.2);
}



#pragma mark - 弹出动画view
- (void)showPopupAllContainerView {
    
    self.allContainerView.layer.opacity = 1;
    [UIView animateWithDuration:kAnimationTime animations:^{
        self.allContainerView.layer.affineTransform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:kAnimationTime animations:^{
            self.allContainerView.layer.affineTransform = CGAffineTransformIdentity;
        }];
    }];
}

#pragma mark - 隐藏动作
- (void)removeMySelf:(UITapGestureRecognizer *)tap {
    
//    CGPoint touchPoint = [tap locationInView:self];
//    if (!CGRectContainsPoint(self.allContainerView.frame, touchPoint)) {
    
        [self dismissAnimation];
//    }
    
}

- (IBAction)closeBtnClick:(UIButton *)sender {
    [self dismissAnimation];
}

- (void)dismissAnimation {
    [UIView animateWithDuration:kAnimationTime animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alpha = 1;
        [self allContainerViewStartState];
    }];
}

#pragma mark - 点击加入购物车按钮
- (IBAction)throwToShopCarBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(PSLDetailStyleSizeInfoView:didClickThrowToShopCarBtn:)]) {
        [self.delegate PSLDetailStyleSizeInfoView:self didClickThrowToShopCarBtn:sender];
    }
    [self dismissAnimation];
}


/*
//往一个角落缩小的动画代码
- (void)animateScaleActionContainerView:(UIView*)aView {
 
    CGRect newRect = [self convertRect:self.actionContainerView.frame fromView:self.allContainerView];
    
    [self setAnchorPoint:CGPointMake((newRect.origin.x + 20)/self.actionContainerView.frame.size.width , 0.0f) forView:aView];
    
    [UIView animateWithDuration:kAnimationTime animations:^{
        aView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        
    }];
    
    
}
//让view动画参考点为所设置的锚点 (注意:默认是视图中心点) ////暂时没用到
- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}
*/

- (void)setUpColletionView {
    self.styleSelectFlowLayout.minimumLineSpacing = 5;
    self.styleSelectFlowLayout.minimumInteritemSpacing = 5;
    self.styleSelectFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.sizeSelectFlowLaout.minimumLineSpacing = 5;
    self.sizeSelectFlowLaout.minimumInteritemSpacing = 5;
    self.sizeSelectFlowLaout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.styleSelectCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([StyleSizeCCell class]) bundle:nil] forCellWithReuseIdentifier:StyleSizeCCellID];
    self.styleSelectCollectionView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    [self.sizeSelectCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([StyleSizeCCell class]) bundle:nil] forCellWithReuseIdentifier:StyleSizeCCellID];
    self.sizeSelectCollectionView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDataDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.styleSelectCollectionView) {
        return self.styleSelectDatas.count;
    }
    if (collectionView == self.sizeSelectCollectionView) {
        return self.sizeSelectDatas.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.styleSelectCollectionView) {
        StyleSizeCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:StyleSizeCCellID forIndexPath:indexPath];
        cell.descLB.text = self.styleSelectDatas[indexPath.row];
        
        return cell;
    }
    if (collectionView == self.sizeSelectCollectionView) {
        StyleSizeCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:StyleSizeCCellID forIndexPath:indexPath];
        cell.descLB.text = self.sizeSelectDatas[indexPath.row];
        
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.styleSelectCollectionView) {
        NSLog(@"点击styleSelectCollectionView");
    }
    if (collectionView == self.sizeSelectCollectionView) {
        NSLog(@"点击sizeSelectCollectionView");
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeZero;
    NSDictionary *attriDict = @{
                                NSFontAttributeName : [UIFont systemFontOfSize:StyleSizeCCellFontSize]
                                };
    NSString *text = nil;
    if (collectionView == self.styleSelectCollectionView) {
        text = self.styleSelectDatas[indexPath.row];
        size = [text sizeWithAttributes:attriDict];
    }
    if (collectionView == self.sizeSelectCollectionView) {
        text = self.sizeSelectDatas[indexPath.row];
        size = [text sizeWithAttributes:attriDict];
    }
    size.width = size.width + 10;
    size.height = size.height + 10;
    return size;
}

@end
