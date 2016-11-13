//
//  KZImagePickBehavior.h
//  Demo
//
//  Created by Eugene on 15/5/6.
//  Copyright (c) 2015年 hunlimao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZBehavior.h"
@class KZImagePickBehavior;

@protocol KZImagePickDelegate <NSObject>

@optional
- (void)imagePickBehavior:(KZImagePickBehavior *)imagePickBehavior didPickImage:(UIImage *)image;

@end


@interface KZImagePickBehavior : KZBehavior

@property (nonatomic, weak) IBOutlet UIImageView* targetImageView;
@property (nonatomic, assign) IBOutlet id<KZImagePickDelegate> delegate;

- (IBAction)pickImageFromSender:(id)sender;

@end
