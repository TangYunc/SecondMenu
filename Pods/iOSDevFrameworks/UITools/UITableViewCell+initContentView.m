//
//  UITableViewCell+initContentView.m
//  OnlineHosptial
//
//  Created by 张良玉 on 2020/9/23.
//  Copyright © 2020 zhangliangyu. All rights reserved.
//

#import "UITableViewCell+initContentView.h"
#import <objc/runtime.h>
@implementation UITableViewCell (initContentView)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(initWithStyle:reuseIdentifier:);
        SEL swizzledSelector = @selector(contentView_initWithStyle:reuseIdentifier:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        //交换实现
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (instancetype)contentView_initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie{
    [self contentView_initWithStyle:style reuseIdentifier:reuseIdentifie];
    self.contentView.backgroundColor = [UIColor clearColor];
    return self;
}
@end
