//
//  ViewController.m
//  在类的初始化方法中应该直接调用实例变量
//
//  Created by Jacob_Liang on 16/11/17.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"
#import "SmithPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    Person *person = [[Person alloc] init];
    SmithPerson *smithPerson = [[SmithPerson alloc] init];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
