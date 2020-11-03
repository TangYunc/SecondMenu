//
//  UITapGestureRecognizer+Pass.m
//  Doctor
//
//  Created by 张良玉 on 2018/5/21.
//  Copyright © 2018年 YX. All rights reserved.
//

#import "UITapGestureRecognizer+Pass.h"
#import <objc/runtime.h>
static char PassContentKey;

@implementation UITapGestureRecognizer (Pass)
-(id)passContent{
    return objc_getAssociatedObject(self, &PassContentKey);
}

- (void)setPassContent:(id)passContent {
    objc_setAssociatedObject(self, &PassContentKey, passContent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
