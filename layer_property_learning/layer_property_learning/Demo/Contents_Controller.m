//
//  Contents_Controller.m
//  layer_property_learning
//
//  Created by Jacob_Liang on 16/12/1.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "Contents_Controller.h"

@interface Contents_Controller ()

@property (nonatomic, weak) IBOutlet UIView *contentsView;
@property (nonatomic, weak) IBOutlet UIView *contentGravityView;
@property (nonatomic, weak) IBOutlet UIView *contentScaleView;
@property (nonatomic, weak) IBOutlet UIView *contentScaleView_exactlyScaleValue;

@property (nonatomic, weak) IBOutlet UIView *maskToBoundsView;

@property (nonatomic, weak) IBOutlet UIView *contentsCenterView1;
@property (nonatomic, weak) IBOutlet UIView *contentsCenterView2;

@end

@implementation Contents_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
//1 contents
    //利用CALayer在一个普通的UIView中显示了一张图片。这不是一个UIImageView，它不是我们通常用来展示图片的方法。
    //load an image
    UIImage *image = [UIImage imageNamed:@"btn_home_selected"];
    
    //add it directly to our view's layer
    self.contentsView.layer.contents = (__bridge id)image.CGImage; //这样出来的图片模式是按比例填充的,模式不对
    
//2 contentGravity
    //然图片适应这个视图 效果相当于 view.contentMode = UIViewContentModeScaleAspectFit;
    self.contentGravityView.layer.contents = (__bridge id)image.CGImage;
    
    //和cotentMode一样，contentsGravity的目的是为了决定内容在图层的边界中怎么对齐，我们将使用kCAGravityResizeAspect，它的效果等同于UIViewContentModeScaleAspectFit， 同时它还能在图层中等比例拉伸以适应图层的边界。
        self.contentGravityView.layer.contentsGravity = kCAGravityResizeAspect; //(按照view的大小缩放 contents图)
    
    /*
     contentsGravity 相关值:
     kCAGravityCenter
     kCAGravityTop
     kCAGravityBottom
     kCAGravityLeft
     kCAGravityRight
     kCAGravityTopLeft
     kCAGravityTopRight
     kCAGravityBottomLeft
     kCAGravityBottomRight
     kCAGravityResize
     kCAGravityResizeAspect
     kCAGravityResizeAspectFill
     */
    
//3 contentsScale (再多度文章吧, 理解还是有点模糊)
    UIImage *snowImage = [UIImage imageNamed:@"snowman_hat_128px_566748_easyicon"];
    self.contentScaleView.layer.contents = (__bridge id)snowImage.CGImage;
    self.contentScaleView.layer.contentsGravity = kCAGravityCenter; //不拉伸图片
    
    //让图片在 retainer 屏幕上正确显示
    self.contentScaleView_exactlyScaleValue.layer.contents = (__bridge id)snowImage.CGImage;
    self.contentScaleView_exactlyScaleValue.layer.contentsGravity = kCAGravityCenter; //不拉伸图片
    self.contentScaleView_exactlyScaleValue.layer.contentsScale = [UIScreen mainScreen].scale;
    //当用代码的方式来处理寄宿图的时候，一定要记住要手动的设置图层的contentsScale属性，否则，你的图片在Retina设备上就显示得不正确啦
    
//4 maskToBounds
    self.maskToBoundsView.layer.contents = (__bridge id)snowImage.CGImage;
    self.maskToBoundsView.layer.contentsGravity = kCAGravityCenter; //不拉伸图片, 图片超出边界,默认情况下，UIView仍然会绘制超过边界的内容或是子视图，在CALayer下也是这样的。
    //UIView有一个叫做clipsToBounds的属性可以用来决定是否显示超出边界的内容，CALayer对应的属性叫做masksToBounds，把它设置为YES，雪人就在边界里啦～
    self.maskToBoundsView.layer.masksToBounds = YES;
    
//5 contentsCenter
    //参考文章contentsCenter部分的例子图,更加清晰
    //https://github.com/AttackOnDobby/iOS-Core-Animation-Advanced-Techniques/blob/master/2-%E5%AF%84%E5%AE%BF%E5%9B%BE/%E5%AF%84%E5%AE%BF%E5%9B%BE.md
    UIImage *contentsCenterImage = [UIImage imageNamed:@"stretchImage"];
    
    //set button 1
    [self addStretchableImage:contentsCenterImage withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:self.contentsCenterView1.layer];
    
    //set button 2
    [self addStretchableImage:contentsCenterImage withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:self.contentsCenterView2.layer];
    
}

- (void)addStretchableImage:(UIImage *)image withContentCenter:(CGRect)rect toLayer:(CALayer *)layer {
    //set image
    layer.contents = (__bridge id)image.CGImage;
    
    //set contentsCenter
    layer.contentsCenter = rect;
}



@end
