//
//  NSString+Validate.m
//  PerfectDoc
//
//  Created by 赵洋 on 15/4/1.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import "NSString+Validate.h"

@implementation NSString (Validate)
-(BOOL)validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
   
    
    return [emailTest evaluateWithObject:self];
}

-(BOOL)validateMobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    //手机号以13， 15，18，17，14开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(14[0,0-9])|(17[0,0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

-(NSString *)changeTelephone{
    if (self.length != 11) {
        return self;
    }

    NSMutableString *String = [[NSMutableString alloc] initWithString:self];
    [String replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    return String;
}

@end
