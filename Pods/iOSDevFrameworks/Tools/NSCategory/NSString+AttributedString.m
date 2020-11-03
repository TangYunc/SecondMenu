//
//  NSString+AttributedString.m
//  Doctor
//
//  Created by 张良玉 on 16/7/22.
//  Copyright © 2016年 YX. All rights reserved.
//

#import "NSString+AttributedString.h"

@implementation NSString (AttributedString)

-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color{
    return [self setAttributedWithIdentifyString:identifyString color:color font:nil];
}

-(NSMutableAttributedString *)
setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing{
    return [self setAttributedWithIdentifyString:identifyString color:color lineSpacing:lineSpacing alignment:NSTextAlignmentLeft];
}

-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment )alignment{
    if (!self&&!identifyString) {
        return nil;
    }
    NSString *panString = self?self:identifyString;
    identifyString = identifyString?identifyString:@"";
    
    NSRange range = [panString rangeOfString:identifyString];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:panString];
    if (color) {
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    if (lineSpacing) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paraStyle.lineSpacing = lineSpacing;
        paraStyle.alignment = alignment;
        [attributedStr addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, self.length)];
    }
    return attributedStr;
}

-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString font:(UIFont *)font{
    return [self setAttributedWithIdentifyString:identifyString color:nil font:font];
}
-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color font:(UIFont *)font{
    if (!self&&!identifyString) {
        return nil;
    }
    NSString *panString = self?self:identifyString;
    identifyString = identifyString?identifyString:@"";
    
    NSRange range = [panString rangeOfString:identifyString];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:panString];
    if (font) {
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    if (color) {
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    
    return attributedStr;

}

- (NSMutableAttributedString *)setAttributedWithIdentifyStringArray:(NSArray *)identifyStringArray color:(UIColor *)color font:(UIFont *)font{
    return [self setAttributedWithIdentifyStringArray:identifyStringArray color:color font:font lineSpacing:0];
}

-(NSMutableAttributedString *)setAttributedWithIdentifyStringArray:(NSArray *)identifyStringArray color:(UIColor *)color font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing{
    return [self setAttributedWithIdentifyStringArray:identifyStringArray color:color font:font lineSpacing:lineSpacing alignment:NSTextAlignmentLeft];
}

-(NSMutableAttributedString *)setAttributedWithIdentifyStringArray:(NSArray *)identifyStringArray color:(UIColor *)color font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment )alignment{
    if (!self&&!identifyStringArray) {
        return nil;
    }
    if (!identifyStringArray.count) {
        return nil;
    }
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    for (NSString *identifyString in identifyStringArray) {
        NSArray *rangesArray = [NSString getRangeStrArrWithInitialText:self regexString:identifyString];
        if (rangesArray.count>0) {
            for (NSValue *rangeValue in rangesArray) {
                NSRange range = [rangeValue rangeValue];
                if (font) {
                    [attributedStr addAttribute:NSFontAttributeName value:font range:range];
                }
                if (color) {
                    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
                }
            }
        }
    }
    
    if (lineSpacing) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paraStyle.lineSpacing = lineSpacing;
        paraStyle.alignment = alignment?alignment:NSTextAlignmentLeft;
        [attributedStr addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, self.length)];
    }
    return attributedStr;
}

-(NSMutableAttributedString *)setAttributedWithHtmlString{
    return [[NSMutableAttributedString alloc]initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
}

+(NSDictionary *)getAttributeWithlineSpacing:(CGFloat)lineSpacing font:(UIFont *)font{
    return [self getAttributeWithlineSpacing:lineSpacing alignment:NSTextAlignmentLeft font:font];
}

+(NSDictionary *)getAttributeWithlineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment )alignment font:(UIFont *)font{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = alignment;
    //设置行间距
    paraStyle.lineSpacing = lineSpacing;
    //    paraStyle.hyphenationFactor = 1.0;
    //    paraStyle.firstLineHeadIndent = 0.0;
    //    paraStyle.paragraphSpacingBefore = 0.0;
    //    paraStyle.headIndent = 0;
    //    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle
                          };
    return dic;
}

