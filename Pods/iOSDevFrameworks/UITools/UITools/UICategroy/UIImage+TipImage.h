//
//  UIImage+TipImage.h
//  KKDictionary
//
//  Created by KungJack on 7/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TipImage)

//////////////////////////////////////////////////////////////////////////////////////////
///  通过图片获取图片中等分的一部分
///  imageName 图片名
///  x y 等分图片的坐标
///  row 图片切分几行
///  e.g.    [UIImage getTipOfImageWithImageName:1 y:1 col:3 row:2]
///  即 UIImage被切成如下方式
///  1 2 3
///  4 5 6
///  返回的是标号为5的区域图片
//////////////////////////////////////////////////////////////////////////////////////////
+(UIImage *)getTipOfImageWithImage:(UIImage *)image x:(int)x y:(int)y col:(int)col row:(int)row;
//////////////////////////////////////////////////////////////////////////////////////////
///  通过图片的名字获取图片中等分的一部分
///  imageName 图片名
///  x y 等分图片的坐标
///  row 图片切分几行
///  e.g.    [UIImage getTipOfImageWithImageName:1 y:1 col:3 row:2]
///  即 UIImage 被切成如下方式
///  1 2 3
///  4 5 6
///  返回的是标号为5的区域图片
//////////////////////////////////////////////////////////////////////////////////////////
+(UIImage *)getTipOfImageWithImageName:(NSString*)imageName x:(int)x y:(int)y col:(int)col row:(int)row;

+(UIImage *)getTipOfImageWithCGRect:(CGRect)rect imageName:(UIImage*)image;

@end
