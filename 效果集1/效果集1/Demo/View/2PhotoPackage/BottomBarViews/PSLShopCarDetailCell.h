//
//  PSLShopCarDetailCell.h
//  hunlimao
//
//  Created by Jacob on 16/10/8.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSLShopCarDetailCell;


@protocol PSLShopCarDetailCellDelegate <NSObject>

- (void)PSLShopCarDetailCell:(PSLShopCarDetailCell *)shopCarDetailCell didClickDeleteButton:(UIButton *)deleBtn;

@end

@interface PSLShopCarDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *operationView;

@property (nonatomic, weak) id<PSLShopCarDetailCellDelegate> delegate;

@end
