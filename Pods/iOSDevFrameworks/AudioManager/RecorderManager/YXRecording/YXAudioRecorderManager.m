//
//  YXAudioManager.m
//  YXRecorder
//
//  Created by 张良玉 on 2017/12/19.
//  Copyright © 2017年 zhangliangyu. All rights reserved.
//

#import "YXAudioRecorderManager.h"
#import "KKDToolsDefine.h"
@interface YXAudioRecorderManager ()<AVAudioRecorderDelegate>

@property (nonatomic ,strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) NSTimer *levelMeterChangedTimer;

@end
@implementation YXAudioRecorderManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        NSURL *url = [NSURL URLWithString:self.cafFilePath];
        NSDictionary *setting = [self getAudioSetting];
        NSError *error = nil;
        _audioRecorder = [[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate = self;
        _audioRecorder.meteringEnabled = YES;//监听声波
        [_audioRecorder peakPowerForChannel:0];
        if(error){
            if ([self.delegate respondsToSelector:@selector(recordingFailed:)]) {
                [[self delegate] recordingFailed:[NSString stringWithFormat:@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription]];
            }
            return nil;
        }
    }
    return _audioRecorder;
}

// 录音设置
-(NSDictionary *)getAudioSetting{
    //LinearPCM 是iOS的一种无损编码格式,但是体积较为庞大
    // 录音设置信息字典
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
    // 录音格式
    [recordSettings setValue :@(kAudioFormatLinearPCM) forKey: AVFormatIDKey];
    // 采样率
    [recordSettings setValue :@(ETRECORD_RATE) forKey: AVSampleRateKey];
    // 通道数(双通道)
    [recordSettings setValue :@1 forKey: AVNumberOfChannelsKey];
    // 每个采样点位数（有8、16、24、32）
    [recordSettings setValue :@16 forKey: AVLinearPCMBitDepthKey];
    // 解码率
    [recordSettings setValue :@320000 forKey: AVEncoderBitRateKey];
    // 采用浮点采样
//    [recordSettings setValue:@YES forKey:AVLinearPCMIsFloatKey];
    // 音频质量
    [recordSettings setValue:@(AVAudioQualityMedium) forKey:AVEncoderAudioQualityKey];
    // 其他可选的设置
    // ... ...

    return recordSettings;
}

-(NSTimer *)levelMeterChangedTimer{
    if (!_levelMeterChangedTimer) {
        _levelMeterChangedTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(levelMeterChanged) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_levelMeterChangedTimer forMode:NSRunLoopCommonModes];
    }
    return _levelMeterChangedTimer;
}

-(BOOL)isRecording{
    return self.audioRecorder.isRecording;
}

-(void)levelMeterChanged {
    if(self.audioRecorder) {
        // 1.更新录音时间,单位秒
        int curInterval = [self.audioRecorder currentTime];
        // 2.声波显示
        //更新声波值
        [self.audioRecorder updateMeters];
        
        //获取音量的平均值  [recorder averagePowerForChannel:0];
        //音量的最大值  [recorder peakPowerForChannel:0];
        double power = pow(10, (0.05 * [self.audioRecorder peakPowerForChannel:0]));
        if ([self.delegate respondsToSelector:@selector(levelMeterChanged:interval:)]) {
            [self.delegate levelMeterChanged:power interval:curInterval];
        }
    }
}

-(void)startRecording{
    __weak typeof(self) weakSelf = self;
    [self isHasRecordingGranted:^(BOOL isGranted) {
        if ([weakSelf destoryTimer]) {
            [weakSelf.audioRecorder stop];
            [weakSelf cleanMp3File];
            [weakSelf cleanCafFile];
            self.audioRecorder = nil;
            [self.levelMeterChangedTimer invalidate];
            self.levelMeterChangedTimer = nil;
        }
        
        [self setIdleTimerDisabled:YES];
        
        if (![weakSelf.audioRecorder isRecording]) {
            AVAudioSession *session = [AVAudioSession sharedInstance];
            NSError *sessionError;
            //AVAudioSessionCategoryPlayAndRecord用于录音和播放
            [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
            if(session == nil)
                DEBUG_LOG(@"Error creating session: %@", [sessionError description]);
            else
                [session setActive:YES error:nil];
            [weakSelf.timer fire];
            [weakSelf.levelMeterChangedTimer fire];

            //缓冲录音
            [weakSelf.audioRecorder prepareToRecord];
            //开始录音
            [weakSelf.audioRecorder record];
            [weakSelf startConvertToMp3];
        }
    }];
}

-(void)stopRecording{
    // 停止
    if ([self.audioRecorder isRecording]) {
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(delayStopRecording) userInfo:nil repeats:NO];
        
    }
    
    [self setIdleTimerDisabled:NO];
    
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
}

- (void)delayStopRecording{
    [self destoryTimer];
    [self.audioRecorder stop];
    [self.levelMeterChangedTimer invalidate];
    self.levelMeterChangedTimer = nil;
}

-(void)cancelRecording{
    [self setIdleTimerDisabled:NO];
    // 停止
    if ([self.audioRecorder isRecording]) {
        [self destoryTimer];
        [self cancelConvertToMp3];
        [self.audioRecorder stop];
        [self cleanMp3File];
        [self cleanCafFile];
        self.audioRecorder = nil;
        [self.levelMeterChangedTimer invalidate];
        self.levelMeterChangedTimer = nil;
        [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    }
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (flag == YES) {
        [self stopConvertToMp3];
    } else {
        DEBUG_LOG(@"录音过程意外终止！");
    }
    self.audioRecorder = nil;
}

-(void)dealloc{
    [self setIdleTimerDisabled:NO];
}

@end


