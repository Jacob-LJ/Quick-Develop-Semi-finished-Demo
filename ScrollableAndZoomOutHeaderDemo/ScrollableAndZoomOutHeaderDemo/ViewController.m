//
//  ViewController.m
//  ScrollableAndZoomOutHeaderDemo
//
//  Created by Jacob_Liang on 16/11/13.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "WeddingCyclopediaController.h"

@interface ViewController ()

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
    
    WeddingCyclopediaController *cyclopediaVc = [[WeddingCyclopediaController alloc] init];
    [self.navigationController pushViewController:cyclopediaVc animated:YES];
}


@end
