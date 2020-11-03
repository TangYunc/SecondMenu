//
//  UINavigationBar+NavAlpha.m
//  MTransparentNav
//
//  Created by mengqingzheng on 2017/4/20.
//  Copyright © 2017年 mengqingzheng. All rights reserved.
//

#import "UINavigationBar+NavAlpha.h"

#define IOS10 [[[UIDevice currentDevice]systemVersion] floatValue] >= 10.0

@implementation UINavigationBar (NavAlpha)

static char *navAlphaKey = "navAlphaKey";
static char *shadowKey = "shadowKey";

-(CGFloat)navAlpha {
    if (objc_getAssociatedObject(self, navAlphaKey) == nil) {
        return 1;
    }
    return [objc_getAssociatedObject(self, navAlphaKey) floatValue];
}

-(void)setNavAlpha:(CGFloat)navAlpha {
    
    CGFloat alpha = MAX(MIN(navAlpha, 1), 0);

    UIView *barBackground = self.subviews.firstObject;
    
    if (self.translucent == NO || [self backgroundImageForBarMetrics:UIBarMetricsDefault] != nil) {
        
        barBackground.alpha = alpha;
        
    } else {
        
        if (IOS10) {
            UIView *effectFilterView = barBackground.subviews.lastObject;
            effectFilterView.alpha = alpha;
        } else {
            UIView *effectFilterView = barBackground.subviews.firstObject;
            effectFilterView.alpha = alpha;
        }
    }
    
//    if ([barBackground valueForKey:@"_shadowView"]) {
//        UIView *shadowView = [barBackground valueForKey:@"_shadowView"];
//        shadowView.alpha = alpha;
//    }
    
    objc_setAssociatedObject(self, navAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isHideShadow {
    return [objc_getAssociatedObject(self, shadowKey) boolValue];
}
-(void)setHideShadow:(BOOL)hideShadow {
    
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self];
    //隐藏导航栏下的线
    navBarHairlineImageView.hidden = hideShadow;
    objc_setAssociatedObject(self, shadowKey, @(hideShadow), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            imageView.alpha = 0.3;
            return imageView;
        }
    }
    return nil;
}


@end