+ (NSArray<NSValue *> *)getRangeStrArrWithInitialText:(NSString*)initialText regexString:(NSString*)regexString{
    /*
     备注：1、array中存的是N个字典，每个字典中存了两个值：子串、子串位置，结构如下图
          2、字典中的range是NSValue，需要转换成NSRange使用
     (
     {
     subString = "我是TYC要改变的字符串";
     subStringRange = "NSRange: {6, 20}";
     }
     ）
     */
    NSMutableArray *tempMArr = [NSMutableArray array];
    [self searchAllTextRangeWithInitialArray:tempMArr initialText:initialText regexString:regexString];
    NSMutableArray *resultMArr = [NSMutableArray array];
    for (NSDictionary *tempDic in tempMArr) {
        NSValue *rangeValue = tempDic[@"subStringRange"];
        [resultMArr addObject:rangeValue];
    }
    return resultMArr;
}

+ (void)searchAllTextRangeWithInitialArray:(NSMutableArray*)initialArray initialText:(NSString*)initialText regexString:(NSString*)regexString{
    //思路：通过循环，搜索到第一个之后，先把第一个的信息打包成字典存进数组，再次搜索，把上次的信息字典取出来，根据上一个位置信息，把主串截取为在那之后的串，记录新串的头字符在主串中的位置，在新串中再次搜索，搜索到的range的location需要加上新串的头字符在主串中的位置，打包信息存进数组，再次搜索，直到搜索不到信息。
    if (initialArray.count == 0) {//如果此时传入的array是空
        NSRange range = [initialText rangeOfString:regexString options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            //包装字典，存进数组
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"subString"] = [initialText substringWithRange:range];
            dict[@"subStringRange"] = [NSValue valueWithRange:range];
            [initialArray addObject:dict];
            //递归调用
            [self searchAllTextRangeWithInitialArray:initialArray initialText:initialText regexString:regexString];
        }else{
                return;
        }
    }else{//如果数组中已经有值了
        //1、取数组中最后一个字典，记录后串在原串中的起始位置，把该串及其之前的串去掉生成新串
        NSMutableDictionary *lastDict = [initialArray lastObject];
        NSRange lastRange = [lastDict[@"subStringRange"] rangeValue];
        NSUInteger newStringBeginLocation = lastRange.location +  lastRange.length;
        NSString *newString = [initialText substringFromIndex:newStringBeginLocation];
        //2、在新串中找符合的子串，如果找到，包装存进数组
        NSRange rangeInNewString = [newString rangeOfString:regexString options:NSRegularExpressionSearch];
        if(rangeInNewString.location != NSNotFound) {
            //包装字典，存进数组
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"subString"] = [newString substringWithRange:rangeInNewString];
            NSRange rangeIninitialText = NSMakeRange(rangeInNewString.location + newStringBeginLocation, rangeInNewString.length);
                dict[@"subStringRange"] = [NSValue valueWithRange:rangeIninitialText];
            [initialArray addObject:dict];
            //递归调用
            [self searchAllTextRangeWithInitialArray:initialArray initialText:initialText regexString:regexString];
        }else{
            return;
        }
    }
}

/**
 数组转json字符串
 
 @param array 要转换的数组
 @return json字符串
 */
+ (NSString *)arrayToJSONString:(NSArray *)array

{
    NSError *error = nil;
    //    NSMutableArray *muArray = [NSMutableArray array];
    //    for (NSString *userId in array) {
    //        [muArray addObject:[NSString stringWithFormat:@"\"%@\"", userId]];
    //    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    NSLog(@"json array is: %@", jsonResult);
    return jsonResult;
}

/**
 json字符串转数组或字典等

 @param json json字符串
 @return 转换的数组或字典等
 */
+(id)jsonToObject:(NSString *)json{
    //string转data
    NSData * jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    //json解析
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return obj;
}

@end
