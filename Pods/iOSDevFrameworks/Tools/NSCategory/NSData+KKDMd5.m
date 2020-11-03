//
//  NSData+KKDMd5.m
//  KKDictionary
//
//  Created by KungJack on 1/12/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import "NSData+KKDMd5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (KKDMd5)

- (NSString *) md5String{
    
    if(self == nil || [self length] == 0)
        return nil;
    
//    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5([self bytes], (CC_LONG)[self length], outputBuffer);
    
    //    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH];
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
    
}

@end
