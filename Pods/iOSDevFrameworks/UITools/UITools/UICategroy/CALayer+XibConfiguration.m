//
//  CALayer+XibConfiguration.m
//  Doctor
//
//  Created by 赵洋 on 16/7/13.
//  Copyright © 2016年 YX. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}
@end
