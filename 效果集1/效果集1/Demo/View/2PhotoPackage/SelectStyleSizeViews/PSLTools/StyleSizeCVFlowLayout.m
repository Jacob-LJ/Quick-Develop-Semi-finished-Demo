//
//  StyleSizeCVFlowLayout.m
//  hunlimao
//
//  Created by Jacob on 16/10/13.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "StyleSizeCVFlowLayout.h"

@implementation StyleSizeCVFlowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    NSMutableArray* attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
        for (UICollectionViewLayoutAttributes *attr in attributes) {
            NSLog(@"%@", NSStringFromCGRect([attr frame]));
        }
    //计算限制item间的最大间距
    //从第二个循环到最后一个
    for(int i = 1; i < [attributes count]; ++i) {
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        //我们想设置的最大间距，可根据需要改
        NSInteger maximumSpacing = 5;
        //获取的前一个cell为第0个
        if (i-1 == 0) {
            CGRect frame = prevLayoutAttributes.frame;
            frame.origin.x = 0;
            prevLayoutAttributes.frame = frame;
        }
        //前一个cell的最右边
        NSInteger prevMaxX = CGRectGetMaxX(prevLayoutAttributes.frame);
        //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        if(prevMaxX + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = prevMaxX + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        } else {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = 0;
            currentLayoutAttributes.frame = frame;
        }
    }
    
    return attributes;
}

@end
