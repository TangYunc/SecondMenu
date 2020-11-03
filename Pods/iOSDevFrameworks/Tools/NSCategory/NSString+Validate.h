//
//  NSString+Validate.h
//  PerfectDoc
//
//  Created by 赵洋 on 15/4/1.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)
/**
 *  手机号码的正则校验
 *
 */
-(BOOL) validateMobile;
/**
 *  邮箱的正则校验
 *
 *
 */
- (BOOL) validateEmail;

/**
 电话号的星号加密

 电话号码:12344556667(string:123****6667)
 @return 返回加密的电话号码
 */
-(NSString *)changeTelephone;
@end
