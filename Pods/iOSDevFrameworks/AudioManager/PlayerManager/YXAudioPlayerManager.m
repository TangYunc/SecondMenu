//
//  PlayerManager.m
//  MusicDemo


#import "YXAudioPlayerManager.h"
#import <AVFoundation/AVFoundation.h>
#import "KKDToolsDefine.h"

#define isValidString(string)               (string && [string isEqualToString:@""] == NO)

@interface YXAudioPlayerManager()<AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation YXAudioPlayerManager
// instance method
+ (instancetype)sharedInstance
{
    static YXAudioPlayerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YXAudioPlayerManager alloc] init];
    });
    return manager;
}

// default init
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

/**
 Play music  by URL
 
 @param voiceURL voiceURL description
 */
- (void)playWithVoiceURL:(id)voiceURL {
    NSURL *url = nil;
    if ([voiceURL isKindOfClass:[NSString class]]) {
        url = [NSURL fileURLWithPath:voiceURL];
    }else if ([voiceURL isKindOfClass:[NSURL class]]){
        url = voiceURL;
    }else
        return;
    self.status = YXPlayer_Original;
    self.playingData = [NSData dataWithContentsOfFile:voiceURL];
}

// 播放
- (void)play
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayback error:&sessionError];
    if(session == nil){
        DEBUG_LOG(@"Error creating session: %@", [sessionError description]);
    }else{
       [session setActive:YES error:nil];
    }

    NSError *error = nil;
    if (!self.audioPlayer) {
        self.audioPlayer = [[AVAudioPlayer alloc]initWithData:self.playingData error:&error];
        if (!error) {
            self.audioPlayer.delegate = self;
            [self.audioPlayer play];
            self.status = YXPlayer_Playing;
            if ([self respondsDelegate]) { [self.delegate currentPlayerStatus:YXPlayer_Playing]; }
        }else{
            DEBUG_LOG(@"设置播放器失败");
        }
    }else{
        [self.audioPlayer play];
        self.status = YXPlayer_Playing;
        if ([self respondsDelegate]) { [self.delegate currentPlayerStatus:YXPlayer_Playing]; }
    }
}
// 暂停
- (void)pause
{
    [self.audioPlayer pause];
    self.status = YXPlayer_Pause;
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    DEBUG_LOG(@"=======  play pause =======");
    self.status = YXPlayer_Pause;
    if ([self respondsDelegate]) { [self.delegate currentPlayerStatus:YXPlayer_Pause]; }
}

// stop
- (void)stop {
    [self.audioPlayer stop];
    self.status = YXPlayer_Stop;
    self.audioPlayer = nil;
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    DEBUG_LOG(@"=======  play stop =======");
    self.status = YXPlayer_Stop;
    if ([self respondsDelegate]) { [self.delegate currentPlayerStatus:YXPlayer_Stop]; }
}

- (BOOL)respondsDelegate {
    if (self.delegate && [self.delegate respondsToSelector:@selector(currentPlayerStatus:)]) {
        return YES;
    }
    return NO;
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self stop];
}

-(void)dealloc{
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}
@end
