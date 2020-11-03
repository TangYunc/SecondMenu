//
//  UIScrollView+Setup.m
//  Doctor
//
//  Created by 张良玉 on 2018/10/22.
//  Copyright © 2018年 YX. All rights reserved.
//

#import "UIScrollView+Setup.h"
#import <objc/runtime.h>
#import "ToolsHeader.h"
@implementation UIScrollView (Setup)
+(void)load{
    if (isIOS11) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class class = [self class];
            
            SEL originalSelector = @selector(initWithFrame:);
            SEL swizzledSelector = @selector(setup_initWithFrame: );
            
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            //交换实现
            method_exchangeImplementations(originalMethod, swizzledMethod);
        });
    }
}

- (instancetype)setup_initWithFrame:(CGRect)frame{
    [self setup_initWithFrame:frame];
    if (@available(ios 11.0,*)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return self;
}
@end
