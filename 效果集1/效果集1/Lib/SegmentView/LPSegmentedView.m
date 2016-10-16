//
//  LPSegmentedView.m
//  test
//
//  Created by Allen on 16/4/7.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "LPSegmentedView.h"

#import "UIView+Frame.h"

@interface LPSegmentedButton : UIButton

@property (nonatomic, strong) NSString *topTitle;
@property (nonatomic, weak) UILabel *topLabel;

@end

@implementation LPSegmentedButton

- (void)setTopTitle:(NSString *)topTitle {
    _topTitle = topTitle;
    
    self.topLabel.text = topTitle;
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    if (self.topTitle.length) {
        
        [self.topLabel sizeToFit];
        self.topLabel.hlm_centerX = self.hlm_width * 0.5;
        self.topLabel.hlm_y = 0;
        
        [self.titleLabel sizeToFit];
        self.titleLabel.hlm_centerX = self.hlm_width * 0.5;
        self.titleLabel.hlm_y = self.topLabel.hlm_bottom + 3;
        
    }
    
}

- (UILabel *)topLabel {
    if (!_topLabel) {
        
        UILabel *topLabel = [[UILabel alloc] init];
        topLabel.textColor = [self titleColorForState:UIControlStateNormal];
        topLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:topLabel];
        _topLabel = topLabel;
    }
    return _topLabel;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        
        self.topLabel.textColor = [self titleColorForState:UIControlStateSelected];
        
    } else {
        
        self.topLabel.textColor = [self titleColorForState:UIControlStateNormal];
    }
    
    
}

@end





@interface LPSegmentedView ()

@property (nonatomic, weak) UIView *indicatorView;
@property (nonatomic, strong) NSMutableArray <LPSegmentedButton *> *itemsButton;
@property (nonatomic, weak) LPSegmentedButton *selectedButton;

@property (nonatomic, assign, getter=isFirstLoad) BOOL firstLoad;

@property (nonatomic, assign, getter=isFirstAppear) BOOL firstAppear;

@end

@implementation LPSegmentedView
{
    NSInteger _selectedIndex;
}

