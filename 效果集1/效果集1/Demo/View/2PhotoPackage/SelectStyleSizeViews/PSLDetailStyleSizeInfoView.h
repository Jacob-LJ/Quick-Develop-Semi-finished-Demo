//
//  PSLDetailStyleSizeInfoView.h
//  hunlimao
//
//  Created by Jacob on 16/10/10.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSTimeInterval kAnimationTime = 0.25;

@class PSLDetailStyleSizeInfoView;

@protocol PSLDetailStyleSizeInfoViewDelegate <NSObject>

- (void)PSLDetailStyleSizeInfoView:(PSLDetailStyleSizeInfoView *)detailStyleSizeInfoView didClickThrowToShopCarBtn:(UIButton *)throwBtn;


@end

@interface PSLDetailStyleSizeInfoView : UIView

@property (nonatomic, strong) NSMutableArray *styleSelectDatas; /**< 款式数据 */
@property (nonatomic, strong) NSMutableArray *sizeSelectDatas; /**< 尺寸数据 */

@property (nonatomic, weak) id<PSLDetailStyleSizeInfoViewDelegate> delegate;

//弹出动画view
- (void)showPopupAllContainerView;
@end
