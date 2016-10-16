//
//  LPSegmentedView.h
//  test
//
//  Created by Allen on 16/4/7.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LPSegmentedView;

@protocol LPSegmentedViewDelegate <NSObject>

@optional
- (void)segmentedView:(LPSegmentedView *)segmentedView didChangeIndex:(NSInteger)index;

@end


@interface LPSegmentedView : UIScrollView

@property (nonatomic, strong) NSArray <NSString *> *items; //字符串数组
@property (nonatomic, assign) NSInteger selectedIndex; //选中的按钮，setter为点击，getter为获取
@property (nonatomic, assign, readonly) NSInteger sinceSelectedIndex; //上一次的选中按钮，获取
@property (nonatomic, assign) CGFloat fontSize; //文字大小
@property (nonatomic, assign, getter=isAverageButton) BOOL averageButton; //根据本身宽高平均分配按钮宽高

@property (nonatomic, assign, getter=isShowIndicator) BOOL showIndicator;//底部是否显示border
@property (nonatomic, assign) CGFloat indicatorCornerRadius;//指示器圆角
@property (nonatomic, assign) CGFloat indicatorheight;//指示器高度
@property (nonatomic, strong) UIColor *indicatorColor;//指示器颜色

@property (nonatomic, assign, getter=isShowSeparate) BOOL showSeparate;//按钮之间是否需要分隔符
@property (nonatomic, strong) UIColor *separateColor;//分隔符颜色
@property (nonatomic, assign) UIEdgeInsets separatorInset;

@property (nonatomic, assign) CGFloat buttonMargin; //每个按钮的间距
@property (nonatomic, assign) CGFloat firstButtonMairgin; //第一个按钮和左边的间距,默认为0

@property (nonatomic, assign) id<LPSegmentedViewDelegate> segmentedDelegate;

- (void)setTopTitle:(NSString *)topTitle byIndex:(NSInteger)index;

//ja
@property (nonatomic, assign, getter=isNoRightMargin) BOOL noRightMargin; /**< 左右不对称间距 default is NO*/
@property (nonatomic, assign, getter=isShowHalfItemStyle) BOOL showHalfItemStyle; /**< default is NO 最后item是否展示半个的样式 ,需同时指定展示半个的Item索引,不指定默认为最后一个*/
@property (nonatomic, assign) NSUInteger halfItemIndex; /**< 展示半个的Item索引 */

@property (nonatomic, assign) NSInteger scrollToIndex; /**< 仅仅选中segment中的item,不响应代理方法 */


@end