#pragma mark - Init

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self = [super initWithCoder:aDecoder]) {
        [self setUpInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit{
    
    self.backgroundColor = [UIColor whiteColor];
    self.bounces = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showIndicator = YES;
    self.fontSize = 14;
    self.indicatorheight = 4;
    self.indicatorColor = RGBA(255, 115, 133, 1);
    self.indicatorCornerRadius = 2;
    
    self.showSeparate = NO;
    self.separateColor = RGBA(242, 242, 242, 1);
    
    self.firstButtonMairgin = 0;
    
    self.firstLoad = YES;
    self.separatorInset = UIEdgeInsetsMake(9, 0, 9, 0);
}

- (void)layoutSubviews {
    [super layoutSubviews];

    
    self.indicatorView.hidden = !self.isShowIndicator;
    self.indicatorView.backgroundColor = self.indicatorColor;
    self.indicatorView.layer.cornerRadius = self.indicatorCornerRadius;
    self.indicatorView.hlm_height = self.indicatorheight;
    self.indicatorView.hlm_y = self.hlm_height - self.indicatorView.hlm_height;
    
    
    if (!self.isAverageButton) {
        
        CGFloat right = 0;
        CGFloat allButtonWidth = 0;
        
        for (UIButton *button in self.itemsButton) {
            allButtonWidth += button.hlm_width;
        }
        
        CGFloat buttonMargin = 0;
        if (self.isShowHalfItemStyle) {
            //半个item样式
            if (!self.halfItemIndex) {
                self.halfItemIndex = self.itemsButton.count - 1;
            }
            
            LPSegmentedButton *specialBtn = self.itemsButton[self.halfItemIndex];
            CGFloat specialIndexBtnW = specialBtn.hlm_width;
            CGFloat beforeIndexBtnTotalWidth = 0;
            for (int i = 0; i < self.halfItemIndex; i++) {
                UIButton *button = self.itemsButton[i];
                beforeIndexBtnTotalWidth += button.hlm_width;
            }
            
            buttonMargin = ( [UIScreen mainScreen].bounds.size.width - self.firstButtonMairgin - beforeIndexBtnTotalWidth - specialIndexBtnW/2.0 ) / self.halfItemIndex;
            
        } else {
            //普通样式
            if (!self.isNoRightMargin) {
                buttonMargin = self.buttonMargin ? self.buttonMargin : (self.hlm_width - 2 * self.firstButtonMairgin - allButtonWidth) / (self.itemsButton.count - 1);
            } else {
                buttonMargin = self.buttonMargin ? self.buttonMargin : (self.hlm_width - self.firstButtonMairgin - allButtonWidth) / (self.itemsButton.count - 1);
            }
        }
        
        
        for (int i = 0; i < self.itemsButton.count; i ++) {
            
            LPSegmentedButton *button = self.itemsButton[i];
            button.hlm_centerY = self.hlm_height * 0.5;
            button.hlm_x = self.firstButtonMairgin + right;
            button.hlm_height = self.hlm_height - self.indicatorView.hlm_height - 5;
            
            right = button.hlm_right + buttonMargin - self.firstButtonMairgin;
            
            if (i == 0 && self.isFirstLoad) {
                self.firstLoad = NO;
                self.selectedIndex = 0;
            }
            
            button.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        }
        
        
    } else {
        
        CGFloat buttonWidth = self.hlm_width / self.itemsButton.count;
        
        for (int i = 0; i < self.itemsButton.count; i ++) {
            
            LPSegmentedButton *button = self.itemsButton[i];
            button.hlm_height = self.hlm_height - self.indicatorView.hlm_height;
            button.hlm_width = buttonWidth;
            button.hlm_x = buttonWidth * i;
            
            if (i == 0 && self.isFirstLoad) {
                self.firstLoad = NO;
                self.selectedIndex = 0;
            }
            
            button.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        }
        
    }
    
    
    if (self.isShowSeparate) {
        
        [self layoutSeparateView];
        
    }
    
    if (self.isShowHalfItemStyle) {
        if (self.isNoRightMargin) {
            self.contentSize = CGSizeMake(self.itemsButton.lastObject.hlm_right, 0);
        } else {
            self.contentSize = CGSizeMake(self.itemsButton.lastObject.hlm_right + self.firstButtonMairgin, 0);
        }
    } else {
        self.contentSize = CGSizeMake(self.itemsButton.lastObject.hlm_right, 0);
    }

}

- (void)layoutSeparateView {
    
    NSInteger count = self.itemsButton.count - 1;
    
    for (int i = 0; i < count; i ++) {
        
        UIView *separateView = [[UIView alloc] init];
        separateView.backgroundColor = self.separateColor;
        [self addSubview:separateView];
        
        UIButton *oneButton = self.itemsButton[i];
        UIButton *twoButton = self.itemsButton[i + 1];
        
        separateView.hlm_width = 1;
        separateView.hlm_x = oneButton.hlm_right + (twoButton.hlm_x - oneButton.hlm_right ) * 0.5;
        separateView.hlm_height = self.hlm_height - self.separatorInset.top - self.separatorInset.bottom;
        separateView.hlm_y = self.separatorInset.top;
        
    }
    
}

#pragma mark - Event & Action

- (void)buttonClick:(LPSegmentedButton *)sender {
    
    if (sender.isSelected) return;
    self.firstAppear = self.selectedButton == nil;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.indicatorView.hlm_width = sender.hlm_width;
        self.indicatorView.hlm_centerX = sender.hlm_centerX;
        
    } completion:^(BOOL finished) {
        
    }];
    
    _sinceSelectedIndex = [self.itemsButton indexOfObject:self.selectedButton];
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
    
    if (!self.firstAppear) {
        
        if (self.isShowHalfItemStyle) {
            NSInteger hitIndex = [self.itemsButton indexOfObject:sender];
            LPSegmentedButton *lastTwoBtn = nil;
            if (hitIndex+2 <= self.itemsButton.count-1) { //防止越界
                lastTwoBtn = self.itemsButton[hitIndex +2]; //点击按钮的后面第2个按钮
                CGFloat offsetX = lastTwoBtn.hlm_right - [UIScreen mainScreen].bounds.size.width;
                if (offsetX > 0) {
                    [self setContentOffset:CGPointMake(offsetX,0) animated:YES];
                } else {
                    [self setContentOffset:CGPointMake(0,0) animated:YES];
                }
            } else {
                //向右滚到底
                [self setContentOffset:CGPointMake(self.contentSize.width - [UIScreen mainScreen].bounds.size.width,0) animated:YES];
            }
            
        }
    }
    
    if ([self.segmentedDelegate respondsToSelector:@selector(segmentedView:didChangeIndex:)]) {
        [self.segmentedDelegate segmentedView:self didChangeIndex:[self.itemsButton indexOfObject:sender]];
    }

}

