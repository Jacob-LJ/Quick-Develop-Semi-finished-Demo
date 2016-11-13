//
//  WCPediaCategoryWordsCell.h
//  hunlimao
//
//  Created by Jacob on 16/11/10.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import <UIKit/UIKit.h>
static CGFloat const ItemCCellHeight = 40;

static NSString * const WCPediaCategoryWordsCellID = @"WCPediaCategoryWordsCell";

@interface WCPediaCategoryWordsCell : UITableViewCell
@property (nonatomic, assign) BOOL openAll; /**< 展开所有类目 */
- (CGFloat)cellHeight;
@end
