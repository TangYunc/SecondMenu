//
//  UIViewTools.m
//  Test
//
//  Created by KungJack on 25/9/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import "UIViewTools.h"
/////////////////////////////////////////////////////////////////////////////////
/// 根据传过来的view来计算它的下边缘的Y坐标
/////////////////////////////////////////////////////////////////////////////////
CGFloat UIViewBottomY(id obj){
    if([obj isKindOfClass:[UIView class]]){
        UIView * view = (UIView *)obj;
        return view.frame.size.height + view.frame.origin.y;
    }
    return 0;
    
}
/////////////////////////////////////////////////////////////////////////////////
/// 根据传过来的view来计算它的右边缘的X坐标
/////////////////////////////////////////////////////////////////////////////////
CGFloat UIViewRightX(id obj){
    if([obj isKindOfClass:[UIView class]]){
        UIView * view = (UIView *)obj;
        return view.frame.size.width + view.frame.origin.x;;
    }
    return 0;
}
/////////////////////////////////////////////////////////////////////////////////
/// 根据颜色生成1*1的图片
/////////////////////////////////////////////////////////////////////////////////
UIImage *ImageWithColor(UIColor *color)
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 0.5f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

UIImage *ImageWithColorCGRect(UIColor *color,CGRect rect)
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/////////////////////////////////////////////////////////////////////////////////
/// 把UIView转化成图片
/////////////////////////////////////////////////////////////////////////////////
UIImage *ConvertViewToImage(UIView *view){
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 2);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    view.layer.contents = nil;
    return image;
    
}

@implementation UIViewTools

@end
