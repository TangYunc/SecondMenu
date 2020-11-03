//
//  YXSlider.m
//  蓝媒智能家居系统
//
//  Created by cchhjj on 16/10/25.
//  Copyright © 2016年 BlueMedia. All rights reserved.
//

#import "YXSlider.h"
#import "ToolsHeader.h"
@implementation YXSlider
-(CGRect)trackRectForBounds:(CGRect)bounds{
    CGFloat height = kGetWidth(5);
    bounds.size.height = height;
    self.layer.cornerRadius = height/2;
    return bounds;
}
//这个方法用于改变滑块的触摸范围
-(CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
    CGFloat height = bounds.size.height;
    CGFloat magin = (height-rect.size.height)/2;
    rect.origin.x = rect.origin.x - magin ;
    rect.size.width = rect.size.width + magin*2;
    
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], magin , magin);
}

@end
