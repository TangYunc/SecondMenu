//
//  NSData+GZip.m
//  FXBEST
//
//  Created by Michael on 16/6/23.
//  Copyright © 2016年 51fanxing. All rights reserved.
//

#import "NSData+GZip.h"
#import <zlib.h>

@implementation NSData (GZip)

// 压缩
+ (NSData *)compressedDataWithData:(NSData*)data
{
    unsigned long compressedLength = compressBound(data.length);
    unsigned char* compressedBytes = (unsigned char*) malloc(compressedLength);
    
    if (compressedBytes != NULL && compress(compressedBytes, &compressedLength, data.bytes, data.length) == Z_OK) {
        char* resizedCompressedBytes = realloc(compressedBytes, compressedLength);
        if (resizedCompressedBytes != NULL) {
            return [NSData dataWithBytesNoCopy: resizedCompressedBytes length: compressedLength freeWhenDone: YES];
        } else {
            return [NSData dataWithBytesNoCopy: compressedBytes length: compressedLength freeWhenDone: YES];
        }
    } else {
        free(compressedBytes);
        return nil;
    }
}

// 解压缩
+ (NSData *)gzipInflate:(NSData*)data
{
    if ([data length] == 0) return data;
    
    unsigned full_length = [data length];
    unsigned half_length = [data length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[data bytes];
    strm.avail_in = [data length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit2(&strm, (15+32)) != Z_OK)
        return nil;
    
    while (!done)
    {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy: half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = [decompressed length] - strm.total_out;
        
        // Inflate another chunk.
        status = inflate (&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END)
            done = YES;
        else if (status != Z_OK)
            break;
    }
    if (inflateEnd (&strm) != Z_OK)
        return nil;
    
    // Set real length.
    if (done)
    {
        [decompressed setLength: strm.total_out];
        return [NSData dataWithData: decompressed];
    }
    else return nil;
}


@end
