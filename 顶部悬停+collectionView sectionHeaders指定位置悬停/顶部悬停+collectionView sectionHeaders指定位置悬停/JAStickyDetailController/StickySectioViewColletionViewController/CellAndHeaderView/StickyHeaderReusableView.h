//
//  StickyHeaderReusableView.h
//  顶部悬停+collectionView sectionHeaders指定位置悬停
//
//  Created by Jacob_Liang on 16/10/16.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const StickyHeaderReusableViewID = @"StickyHeaderReusableView";

@interface StickyHeaderReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *descLB;
@end
