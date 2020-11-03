//
//  UIViewUtil.h
//  KKDictionary
//
//  Created by KungJack on 7/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewUtil : NSObject

/////////////////////////////////////////////////////////////////////////////////
/// 创建圆角View
/////////////////////////////////////////////////////////////////////////////////
+ (UIView *)creatRoundCornerView:(CGRect)frame;
/////////////////////////////////////////////////////////////////////////////////
/// 创建Lable
/////////////////////////////////////////////////////////////////////////////////
+(UILabel *)creatLableWithFrame:(CGRect )rect
                           font:(UIFont*)font
                  textAlignment:(NSTextAlignment)textAlignment
                      textColor:(UIColor *)textColor;
/////////////////////////////////////////////////////////////////////////////////
/// 创建按钮
/////////////////////////////////////////////////////////////////////////////////
+(UIButton *)creatButtonWithFrame:(CGRect )rect
                             font:(UIFont*)font
                            title:(NSString *)title
                       titleColor:(UIColor *)titleColor
                    bgNormalImage:(UIImage *)bgNormal
                bgHightLightImage:(UIImage *)bgHighLight;

+(UIView *)creatBadgeViewWithPoint:(CGPoint)point badgeValue:(NSString *)badgeValue;

@end
