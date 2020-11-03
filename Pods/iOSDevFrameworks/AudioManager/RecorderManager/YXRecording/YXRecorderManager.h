//
//  YXRecorderManager.h
//  OnlineHosptial
//
//  Created by 张良玉 on 2019/4/20.
//  Copyright © 2019年 zhangliangyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "YXRecordingDelegate.h"
#import "lame.h"
#import "ConvertAudioFile.h"

#define isValidString(string)               (string && [string isEqualToString:@""] == NO)
#define ETRECORD_RATE 16000
#define ENCODE_MP3    1

#define TEMPORARY_PATH [NSTemporaryDirectory() stringByAppendingPathComponent:@"Audio"]

@interface YXRecorderManager : NSObject
+(instancetype)shareManager;
-(void)destroyManager;

@property (nonatomic, weak)  id<YXRecordingDelegate> delegate;
@property (nonatomic ) int timeoutTime;
@property (nonatomic ) BOOL isGranted;

// 录音文件绝对路径
@property (nonatomic, copy) NSString *cafFilePath;
@property (nonatomic, copy) NSString *mp3FilePath;
// UI刷新监听器
@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, strong) NSTimer *timerTimeout;
@property (nonatomic ) NSTimeInterval timeInterval;
@property (nonatomic ) BOOL idleTimerDisabled;
@property (nonatomic ) BOOL isRecording;

-(BOOL)destoryTimer;

-(void)cleanCafFile;
-(void)cleanMp3File;

-(void)startRecording;
-(void)stopRecording;
-(void)cancelRecording;

-(void)startConvertToMp3;
-(void)stopConvertToMp3;
-(void)cancelConvertToMp3;

-(void)timerStart;
-(void)timerContinue;
-(void)timerPause;
-(void)timerStop;

-(void)isHasRecordingGranted:(void(^)(BOOL isGranted))isGranted;
@end

