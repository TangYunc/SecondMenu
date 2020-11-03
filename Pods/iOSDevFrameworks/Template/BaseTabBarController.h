//
//  KKDTabBarController.h
//  Doctor
//
//  Created by 赵洋 on 15/5/13.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage;
@end

@interface UINavigationController (Autorotate)
@end
