//
//  ViewController.m
//  xib的简单collectionView
//
//  Created by Jacob on 16/10/17.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "SelectedRefinementPhotoController.h"

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
    SelectedRefinementPhotoController *VC = [[SelectedRefinementPhotoController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}


@end
