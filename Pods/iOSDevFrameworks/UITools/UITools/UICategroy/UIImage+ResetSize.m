//
//  UIImage+ResetSize.m
//  KKDictionary
//
//  Created by KungJack on 29/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import "UIImage+ResetSize.h"

@implementation UIImage (ResetSize)
/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
//    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeTile];
}

+ (UIImage *)resizableImage:(NSString *)name withX:(CGFloat)X Y:(CGFloat)Y
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * X;
    CGFloat h = normal.size.height * Y;
    //    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeTile];
}

+ (UIImage *)resizableImageAtVerticalWith:(NSString *)name{
    UIImage *normal = [UIImage imageNamed:name];
    //CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;

    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, 0, h, 0) resizingMode:UIImageResizingModeStretch];
}
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(reSize.width*image.scale, reSize.height*image.scale), NO, image.scale);
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

-(UIImage *)resizableImageWithX:(CGFloat)X Y:(CGFloat)Y{
    CGSize size = self.size;
    CGFloat top = size.height*Y;
    CGFloat bottom = size.height*(1-Y);
    CGFloat left = size.width*X;
    CGFloat rigth = size.width*(1-X);
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, rigth) resizingMode:UIImageResizingModeTile];
}
@end
