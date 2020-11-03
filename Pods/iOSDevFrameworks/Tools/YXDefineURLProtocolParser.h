//
//  YXDefineURLProtocolParser.h
//  PerfectDoc
//
//  Created by Fa Kong on 15/12/29.
//  Copyright © 2015年 YX. All rights reserved.
//

#import <Foundation/Foundation.h>
//NSURL
@interface YXDefineURLProtocolParser : NSObject

-(nullable id)initWithUrlString:(nullable NSString *)urlString;

/**
 *  协议名 e.g. pd://home?v=1  中的pd
 */
@property(nullable, readonly, copy)NSString *scheme;
/**
 *  域名   e.g. pd://home?v=1  中的home
 */
@property (nullable, readonly, copy) NSString *host;
/**
 *  ？前边的  e.g. pd://home?v=1  中的pd://home
 */
@property(nullable, readonly, copy)NSString *baseUrl;
/**
 *  全部链接 e.g. pd://home?v=1  中的pd://home?v=1
 */
@property (nullable, readonly, copy) NSString *fullPath;
/**
 *  参数串  e.g. pd://home?v=1  中的v=1
 */
@property (nullable, readonly, copy) NSString *parameterString;
/**
 *  参数字典 e.g. pd://home?v=1  中的  @{@"v":@"1"}
 */
@property (nullable, readonly, strong) NSDictionary *parameterDictionary;

@end
