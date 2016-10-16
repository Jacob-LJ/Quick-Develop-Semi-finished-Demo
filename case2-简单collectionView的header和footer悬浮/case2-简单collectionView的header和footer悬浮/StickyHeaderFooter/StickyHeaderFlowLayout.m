//
//  StickyHeaderFlowLayout.m
//  hunlimao
//
//  Created by Jacob on 16/10/15.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "StickyHeaderFlowLayout.h"

@implementation StickyHeaderFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    /**
     *  返回当前显示区域的所有布局信息
     */
    NSMutableArray *answer = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    UICollectionView * const cv = self.collectionView;
    CGPoint const contentOffset = cv.contentOffset;
    
    NSMutableIndexSet *missingSections = [NSMutableIndexSet indexSet];
    
    /**
     *  找出所有UICollectionElementCategoryCell类型的cell
     */
    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
        if (layoutAttributes.representedElementCategory == UICollectionElementCategoryCell) {
            [missingSections addIndex:layoutAttributes.indexPath.section];
        }
    }
    /**
     *  再从里面删除所有UICollectionElementKindSectionHeader类型的cell
     */
    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [missingSections removeIndex:layoutAttributes.indexPath.section];
        }
    }
    
    /**
     *  默认情况下，为missingSections手动插入attributes，应该是为rect外的section生成attributes
     */
    [missingSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        
        UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        
        [answer addObject:layoutAttributes];
        
    }];
    
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
        
        /**
         *  从answer中储存的布局信息中，针对UICollectionElementKindSectionHeader...
         */
        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            NSInteger section = layoutAttributes.indexPath.section;
            NSInteger numberOfItemsInSection = [cv numberOfItemsInSection:section];
            
            /**
             *  为什么需要firstCellIndexPath和lastCellIndexPath呢？
             *  header应当保持着距离本section第一个cell的最大距离，简单来说就是header在置顶之前要贴着cell
             *  同理，header应当保持着与最后一个cell的最小距离，
             *  最后，在不违反上面两则约束的前提下，通过collection view的offset与header的高度来使header处于 origin.y = 0 的状态。
             */
            NSIndexPath *firstCellIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            NSIndexPath *lastCellIndexPath = [NSIndexPath indexPathForItem:MAX(0, (numberOfItemsInSection - 1)) inSection:section];
            
            /**
             *  针对当前layoutAttributes的section， 找出第一个和最后一个普通cell的位置
             */
            UICollectionViewLayoutAttributes *firstCellAttrs = [self layoutAttributesForItemAtIndexPath:firstCellIndexPath];
            UICollectionViewLayoutAttributes *lastCellAttrs = [self layoutAttributesForItemAtIndexPath:lastCellIndexPath];
            
            UICollectionViewLayoutAttributes *firstObjectAttrs;
            UICollectionViewLayoutAttributes *lastObjectAttrs;
            
            if (numberOfItemsInSection > 0) {
                firstObjectAttrs = [self layoutAttributesForItemAtIndexPath:firstCellIndexPath];
                lastObjectAttrs = [self layoutAttributesForItemAtIndexPath:lastCellIndexPath];
            } else {
                firstObjectAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                        atIndexPath:firstCellIndexPath];
                lastObjectAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                       atIndexPath:lastCellIndexPath];
                if (lastObjectAttrs == nil) {
                    lastObjectAttrs = firstObjectAttrs;
                }
            }
            
            /**
             *  获取当前处理header的高度和位置，然后通过firstCellAttrs和lastCellAttrs确定header是否置顶
             */
            CGFloat headerHeight = CGRectGetHeight(layoutAttributes.frame);
            CGPoint origin = layoutAttributes.frame.origin;
            
            origin.y = MIN(
                           MAX(contentOffset.y,
                               (CGRectGetMinY(firstCellAttrs.frame) - headerHeight - self.sectionInset.top )
                               ),
                           (CGRectGetMaxY(lastCellAttrs.frame) - headerHeight + self.sectionInset.bottom)
                           );
            
            layoutAttributes.zIndex = 1024;
            layoutAttributes.frame = (CGRect){
                .origin = origin,
                .size = layoutAttributes.frame.size
            };
        }
    }
    return answer;
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound {
    return YES;
}

@end
