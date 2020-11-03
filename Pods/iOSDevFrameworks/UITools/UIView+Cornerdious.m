//
//  UIView+Cornerdious.m
//  PerfectDoc
//
//  Created by mazhijun on 2019/12/12.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//


#import "UIView+Cornerdious.h"

@implementation UIView (Cornerdious)

-(void)setRectCornerdious:(CGFloat)cornerdious Corners:(UIRectCorner)corners {

     [self setRectCornerdious:cornerdious Rect:self.bounds Corners:corners];
}

-(void)setRectCornerdious:(CGFloat)cornerdious Rect:(CGRect)rect Corners:(UIRectCorner)corners{
    
    UIBezierPath * maskPath =[UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(cornerdious, cornerdious)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}
@end
