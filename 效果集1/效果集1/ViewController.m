//
//  ViewController.m
//  效果集1
//
//  Created by Jacob_Liang on 16/10/16.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "PackageSelectListController.h"

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

- (IBAction)pushBtnClick:(id)sender {
    PackageSelectListController *selectListVC = [[PackageSelectListController alloc] init];
    selectListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:selectListVC animated:YES];
}

@end
