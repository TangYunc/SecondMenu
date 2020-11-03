//
//  UITabBar+BadgeImage.h
//  Doctor
//
//  Created by yuanxin on 15/8/24.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (NewBadge)
-(void)tabBarAddBadgeImageAtBarItem:(NSInteger)itemNumber;
-(void)tabBarBadgeImageHidden:(NSInteger)itemNumber;
@end
