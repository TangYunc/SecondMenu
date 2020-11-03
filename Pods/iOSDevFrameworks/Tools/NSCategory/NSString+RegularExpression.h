//
//  NSString+RegularExpression.h
//  Doctor
//
//  Created by 赵洋 on 15/11/13.
//  Copyright © 2015年 YX. All rights reserved.
//
//  正则匹配的分类

#import <Foundation/Foundation.h>


extern NSString * const RegularResultRange;
extern NSString * const RegularResultString;

@interface NSString (RegularExpression)

/** 正则匹配的结果*/
-(NSArray<NSDictionary *> *)stringWithRegularExpression:(NSString *)pattern;

/** 正则匹配不成功的所有的字符串*/
-(NSArray<NSDictionary *> *)stringWithOutRegularExpression:(NSString *)pattern;
@end
