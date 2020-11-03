//
//  NSString+URLEncoded.m
//  Doctor
//
//  Created by Fa Kong on 15/8/7.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import "NSString+URLEncoded.h"

@implementation NSString (URLEncoded)
- (NSString *)URLEncodedString{
    NSString *charactersToEscape = @"#[]@!$'()*+,;\"<>%{}|^~`";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedString = [[self description] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedString;
}

- (NSString*)URLDecodedString
{
    return [self stringByRemovingPercentEncoding];
}

@end
