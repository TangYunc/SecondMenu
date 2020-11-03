//
//  NSString+removeSpaceAndEnter.m
//  PerfectDoc
//
//  Created by 赵洋 on 15/6/16.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import "NSString+removeSpaceAndEnter.h"

@implementation NSString (removeSpaceAndEnter)
+(NSString *)stringRemoveSpaceAndEnterWith:(NSString *)string{
    string= [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    string =[string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string =[string stringByReplacingOccurrencesOfString:@"/r" withString:@""];
    string=[string stringByReplacingOccurrencesOfString:@"'/n'" withString:@""];
    return string;
}
+(BOOL)validateStringWithString:(NSString *)string{
    if (string==nil||string.length==0) {
        return NO;
    }
    string= [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *text1 =[string stringByReplacingOccurrencesOfString:@" " withString:@""];
    text1 =[text1 stringByReplacingOccurrencesOfString:@"/r" withString:@""];
    NSString *finalText=[text1 stringByReplacingOccurrencesOfString:@"'/n'" withString:@""];
    
    if (finalText.length==0) {
        return NO;
    }else{
        return  YES;
    }
}
-(NSString *)stringRemoveChinaInputUnicode{
    unichar ch[1]={0x2006};
    NSString *unicode=[NSString stringWithCharacters:ch length:1];
    NSString *keyword=[self stringByReplacingOccurrencesOfString:unicode withString:@""];
    return keyword;
}
@end
