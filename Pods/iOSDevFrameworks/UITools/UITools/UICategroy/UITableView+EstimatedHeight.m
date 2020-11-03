//
//  UITableView+EstimatedHeight.m
//  Doctor
//
//  Created by 张良玉 on 2018/5/11.
//  Copyright © 2018年 YX. All rights reserved.
//

#import "UITableView+EstimatedHeight.h"
#import <objc/runtime.h>
#import "ToolsHeader.h"
@implementation UITableView (EstimatedHeight)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(initWithFrame: style:);
        SEL swizzledSelector = @selector(setEstimatedHeight_initWithFrame: style:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        //交换实现
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (instancetype)setEstimatedHeight_initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    [self setEstimatedHeight_initWithFrame:frame style:style];
    if (isIOS11) {
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
    }
    self.separatorColor = RGB_COLOR_WITH_0x(CellLineViewColor);
    self.backgroundColor = RGB_COLOR_WITH_0x(BgViewColor);
    return self;
}
@end
