//
//  UIImagePickerController+permissions.h
//  Doctor
//
//  Created by 张良玉 on 2018/5/28.
//  Copyright © 2018年 YX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (permissions)
-(BOOL)authorizationStatus;
-(BOOL)authorizationStatusWithSourceType:(UIImagePickerControllerSourceType)sourceType;
@end
