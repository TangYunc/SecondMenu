//
//  YXRecorderManager.m
//  OnlineHosptial
//
//  Created by 张良玉 on 2019/4/20.
//  Copyright © 2019年 zhangliangyu. All rights reserved.
//

#import "YXRecorderManager.h"
#import "YXAlertView.h"
#import "KKDToolsDefine.h"

@interface YXRecorderManager ()<YXAlertViewDelegate>

@end
@implementation YXRecorderManager
+(instancetype)shareManager{
    id _recorderManager = [[[self class] alloc]init];
    return _recorderManager;
}

-(void)destroyManager{
    [ConvertAudioFile destroyInstance];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setPath];
        self.timeInterval = 0;
        __weak typeof(self) weakSelf = self;
        [self isHasRecordingGranted:^(BOOL isGranted) {
            weakSelf.isGranted = isGranted;
        }];
    }
    return self;
}

-(void)setIdleTimerDisabled:(BOOL)idleTimerDisabled{
    [[UIApplication sharedApplication] setIdleTimerDisabled:idleTimerDisabled];
}

-(void)setPath{
    if (![[NSFileManager defaultManager]fileExistsAtPath:TEMPORARY_PATH]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:TEMPORARY_PATH withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *path = TEMPORARY_PATH;
    self.cafFilePath = [path stringByAppendingPathComponent:@"patient_education_audio.pcm"];
    self.mp3FilePath = [path stringByAppendingPathComponent:@"patient_education_audio.mp3"];
}

// 计时器get方法
- (NSTimer *)timer {
    if (!_timer) {
        self.timeInterval = 0;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(recordTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

-(void)recordTimer{
    self.timeInterval += 1;
    if ([self.delegate respondsToSelector:@selector(recordingTimeDidChange:)]) {
        [self.delegate recordingTimeDidChange:self.timeInterval];
    }
    if (self.timeInterval > (self.timeoutTime?self.timeoutTime:60)) {
        [self timeoutCheck];
    }
}

-(void) isHasRecordingGranted:(void(^)(BOOL isGranted))isGranted
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        AVAudioSessionRecordPermission permissionStatus = [[AVAudioSession sharedInstance] recordPermission];
        
        switch (permissionStatus) {
            case AVAudioSessionRecordPermissionUndetermined:{
                //第一次调用，是否允许麦克风弹框
                [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                    if (isGranted) {
                        isGranted(granted);
                    }
                }];
            }
                break;
            case AVAudioSessionRecordPermissionDenied:
            {
                //已经拒绝麦克风弹框
                [YXAlertView shareAlerViewWithTitle:@"" message:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风" tag:0 delegate:self cancelButtonTitle:@"知道了" otherButtonTitle:nil];
                if (isGranted) {
                    isGranted(NO);
                }
            }
                break;
            case AVAudioSessionRecordPermissionGranted:
            {
                //已经允许麦克风弹框
                if (isGranted) {
                    isGranted(YES);
                }
            }
                break;
            default:
                // this should not happen.. maybe throw an exception.
                break;
        }
    }else{
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    if (isGranted) {
                        isGranted(YES);
                    }
                }
                else {
                    [YXAlertView shareAlerViewWithTitle:@"" message:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风" tag:0 delegate:self cancelButtonTitle:@"知道了" otherButtonTitle:nil];
                    if (isGranted) {
                        isGranted(NO);
                    }
                }
            }];
        }
    }
}

-(BOOL)destoryTimer{
    [self timerStop];
    return YES;
}

- (void)cleanCafFile {
    if (isValidString(self.cafFilePath)) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:self.cafFilePath]) {
            if ([fileManager removeItemAtPath:self.cafFilePath error:nil]) {
                NSLog(@"cafFile删除成功");
            }else {
                NSLog(@"cafFile删除失败");
            }
        }
    }
}

- (void)cleanMp3File {
    if (isValidString(self.mp3FilePath)) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:self.mp3FilePath]) {
            if ([fileManager removeItemAtPath:self.mp3FilePath error:nil]) {
                NSLog(@"mp3File删除成功");
            }else {
                NSLog(@"mp3File删除失败");
            }
        }
    }
}


/**
 开始录制
 */
-(void)startRecording{
    
}

/**
 结束录制
 */
-(void)stopRecording{
    
}

/**
 清除录制
 */
-(void)cancelRecording{
    
}

/**
 开始转码
 */
-(void)startConvertToMp3{
    WS(weakSelf);
#if ENCODE_MP3
    [[ConvertAudioFile sharedInstance] convertToMp3WithCafFilePath:self.cafFilePath
                                                       mp3FilePath:self.mp3FilePath
                                                        sampleRate:ETRECORD_RATE
                                                          callback:^(BOOL result)
     {
         
         if (result) {
             if ([weakSelf.delegate respondsToSelector:@selector(recordingFinishedWithFileName:)]) {
                 [[weakSelf delegate] recordingFinishedWithFileName:weakSelf.mp3FilePath];
             }
         }else{
             if ([weakSelf.delegate respondsToSelector:@selector(recordingFailed:)]) {
                 [[weakSelf delegate] recordingFailed:@"mp3 file compression failed"];
             }
         }
     }];
#endif
}

-(void)fileConvertToMp3{
    [ConvertAudioFile convertToMp3WithCafFilePath:self.cafFilePath
                                      mp3FilePath:self.mp3FilePath
                                       sampleRate:ETRECORD_RATE
                                         callback:^(BOOL result)
    {
        
    }];
}

- (void)timeoutCheck {
    [self stopRecording];
    if ([self.delegate respondsToSelector:@selector(recordingTimeout)]) {
        [[self delegate] recordingTimeout];
    }
}

/**
 结束转码
 */
-(void)stopConvertToMp3{
#if ENCODE_MP3
    [[ConvertAudioFile sharedInstance] stopConvert];
#endif
}

-(void)cancelConvertToMp3{
    [[ConvertAudioFile sharedInstance] cancelConvert];
}

-(void)timerStart{
    [self.timer setFireDate:[NSDate dateWithTimeInterval:1 sinceDate:[NSDate date]]];
}

-(void)timerContinue{
    
    AVAudioPlayer* player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:self.cafFilePath] error:nil];
//    double duration = player.duration;
    float audioLength = player.duration;
    int audioLengthInt = (int)audioLength;
    
    [self.timer setFireDate:[NSDate dateWithTimeInterval:(1-(audioLength-audioLengthInt)) sinceDate:[NSDate date]]];
    player = nil;
}

-(void)timerPause{
    [self.timer setFireDate:[NSDate distantFuture]];
}

-(void)timerStop{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)dealloc{
    
}
@end
