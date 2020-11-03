//
//  UIImagePickerController+permissions.m
//  Doctor
//
//  Created by 张良玉 on 2018/5/28.
//  Copyright © 2018年 YX. All rights reserved.
//

#import "UIImagePickerController+permissions.h"
#import <objc/runtime.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "YXAlertView.h"

@implementation UIImagePickerController (permissions)

-(BOOL)authorizationStatusWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    self.sourceType = sourceType;
    return [self authorizationStatus];
}

-(BOOL)authorizationStatus{
    AVAuthorizationStatus author = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (self.sourceType==UIImagePickerControllerSourceTypeCamera) {
        if(author==AVAuthorizationStatusRestricted || author==AVAuthorizationStatusDenied){
            [YXAlertView shareAlerViewWithTitle:nil message:@"请在iPhone的“设置-隐私-相机”选项中，允许妙手登录访问你的相机" textAlignment:NSTextAlignmentCenter cancelButtonTitle:@"好" otherButtonTitle:nil clickedBlock:^(NSInteger buttonIndex) {
                
            }];
            return NO;
        }
    }else if(self.sourceType==UIImagePickerControllerSourceTypePhotoLibrary){
        if(author==AVAuthorizationStatusRestricted||author==AVAuthorizationStatusDenied){
            [YXAlertView shareAlerViewWithTitle:nil message:@"请在iPhone的“设置-隐私-相册”选项中，允许妙手登录访问你的相册" textAlignment:NSTextAlignmentCenter cancelButtonTitle:@"好" otherButtonTitle:nil clickedBlock:^(NSInteger buttonIndex) {
                
            }];
            return NO;
        }
    }
    return YES;
}
@end
