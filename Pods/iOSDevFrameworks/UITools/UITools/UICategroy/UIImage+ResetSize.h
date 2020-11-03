//
//  UIImage+ResetSize.h
//  KKDictionary
//
//  Created by KungJack on 29/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ResetSize)

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
+ (UIImage *)resizableImage:(NSString *)name;
+ (UIImage *)resizableImageAtVerticalWith:(NSString *)name;

+ (UIImage *)resizableImage:(NSString *)name withX:(CGFloat)X Y:(CGFloat)Y;
-(UIImage *)resizableImageWithX:(CGFloat)X Y:(CGFloat)Y;
@end
