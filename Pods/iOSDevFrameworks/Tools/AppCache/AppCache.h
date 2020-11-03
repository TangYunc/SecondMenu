//
//  AppCache.h
//  OneDay
//
//  Created by Liu Rujia on 13-5-18.
//  Copyright (c) 2013年 Eryiju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppCache : NSObject

+(AppCache*) sharedInstance;

+(NSString*) cachePath:(NSString*) type;

-(void) setStringCache:(NSString*) content forURL:(NSString*) url;
-(void) stringCacheForURL:(NSString*) url done:(void (^)(NSString* str)) doneBlock;

-(void) setImageCache:(UIImage*) image froURL:(NSString*) url;
-(void) imageCacheForURL:(NSString*) url done:( void(^)(UIImage *image)) doneBlock;

/**
 * Clear all memory cached images
 */
- (void)clearMemory;

/**
 * Clear all disk cached images
 */
- (void)clearDisk;

/**
 * Remove all expired cached image from disk
 */
- (void)cleanDisk;

/**
 * Get the size used by the disk cache
 */
- (int)getSize;

/**
 * Get the number of images in the disk cache
 */
- (int)getDiskCount;
@end
