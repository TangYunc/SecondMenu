//
//  NSString+AttributedString.h
//  Doctor
//
//  Created by 张良玉 on 16/7/22.
//  Copyright © 2016年 YX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AttributedString)
-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color;
-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing;
-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment )alignment;
-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString font:(UIFont *)font;
-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color font:(UIFont *)font;

// 传递一个字符串数组，可以染不同的颜色，后期有需要可以把 color 和 font 也已数组的形式传递，配对使用
-(NSMutableAttributedString *)setAttributedWithIdentifyStringArray:(NSArray *)identifyStringArray color:(UIColor *)color font:(UIFont *)font;
-(NSMutableAttributedString *)setAttributedWithIdentifyStringArray:(NSArray *)identifyStringArray color:(UIColor *)color font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;
-(NSMutableAttributedString *)setAttributedWithIdentifyStringArray:(NSArray *)identifyStringArray color:(UIColor *)color font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment )alignment;

/// 通过HtmlString设置AttributedString
-(NSMutableAttributedString *)setAttributedWithHtmlString;

// 获取行间距类型
+(NSDictionary *)getAttributeWithlineSpacing:(CGFloat)lineSpacing font:(UIFont *)font;
// 获取行间距类型
+(NSDictionary *)getAttributeWithlineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment )alignment font:(UIFont *)font;

//获取字符串中多个相同字符串的所有range
+ (NSArray<NSValue *> *)getRangeStrArrWithInitialText:(NSString*)initialText regexString:(NSString*)regexString;

//数组转json字符串
+ (NSString *)arrayToJSONString:(NSArray *)array;

//json字符串转数组或字典等
+(id)jsonToObject:(NSString *)json;
@end
