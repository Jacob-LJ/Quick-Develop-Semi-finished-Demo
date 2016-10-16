//
//  PSLMoreDetailImageController.m
//  hunlimao
//
//  Created by Jacob on 16/10/10.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "PSLMoreDetailImageController.h"

@interface PSLMoreDetailImageController ()<UIScrollViewDelegate>

@end

@implementation PSLMoreDetailImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollV.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 2);
    scrollV.delegate = self;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn1.frame = CGRectMake(100, 0, 100, 100);
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn2.frame = CGRectMake(100, [UIScreen mainScreen].bounds.size.height - 100, 100, 100);
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn3.frame = CGRectMake(100, [UIScreen mainScreen].bounds.size.height, 100, 100);
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn4.frame = CGRectMake(100, [UIScreen mainScreen].bounds.size.height * 2 - 100, 100, 100);
    
    [scrollV addSubview:btn1];
    [scrollV addSubview:btn2];
    [scrollV addSubview:btn3];
    [scrollV addSubview:btn4];
    
    [self.view addSubview:scrollV];
}


@end