- (void)setTopTitle:(NSString *)topTitle byIndex:(NSInteger)index {
    
    if (index < 0 || index > self.items.count) return;
    
    LPSegmentedButton *button = self.itemsButton[index];
    
    button.topTitle = topTitle;
    
}


#pragma mark - Getter & Setter

- (void)setItems:(NSArray<NSString *> *)items {
    _items = items;
    
    [self.itemsButton removeAllObjects];
    
    for (int i = 0; i < items.count; i ++) {
        
        NSString *item = items[i];
        
        LPSegmentedButton *button = [LPSegmentedButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:RGBA(128, 128, 128, 1) forState:UIControlStateNormal];
        [button setTitleColor:RGBA(255, 115, 133, 1) forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [button setTitle:item forState:UIControlStateNormal];
        
        [button sizeToFit];
  
        [self.itemsButton addObject:button];
    }
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    if (selectedIndex > self.itemsButton.count || selectedIndex < 0) return;
    
    [self buttonClick:self.itemsButton[selectedIndex]];
}

- (NSInteger)selectedIndex {
    
    NSInteger index = [self.itemsButton indexOfObject:self.selectedButton];
    return index;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.hidden = YES;
        _indicatorView = view;
        [self addSubview:view];
    }
    return _indicatorView;
}

- (NSMutableArray<LPSegmentedButton *> *)itemsButton {
    if (!_itemsButton) {
        _itemsButton = [NSMutableArray array];
    }
    return _itemsButton;
}

- (void)setScrollToIndex:(NSInteger)scrollToIndex {
    _scrollToIndex = scrollToIndex;
    
    LPSegmentedButton *sender = self.itemsButton[scrollToIndex];
    if (sender.isSelected) return;
    self.firstAppear = self.selectedButton == nil;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.indicatorView.hlm_width = sender.hlm_width;
        self.indicatorView.hlm_centerX = sender.hlm_centerX;
        
    } completion:^(BOOL finished) {
        
    }];
    
    _sinceSelectedIndex = [self.itemsButton indexOfObject:self.selectedButton];
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
    
    if (!self.firstAppear) {
        
        if (self.isShowHalfItemStyle) {
            NSInteger hitIndex = [self.itemsButton indexOfObject:sender];
            LPSegmentedButton *lastTwoBtn = nil;
            if (hitIndex+2 <= self.itemsButton.count-1) { //防止越界
                lastTwoBtn = self.itemsButton[hitIndex +2]; //点击按钮的后面第2个按钮
                CGFloat offsetX = lastTwoBtn.hlm_right - [UIScreen mainScreen].bounds.size.width;
                if (offsetX > 0) {
                    [self setContentOffset:CGPointMake(offsetX,0) animated:YES];
                } else {
                    [self setContentOffset:CGPointMake(0,0) animated:YES];
                }
            } else {
                //向右滚到底
                [self setContentOffset:CGPointMake(self.contentSize.width - [UIScreen mainScreen].bounds.size.width,0) animated:YES];
            }
            
        }
    }
}

@end









