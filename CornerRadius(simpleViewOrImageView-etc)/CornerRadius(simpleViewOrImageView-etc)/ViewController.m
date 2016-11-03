//
//  ViewController.m
//  CornerRadius(simpleViewOrImageView-etc)
//
//  Created by Jacob_Liang on 16/10/31.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "testCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) testCell *cell;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    testCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.lable.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    self.cell = cell;
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    
//}

@end
