//
//  ThrowLineTool.h
//  hunlimao
//
//  Created by Jacob on 16/10/10.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol ThrowLineToolDelegate;

@interface ThrowLineTool : NSObject

@property (nonatomic, assign) id<ThrowLineToolDelegate>delegate;
@property (nonatomic, retain) UIView *showingView;

+ (ThrowLineTool *)sharedTool;

/**
 *  将某个view或者layer从起点抛到终点
 *
 *  @param obj    被抛的物体
 *  @param start  起点坐标
 *  @param end    终点坐标
 */
- (void)throwObject:(UIView *)obj from:(CGPoint)start to:(CGPoint)end;

@end


@protocol ThrowLineToolDelegate <NSObject>

/**
 *  抛物线结束的回调
 */
- (void)animationDidFinish;

@end


