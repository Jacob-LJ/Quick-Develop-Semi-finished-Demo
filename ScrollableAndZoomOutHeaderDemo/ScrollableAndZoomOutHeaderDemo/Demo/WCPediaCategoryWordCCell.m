//
//  WCPediaCategoryWordCCell.m
//  hunlimao
//
//  Created by Jacob on 16/11/11.
//  Copyright © 2016年 taoximao. All rights reserved.
//

#import "WCPediaCategoryWordCCell.h"
#import "UIView+Frame.h"

#define color1 RGBA(251, 145, 159, 1)
#define color2 RGBA(156, 202, 255, 1)
#define color3 RGBA(253, 213, 148, 1)
#define color4 RGBA(160, 220, 207, 1)
#define color5 RGBA(203, 172, 231, 1)

@interface WCPediaCategoryWordCCell ()
@property (weak, nonatomic) IBOutlet UIView *colorMarkView;

@end

@implementation WCPediaCategoryWordCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    switch ((arc4random() % 5)) {
        case 0:
            self.colorMarkView.backgroundColor = color1;
            break;
        case 1:
            self.colorMarkView.backgroundColor = color2;
            break;
        case 2:
            self.colorMarkView.backgroundColor = color3;
            break;
        case 3:
            self.colorMarkView.backgroundColor = color4;
            break;
        case 4:
            self.colorMarkView.backgroundColor = color5;
            break;
        default:
            self.colorMarkView.backgroundColor = [UIColor purpleColor];
            break;
    }
    
}

@end
