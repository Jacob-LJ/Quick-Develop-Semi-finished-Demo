//
//  ViewController.m
//  layer_property_learning
//
//  Created by Jacob_Liang on 16/11/30.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ViewController.h"
#import "Contents_Controller.h"
#import "ContentsRect_Controller.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellID"];
    switch (row) {
        case 0: {
            cell.textLabel.text = [NSString stringWithFormat:@"%ld - contents 属性",indexPath.row];
            
        }
            break;
            
        case 1: {
            cell.textLabel.text = [NSString stringWithFormat:@"%ld - contentsRect 属性",indexPath.row];
            
        }
            break;
            
        case 2: {
            cell.textLabel.text = [NSString stringWithFormat:@"%ld -  属性",indexPath.row];
            
        }
            break;
            
        case 3: {
            cell.textLabel.text = [NSString stringWithFormat:@"%ld -  属性",indexPath.row];
            
        }
            
            break;
            
        case 4: {
            cell.textLabel.text = [NSString stringWithFormat:@"%ld -  属性",indexPath.row];
            
        }
            break;
            
        case 5: {
            cell.textLabel.text = [NSString stringWithFormat:@"%ld -  属性",indexPath.row];
            
        }
            break;
            
        case 6: {
            cell.textLabel.text = [NSString stringWithFormat:@"%ld -  属性",indexPath.row];
            
        }
            break;

        default:
            cell.textLabel.text = [NSString stringWithFormat:@"%ld - 未设定",indexPath.row];
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    switch (row) {
        case 0: {
            Contents_Controller *contentsVC = [mainSB instantiateViewControllerWithIdentifier:NSStringFromClass([Contents_Controller class])];
            contentsVC.title = @"layer.contents";
            [self.navigationController pushViewController:contentsVC animated:YES];
            
        }
            break;
            
        case 1: {
            ContentsRect_Controller *contentsRectVC = [mainSB instantiateViewControllerWithIdentifier:NSStringFromClass([ContentsRect_Controller class])];
            contentsRectVC.title = @"layer.contentsRect";
            [self.navigationController pushViewController:contentsRectVC animated:YES];
            
        }
            break;
            
        case 2: {
            
            
        }
            break;
            
        case 3: {
            
            
        }
            
            break;
            
        case 4: {
            
            
        }
            break;
            
        case 5: {
            
            
        }
            break;
            
        case 6: {
            
            
        }
            break;
            
        default:
            
            break;
    }

}


@end
