//
//  AppCache.m
//  OneDay
//
//  Created by Liu Rujia on 13-5-18.
//  Copyright (c) 2013年 Eryiju. All rights reserved.
//

#import "AppCache.h"
#import <CommonCrypto/CommonDigest.h>

@interface AppCache() {
    
}
@property (strong, nonatomic) dispatch_queue_t ioQueue;
@property (nonatomic, strong) NSString *textCachePath;
@property (nonatomic, strong) NSString *imageCachePath;
@property (nonatomic, strong) NSCache *memCache;
@property (assign, nonatomic) NSInteger maxCacheAge;

@end
@implementation AppCache
static AppCache *sharedInstance;
static const NSInteger kDefaultCacheMaxCacheAge = 60 * 60 * 24 * 365; // 1 year
+(AppCache*) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AppCache alloc] init];
    });
    return sharedInstance;
}

+(NSString*) cachePath:(NSString *)type {
    NSString* cachePath = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if ([type isEqualToString:@"image"]) {
        cachePath = [paths[0] stringByAppendingPathComponent:@"image"];
    } else {
        cachePath = [paths[0] stringByAppendingPathComponent:@"text"];
        
    }
    return cachePath;
}

- (id) init {
    self = [super init];
    if (self) {
        // Create IO serial queue
        _ioQueue = dispatch_queue_create("com.qeyj.AppCache", DISPATCH_QUEUE_SERIAL);
        _memCache = [[NSCache alloc] init];
        _textCachePath = [[self class] cachePath:@"text"];
        _imageCachePath = [[self class] cachePath:@"image"];
        _maxCacheAge = kDefaultCacheMaxCacheAge;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cleanDisk)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //dispatch_release(_ioQueue);
    _ioQueue = nil;
}
- (NSString *)cachePathForKey:(NSString *)key withCacheDir:(NSString*) dir;
{
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return [dir stringByAppendingPathComponent:filename];
}

- (void) setImageCache:(UIImage *)image froURL:(NSString *)url {
    if (!image || !url)
    {
        return;
    }
    [self.memCache setObject:image forKey:url cost:image.size.height * image.size.width * image.scale];
    dispatch_async(self.ioQueue, ^
                   {
                       NSData *data = UIImageJPEGRepresentation(image, (CGFloat)1.0);

                       if (data)
                       {
                           // Can't use defaultManager another thread
                           NSFileManager *fileManager = NSFileManager.new;
                           
                           if (![fileManager fileExistsAtPath:_imageCachePath])
                           {
                               [fileManager createDirectoryAtPath:_imageCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
                           }
                           
                           [fileManager createFileAtPath:[self cachePathForKey:url withCacheDir:_imageCachePath] contents:data attributes:nil];
                        }
                });

}

- (void) setStringCache:(NSString *)content forURL:(NSString *)url {
    if (!content || !url)
        return;
    [self.memCache setObject:content forKey:url];
    dispatch_async(self.ioQueue, ^{
        NSFileManager *fileManager = NSFileManager.new;
        if (![fileManager fileExistsAtPath:_textCachePath])
        {
            [fileManager createDirectoryAtPath:_textCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
        }
        NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
        [fileManager createFileAtPath:[self cachePathForKey:url withCacheDir:_textCachePath] contents:data attributes:nil];
    });
}
- (void) imageCacheForURL:(NSString *)url done:(void (^)(UIImage *))doneBlock {
    if (!doneBlock) return;
    
    if (!url)
    {
        doneBlock(nil);
        return;
    }
    
    // First check the in-memory cache...
    UIImage *image = [self.memCache objectForKey:url];
    if (image)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            doneBlock(image);
        });
        return;
    }
    
    dispatch_async(self.ioQueue, ^
                   {
                       NSData *data = [NSData dataWithContentsOfFile:[self cachePathForKey:url withCacheDir:_imageCachePath]];
                       UIImage *diskImage = [[UIImage alloc] initWithData: data];
                       
                       if (diskImage)
                       {
                           [self.memCache setObject:diskImage forKey:url cost:image.size.height * image.size.width * image.scale];
                       }
                       
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          doneBlock(diskImage);
                                      });
                   });
}

- (void) stringCacheForURL:(NSString *)url done:(void (^)(NSString *))doneBlock {
    if (!doneBlock) {
        return;
    }
    if (!url) {
        doneBlock(nil);
        return;
    }
    NSString *string = [self.memCache objectForKey:url];
    if (string) {
        doneBlock(string);
        return;
    }
    dispatch_async(self.ioQueue, ^{
        NSData *data = [NSData dataWithContentsOfFile:[self cachePathForKey:url withCacheDir:_textCachePath]];
        NSString *string;
        if (data) {
            string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [self.memCache setObject:string forKey:url];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            doneBlock(string);
        });
    });
}
- (void)clearMemory
{
    [self.memCache removeAllObjects];
}

- (void)clearDisk
{
    dispatch_async(self.ioQueue, ^
                   {
                       [[NSFileManager defaultManager] removeItemAtPath:self.imageCachePath error:nil];
                       [[NSFileManager defaultManager] createDirectoryAtPath:self.imageCachePath
                                                 withIntermediateDirectories:YES
                                                                  attributes:nil
                                                                       error:NULL];
                       [[NSFileManager defaultManager] removeItemAtPath:self.textCachePath error:nil];
                       [[NSFileManager defaultManager] createDirectoryAtPath:self.textCachePath
                                                 withIntermediateDirectories:YES
                                                                  attributes:nil
                                                                       error:NULL];
                       
//                       NSString *bgMusicPath = [[UserConfig sharedUserConfig] backgoundMusicPath];
//                       [[NSFileManager defaultManager] removeItemAtPath:bgMusicPath error:nil];
//                       [[NSFileManager defaultManager] createDirectoryAtPath:bgMusicPath
//                                                 withIntermediateDirectories:YES
//                                                                  attributes:nil
//                                                                       error:NULL];
                   });
}

- (void)cleanDisk
{
    dispatch_async(self.ioQueue, ^
                   {
                       NSArray *cachePathes = @[self.imageCachePath, self.textCachePath];
                       for (int i = 0; i < cachePathes.count; i++) {
                           NSString *cachePath = [cachePathes objectAtIndex:i];
                           NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:-self.maxCacheAge];
                           NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:cachePath];
                           for (NSString *fileName in fileEnumerator)
                           {
                               NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
                               NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
                               if ([[[attrs fileModificationDate] laterDate:expirationDate] isEqualToDate:expirationDate])
                               {
                                   [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                               }
                           }
                       }
                   });
}

-(int)getSize
{
    int size = 0;
    NSArray *cachePathes = @[self.imageCachePath, self.textCachePath/*, [[UserConfig sharedUserConfig] backgoundMusicPath]*/];
    for (int i = 0; i < cachePathes.count; i++) {
        NSString *cachePath = [cachePathes objectAtIndex:i];
        NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:cachePath];
        for (NSString *fileName in fileEnumerator)
        {
            NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
            NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            size += [attrs fileSize];
        }
    }
    return size;
}

- (int)getDiskCount
{
    int count = 0;
    NSArray *cachePathes = @[self.imageCachePath, self.textCachePath/*, [[UserConfig sharedUserConfig] backgoundMusicPath]*/];
    for (int i = 0; i < cachePathes.count; i++) {
        NSString *cachePath = [cachePathes objectAtIndex:i];
        NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:cachePath];
        for (NSString *fileName in fileEnumerator)
        {
            count += 1;
        }
    }
    return count;
}

@end
