//
//  KZImagePickBehavior.m
//  Demo
//
//  Created by Eugene on 15/5/6.
//  Copyright (c) 2015年 hunlimao. All rights reserved.
//

#import "KZImagePickBehavior.h"
@interface KZImagePickBehavior ()<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation KZImagePickBehavior


- (IBAction)pickImageFromSender:(id)sender{
    UIActionSheet *actionSheet;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                  delegate:self
                                         cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选择", @"拍照", nil];
    }else{
        actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                  delegate:self
                                         cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选择", nil];
    }
    
    
    if ([self.owner isKindOfClass:[UIViewController class]]) {
        [actionSheet showInView:((UIViewController *)self.owner).view];
    }

}


#pragma mark- UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self pickImageFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        case 1:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                [self pickImageFromSource:UIImagePickerControllerSourceTypeCamera];
            }
            break;
    }
    
}

- (void)pickImageFromSource:(UIImagePickerControllerSourceType) sourceType{
    UIImagePickerController *imgPickController = [[UIImagePickerController alloc] init];
    imgPickController.delegate = self;
    imgPickController.sourceType = sourceType;
    imgPickController.allowsEditing = YES;
    
    [self.owner presentViewController:imgPickController animated:YES completion:nil];
}

#pragma mark- UIImagePickerControllerDelegate
/**
 *  用户选择了图片
 *
 *  @param picker
 *  @param info
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image= [info objectForKey:UIImagePickerControllerEditedImage];
    
    self.targetImageView.image = image;
    
    if ([self.delegate respondsToSelector:@selector(imagePickBehavior:didPickImage:)]) {
        [self.delegate imagePickBehavior:self didPickImage:image];
    }
}

- (void)dealloc{
    NSLog(@"KZImagePickBehavior dealloc");
}

@end
