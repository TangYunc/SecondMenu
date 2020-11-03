//
//  NSData+GZip.h
//  FXBEST
//
//  Created by Michael on 16/6/23.
//  Copyright © 2016年 51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (GZip)

// 压缩
+ (NSData *)compressedDataWithData:(NSData*)data;

// 解压缩
+ (NSData *)gzipInflate:(NSData*)data;

@end
