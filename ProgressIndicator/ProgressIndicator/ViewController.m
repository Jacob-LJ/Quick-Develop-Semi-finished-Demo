//
//  ViewController.m
//  ProgressIndicator
//
//  Created by Jacob_Liang on 16/11/13.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (nonatomic, strong) CAShapeLayer *indicateLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self refreshUIWithProgress:(arc4random() % 300 )];
}

- (void)refreshUIWithProgress:(NSInteger)progress {
    
    CGFloat width = (progress)*(CGRectGetWidth(self.progressView.frame)/([UIScreen mainScreen].bounds.size.width));
    [self.indicateLayer removeFromSuperlayer];
    self.indicateLayer = nil;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, CGRectGetHeight(self.progressView.frame)) cornerRadius:5];
    self.indicateLayer = [CAShapeLayer layer];
    self.indicateLayer.path = path.CGPath;
    self.indicateLayer.fillColor = [UIColor redColor].CGColor;
    [self.progressView.layer addSublayer:self.indicateLayer];
}


@end
