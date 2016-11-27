//
//  JA_MenuModel.h
//  PopRightItemMenuViewDemo
//
//  Created by Jacob_Liang on 16/11/27.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JA_MenuModel : NSObject
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *itemName;

+ (instancetype)MenuModelWithDict:(NSDictionary *)dict;


@end
