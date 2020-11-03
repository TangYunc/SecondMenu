//
//  UITabBar+BadgeImage.m
//  Doctor
//
//  Created by yuanxin on 15/8/24.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import "UITabBar+NewBadge.h"
#import "KKDToolsDefine.h"
@implementation UITabBar (NewBadge)

-(void)tabBarAddBadgeImageAtBarItem:(NSInteger)itemNumber
{
    NSInteger count = self.items.count;
    if (itemNumber>=count) {
        return;
    }
    itemNumber += 1;
    UIView *dadgeView = [self viewWithTag:1000+itemNumber];
    if (!dadgeView) {
        dadgeView = [[UIView alloc]init];
        dadgeView.backgroundColor = [UIColor redColor];
        dadgeView.tag = 1000+itemNumber;
        CGFloat tabFrameWidth = self.frame.size.width;
        CGFloat x = (itemNumber*(tabFrameWidth/count)-tabFrameWidth/count/2)+15;
        CGFloat y = 2;
        CGFloat width = kGetWidth(8);
        dadgeView.frame = CGRectMake(x, y, width, width);
        dadgeView.userInteractionEnabled = YES;
        dadgeView.layer.masksToBounds = YES;
        dadgeView.layer.cornerRadius = width * 0.5;
        [self addSubview:dadgeView];
    }
    dadgeView.hidden = NO;
}

-(void)tabBarBadgeImageHidden:(NSInteger)itemNumber
{
    itemNumber += 1;
    UIImageView *dadgeImageView = (UIImageView *)[self viewWithTag:1000+itemNumber];
    if (dadgeImageView) {
        dadgeImageView.hidden = YES;
    }
}

@end
