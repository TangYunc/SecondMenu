//
//  UIView+Cornerdious.h
//  PerfectDoc
//
//  Created by mazhijun on 2019/12/12.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Cornerdious)
/**
 设置圆角
 cornerdious    圆角度
 corners        设置某个位置的圆角 UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerTopRight
 
 */
-(void)setRectCornerdious:(CGFloat)cornerdious Corners:(UIRectCorner)corners;
/**
 设置圆角
 cornerdious    圆角度
 rect           矩形
 corners        设置某个位置的圆角 UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerTopRight
 
 */
-(void)setRectCornerdious:(CGFloat)cornerdious Rect:(CGRect)rect Corners:(UIRectCorner)corners;
@end

NS_ASSUME_NONNULL_END
