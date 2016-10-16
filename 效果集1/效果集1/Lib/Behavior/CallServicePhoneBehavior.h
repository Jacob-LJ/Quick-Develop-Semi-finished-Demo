//
//  CallServicePhoneBehavior.h
//  hunlimao
//  拨打服务电话
//  Created by Eugene on 15/5/28.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "KZBehavior.h"

@interface CallServicePhoneBehavior : KZBehavior

/**
 *  拨打服务电话
 *
 *  @param sender 
 */
- (IBAction)callServicePhone:(id)sender;

/**
 *  拨打服务电话
 */
+ (void)callServicePhone;

/**
 *  拨打商家电话
 */
+ (void)callMallBusinessPhone:(NSString *)phone;

@end
