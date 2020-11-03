//
//  UITextView+Placeholder.h
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/8.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

//系统版本
#define TYCVersion [[[UIDevice currentDevice] systemVersion] floatValue]
NS_ASSUME_NONNULL_BEGIN

@interface UITextView (Placeholder)

-(void)setPlaceholder:(NSString *)placeholdStr placeholdColor:(UIColor *)placeholdColor;

@end

NS_ASSUME_NONNULL_END
