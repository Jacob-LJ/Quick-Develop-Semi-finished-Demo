//
//  KZMutipleProxyBehavior.h
//  hunlimao
//  多路代理转发
//  Created by Eugene on 15/5/21.
//  Copyright (c) 2015年 taoximao. All rights reserved.
//

#import "KZBehavior.h"

@interface KZMutipleProxyBehavior : KZBehavior

/**
 * 所有的代理
 */
@property (nonatomic, weak) IBOutletCollection(id) NSArray* delegateTargets;

@end
