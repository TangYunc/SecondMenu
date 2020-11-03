//
//  UIView+ColorChange.m
//  OnlineHosptial
//
//  Created by 张良玉 on 2019/4/26.
//  Copyright © 2019年 zhangliangyu. All rights reserved.
//

#import "UIView+ColorChange.h"

@implementation UIView (ColorChange)

/**
 设置视图颜色渐变
 
 @param fromColor 上部分的颜色
 @param toColor 下部分的颜色
 @param view 颜色变化的视图
 */
- (void)viewColorChangeFromCoror:(UIColor *)fromColor toColor:(UIColor *)toColor withTheView:(UIView *)view{
    
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [view.layer addSublayer:gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 0.7);
    
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor,
                             (__bridge id)toColor.CGColor];
    
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.5f), @(1.f)];
}



/// 设置视图颜色渐变
/// @param colors NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor,colorThree.CGColor, nil];
/// @param view 颜色变化的视图
- (void)viewColorChangeWithColors:(NSArray *)colors withTheView:(UIView *)view{
    
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [view.layer addSublayer:gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //设置颜色数组
    gradientLayer.colors = colors;
    
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.5f), @(1.f)];
}

@end
