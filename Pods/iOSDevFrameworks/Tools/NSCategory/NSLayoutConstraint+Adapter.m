//
//  NSLayoutConstraint+Geometric.m
//  StudyAutoLayout
//
//  Created by 张良玉 on 16/3/15.
//  Copyright © 2016年 zhangliangyu. All rights reserved.
//

#import "NSLayoutConstraint+Adapter.h"

@implementation NSLayoutConstraint (Adapter)

-(void)setIsRelative:(BOOL)isRelative
{
    if (isRelative) {
        CGFloat constant = self.constant;
        self.constant = constant*([[UIScreen mainScreen] bounds].size.width/375);
    }
}

-(BOOL)isRelative
{
    return self.isRelative;
}

@end
