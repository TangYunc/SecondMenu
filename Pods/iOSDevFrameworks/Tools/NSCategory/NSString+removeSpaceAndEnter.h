//
//  NSString+removeSpaceAndEnter.h
//  PerfectDoc
//
//  Created by 赵洋 on 15/6/16.
//  Copyright (c) 2015年 YX. All rights reserved.
//
//移除空格和回车 以及特殊的字符串
#import <Foundation/Foundation.h>

@interface NSString (removeSpaceAndEnter)
+(NSString*)stringRemoveSpaceAndEnterWith:(NSString *)string;

+(BOOL)validateStringWithString:(NSString *)string;

/** 移除输入中文的时候两个字母之间的字符串*/
-(NSString *)stringRemoveChinaInputUnicode;
@end
