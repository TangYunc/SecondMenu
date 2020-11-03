//
//  UIImage+TipImage.m
//  KKDictionary
//
//  Created by KungJack on 7/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import "UIImage+TipImage.h"

@implementation UIImage (TipImage)

+(UIImage *)getTipOfImageWithImage:(UIImage *)image x:(int)x y:(int)y col:(int)col row:(int)row{
    
    float width = image.size.width/col;
    float height = image.size.height/row;
    
    CGRect rect = CGRectMake(x*width, y*height, width, height);
    UIImage *tipImage = [UIImage getTipOfImageWithCGRect:rect imageName:image];
    return tipImage;
    
}

+(UIImage *)getTipOfImageWithImageName:(NSString*)imageName x:(int)x y:(int)y col:(int)col row:(int)row{
    
    UIImage *image = [UIImage imageNamed:imageName];
    return [UIImage getTipOfImageWithImage:image x:x y:y col:col row:row];
    
}


+(UIImage *)getTipOfImageWithCGRect:(CGRect)rect imageName:(UIImage*)image{
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(rect.origin.x*image.scale, rect.origin.y*image.scale, rect.size.width*image.scale, rect.size.height*image.scale));
    UIImage *tipImage = [UIImage imageWithCGImage:subImageRef scale:image.scale orientation:UIImageOrientationUp];
    CGImageRelease(subImageRef);
    
    return tipImage;
}


@end
