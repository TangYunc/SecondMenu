//
//  ConvertAudioFile.m
//  Expert
//
//  Created by xuxiwen on 2017/3/21.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

#import "ConvertAudioFile.h"
#import "lame.h"

@interface ConvertAudioFile ()
@property (nonatomic, assign) BOOL isStopConvert;
@property (nonatomic, assign) BOOL isCancelConvert;
@end
static ConvertAudioFile *instance = nil;
@implementation ConvertAudioFile

/**
 get instance obj
 
 @return ConvertAudioFile instance
 */
+ (instancetype)sharedInstance {
    if (!instance) {
        instance = [[ConvertAudioFile alloc] init];
    }
    return instance;
}

+ (void)destroyInstance{
    if (!instance.isStopConvert) {
        [instance stopConvert];
    }
    instance = nil;
}

/**
 ConvertMp3
 
 @param cafFilePath caf FilePath
 @param mp3FilePath mp3 FilePath
 @param sampleRate sampleRate (same record sampleRate set)
 @param callback callback result
 */
- (void)convertToMp3WithCafFilePath:(NSString *)cafFilePath
                        mp3FilePath:(NSString *)mp3FilePath
                         sampleRate:(int)sampleRate
                           callback:(void(^)(BOOL result))callback
{
    
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        weakself.isStopConvert = NO;
        weakself.isCancelConvert = NO;
        @try {
            
            int read, write;
            
            FILE *pcm =fopen([cafFilePath cStringUsingEncoding:NSASCIIStringEncoding], "rb");
            FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:NSASCIIStringEncoding], "wb");
            const int channels = 1;
            
            const int PCM_SIZE = sampleRate * 16 * 0.05 * channels;
            const int brate = 32;
            const int MP3_SIZE = sampleRate * brate * 0.05;
            short int pcm_buffer[PCM_SIZE * channels];
            unsigned char mp3_buffer[MP3_SIZE];
            
            lame_t lame = lame_init();
            lame_set_in_samplerate(lame, sampleRate);
            lame_set_out_samplerate(lame, sampleRate);
            lame_set_num_channels(lame,channels);
            lame_set_quality(lame, 5);
            lame_set_brate(lame, brate);
            lame_init_params(lame);
            
            long curpos;
            BOOL isSkipPCMHeader = NO;
            
            do {
                curpos = ftell(pcm);
                long startPos = ftell(pcm);
                fseek(pcm, 0, SEEK_END);
                long endPos = ftell(pcm);
                long length = endPos - startPos;
                fseek(pcm, curpos, SEEK_SET);
                
                if (length > PCM_SIZE * channels * sizeof(short int)) {
                    
                    if (!isSkipPCMHeader) {
                        fseek(pcm, 4 * 1024, SEEK_CUR);
                        isSkipPCMHeader = YES;
                    }
                    
                    read = (int)fread(pcm_buffer, channels * sizeof(short int), PCM_SIZE, pcm);
                    write = lame_encode_buffer(lame, pcm_buffer, NULL, read, mp3_buffer, MP3_SIZE);
                    fwrite(mp3_buffer, write, 1, mp3);
                } else {
                    [NSThread sleepForTimeInterval:0.05];
                }
                
            } while (! weakself.isStopConvert && !weakself.isCancelConvert);
            
            read = (int)fread(pcm_buffer, channels * sizeof(short int), PCM_SIZE, pcm);
            write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            
            lame_mp3_tags_fid(lame, mp3);
            
            lame_close(lame);
            fclose(mp3);
            fclose(pcm);
        }
        @catch (NSException *exception) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (callback) {
                    callback(NO);
                }
            });
        }
        @finally {
            if (weakself.isCancelConvert) {
                return ;
            }
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:cafFilePath]) {
                if ([fileManager removeItemAtPath:cafFilePath error:nil]) {
                    //                    NSLog(@"cafFile删除成功");
                }else {
                    NSLog(@"cafFile删除失败");
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (callback) {
                    callback(YES);
                }
            });
        }
    });
}

/**
 send end record signal
 */
- (void)stopConvert {
    self.isStopConvert = YES;
}

- (void)cancelConvert {
    self.isCancelConvert = YES;
}

#pragma mark - ----------------------------------

// 这是录完再转码的方法, 如果录音时间比较长的话,会要等待几秒...
// Use this FUNC convert to mp3 after record

+ (void)convertToMp3WithCafFilePath:(NSString *)cafFilePath
                        mp3FilePath:(NSString *)mp3FilePath
                         sampleRate:(int)sampleRate
                           callback:(void(^)(BOOL result))callback
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @try {
            int read, write;
            
            FILE *pcm = fopen([cafFilePath cStringUsingEncoding:NSASCIIStringEncoding], "rb");
            FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:NSASCIIStringEncoding], "wb");
            const int channels = 1;
            
            const int PCM_SIZE = sampleRate * 16 * 0.05 * channels;
            const int brate = 32;
            const int MP3_SIZE = sampleRate * brate * 0.05;
            short int pcm_buffer[PCM_SIZE * channels];
            unsigned char mp3_buffer[MP3_SIZE];
            
            lame_t lame = lame_init();
            lame_set_in_samplerate(lame, sampleRate);
            lame_set_out_samplerate(lame, sampleRate);
            lame_set_num_channels(lame,channels);
            lame_set_brate(lame, brate);
            lame_set_quality(lame, 5);
            lame_init_params(lame);
            
            do {
                
                read = (int)fread(pcm_buffer, channels*sizeof(short int), PCM_SIZE, pcm);
                if (read == 0) {
                    write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
                    
                } else {
                    write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
                }
                
                fwrite(mp3_buffer, write, 1, mp3);
                
            } while (read != 0);
            
            lame_mp3_tags_fid(lame, mp3);
            
            lame_close(lame);
            fclose(mp3);
            fclose(pcm);
        }
        @catch (NSException *exception) {
            // MP3生成a失败
            dispatch_async(dispatch_get_main_queue(), ^{
                if (callback) {
                    callback(NO);
                }
            });
        }
        @finally {
            // MP3生成成功
            dispatch_async(dispatch_get_main_queue(), ^{
                if (callback) {
                    callback(YES);
                }
            });
        }
    });
}

@end
