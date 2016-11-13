//
//  ViewController.m
//  segmentControlSetdifferentColor
//
//  Created by Jacob_Liang on 16/11/13.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置segmentControl颜色
    [self.segControl setTitleTextAttributes:@{
                                              NSForegroundColorAttributeName : [UIColor whiteColor]
                                              } forState:UIControlStateSelected];
    [self.segControl setTitleTextAttributes:@{
                                              NSForegroundColorAttributeName : [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1]
                                              } forState:UIControlStateNormal];
    //单独设置UISegmentedControl 的边框颜色
    NSArray *arri = [self.segControl subviews];
    [[arri objectAtIndex:0] setTintColor:[UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:1]];
    [[arri objectAtIndex:1] setTintColor:[UIColor purpleColor]];
}

- (IBAction)selectSegmentControl:(UISegmentedControl *)sender {
    
    NSArray *arri = [self.segControl subviews];
    if (sender.selectedSegmentIndex == 0) {
        [[arri objectAtIndex:1] setTintColor:[UIColor purpleColor]];
        [[arri objectAtIndex:0] setTintColor:[UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:1]];
        
    } else if (sender.selectedSegmentIndex == 1) {
        [[arri objectAtIndex:0] setTintColor:[UIColor purpleColor]];
        [[arri objectAtIndex:1] setTintColor:[UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:1]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
