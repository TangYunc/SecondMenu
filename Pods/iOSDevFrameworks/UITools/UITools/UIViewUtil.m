//
//  UIViewUtil.m
//  KKDictionary
//
//  Created by KungJack on 7/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import "UIViewUtil.h"
#import "ToolsHeader.h"
@implementation UIViewUtil

+ (UIView *)creatRoundCornerView:(CGRect)frame{
    
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.layer.cornerRadius = 3.0f;
    view.layer.masksToBounds = YES;
//    view.layer.borderColor = kSubViewBorderCGColor;
    view.layer.borderWidth = 1.0f;
//    view.backgroundColor = kSubViewBackgroundColor;
    return view;
    
}

+(UILabel *)creatLableWithFrame:(CGRect )rect
                           font:(UIFont*)font
                  textAlignment:(NSTextAlignment)textAlignment
                      textColor:(UIColor *)textColor
{
    
    UILabel *lable = [[UILabel alloc]initWithFrame:rect];
    lable.backgroundColor = [UIColor clearColor];
    lable.font = font;
    lable.textAlignment = textAlignment;
    lable.textColor = textColor;
    return lable;
    
}

+(UIButton *)creatButtonWithFrame:(CGRect )rect
                             font:(UIFont*)font
                            title:(NSString *)title
                       titleColor:(UIColor *)titleColor
                    bgNormalImage:(UIImage *)bgNormal
                bgHightLightImage:(UIImage *)bgHighLight{
    
    UIButton *tempButton = [[UIButton alloc]initWithFrame:rect];
    tempButton.titleLabel.font = font;
    [tempButton setTitle:title forState:UIControlStateNormal];
    [tempButton setTitleColor:titleColor forState:UIControlStateNormal];
    [tempButton setBackgroundImage:bgNormal forState:UIControlStateNormal];
    [tempButton setBackgroundImage:bgHighLight forState:UIControlStateHighlighted];
    
    return tempButton;
    
}

+(UIView *)creatBadgeViewWithPoint:(CGPoint)point badgeValue:(NSString *)badgeValue{//ff3b30
    
    CGSize size = [badgeValue getStringSizeWithFont:kSystemFont(12.0f)];
    CGFloat width = size.width+5;
    CGFloat height = size.height+5;
    CGRect badgeRect = CGRectMake(0, 0, width>height?width:height, height);
    UILabel *badgeLabel = [UIViewUtil creatLableWithFrame:badgeRect font:kSystemFont(12.0f) textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor]];
    badgeLabel.center = point;
    badgeLabel.layer.cornerRadius = (size.height+5)/2;
    badgeLabel.layer.masksToBounds = YES;
    badgeLabel.backgroundColor = RGB_COLOR_WITH_0x(0xff3b30);
    badgeLabel.text = badgeValue;
    badgeLabel.hidden = ![badgeValue boolValue];
    return badgeLabel;
    
}

@end
