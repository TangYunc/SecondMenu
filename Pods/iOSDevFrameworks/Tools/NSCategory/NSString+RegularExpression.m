//
//  NSString+RegularExpression.m
//  Doctor
//
//  Created by 赵洋 on 15/11/13.
//  Copyright © 2015年 YX. All rights reserved.
//

#import "NSString+RegularExpression.h"
#import <RegexKitLite-NoWarning/RegexKitLite.h>

NSString *const RegularResultRange=@"RegularResultRange";
NSString * const RegularResultString=@"RegularResultString";
@implementation NSString (RegularExpression)
-(NSArray<NSDictionary *> *)stringWithRegularExpression:(NSString *)pattern{

    
    
    NSMutableArray *array=[NSMutableArray array];
    [self enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        NSDictionary *dict=@{RegularResultRange:[NSValue valueWithRange:*capturedRanges],RegularResultString:*capturedStrings};
        [array addObject:dict];
    }];
    return array.copy;

}
-(NSArray<NSDictionary *> *)stringWithOutRegularExpression:(NSString *)pattern{
    NSMutableArray *array=[NSMutableArray array];
    [self enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        NSDictionary *dict=@{RegularResultRange:[NSValue valueWithRange:*capturedRanges],RegularResultString:*capturedStrings};
        [array addObject:dict];
    }];
    return array.copy;
}

@end
