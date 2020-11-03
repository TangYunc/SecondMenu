//
//  UIView+ColorChange.h
//  OnlineHosptial
//
//  Created by 张良玉 on 2019/4/26.
//  Copyright © 2019年 zhangliangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ColorChange)
- (void)viewColorChangeFromCoror:(UIColor *)fromColor toColor:(UIColor *)toColor withTheView:(UIView *)view;

- (void)viewColorChangeWithColors:(NSArray *)colors withTheView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
