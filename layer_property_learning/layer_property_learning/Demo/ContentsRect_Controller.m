//
//  ContentsRect_Controller.m
//  layer_property_learning
//
//  Created by Jacob_Liang on 16/12/3.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ContentsRect_Controller.h"

@interface ContentsRect_Controller ()

@property (nonatomic, weak) IBOutlet UIView *spritsView; //拼合的大图
@property (nonatomic, weak) IBOutlet UIView *topLeftView;
@property (nonatomic, weak) IBOutlet UIView *topRightiew;
@property (nonatomic, weak) IBOutlet UIView *bottomLeftView;
@property (nonatomic, weak) IBOutlet UIView *bottomRightView;

@end

@implementation ContentsRect_Controller

- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer {
    //set image
    layer.contents = (__bridge id)image.CGImage;
    
    //scale contents to fit
    layer.contentsGravity = kCAGravityResizeAspect;
    
    //set contentsRect
    layer.contentsRect = rect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     1> contentsRect 指定图片的一个区域 (采用相对单位), 然后加载到对应的 layer.contents 上去
     2> 事实上给contentsRect设置一个负数的原点或是大于{1, 1}的尺寸也是可以的。这种情况下，最外面的像素会被拉伸以填充剩下的区域
     3> 典型地，图片拼合后可以打包整合到一张大图上一次性载入。相比多次载入不同的图片，这样做能够带来很多方面的好处：内存使用，载入时间，渲染性能等等
     4> 拼合不仅给app提供了一个整洁的载入方式，还有效地提高了载入性能（单张大图比多张小图载入得更快），但是如果有手动安排的话，它们还是有一些不方便的，如果你需要在一个已经创建好的拼合图上做一些尺寸上的修改或者其他变动，无疑是比较麻烦的。
     5> 一般使用地方在,先载入一张大的拼合图, 然后通过 contentsRect 获取该拼合图的各个位置的小图,然后进行赋值显示操作,参考如下例子;
     */
    
    //load sprite sheet
    UIImage *image = [UIImage imageNamed:@"sprites"];
    
    //展示拼合图
    self.spritsView.layer.contents = (__bridge id)image.CGImage;
    self.spritsView.layer.contentsGravity = kCAGravityResizeAspect;
    
    //分别拆开拼合图显示对应小图
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:self.topLeftView.layer];
    
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:self.topRightiew.layer];
    
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:self.bottomLeftView.layer];
    
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:self.bottomRightView.layer];
}

@end
