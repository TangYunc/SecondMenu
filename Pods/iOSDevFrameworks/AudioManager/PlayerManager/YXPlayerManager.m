//
//  YXPlayerManager.m
//  OnlineHosptial
//
//  Created by 张良玉 on 2019/6/26.
//  Copyright © 2019年 zhangliangyu. All rights reserved.
//

#import "YXPlayerManager.h"
#import <AVFoundation/AVFoundation.h>
#import "KKDToolsDefine.h"

@interface YXPlayerManager ()
@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) PlayerStateBlock stateBlock;
@end
@implementation YXPlayerManager
static YXPlayerManager *_manager = nil;
+ (instancetype)sharedInstance
{
    if (!_manager) {
        _manager = [[YXPlayerManager alloc]init];
    }
    return _manager;
}

+ (void)destroyInstance{
    _manager = nil;
}

- (void)playWithVoiceURL:(NSString *)voiceURL status:(PlayerStateBlock)stateBlock{
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayback error:&sessionError];
    if(session == nil){
        DEBUG_LOG(@"Error creating session: %@", [sessionError description]);
    }else{
        [session setActive:YES error:nil];
    }
    self.stateBlock = stateBlock;
    if (!self.player) {
        self.voiceURL = voiceURL;
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:voiceURL]];
        self.player = [[AVPlayer alloc] initWithPlayerItem:item];
        [self.player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [self.player play];
    }
}

- (void)pause{
    [self.player pause];
    [self.player removeObserver:self forKeyPath:@"status"];
    self.player = nil;
    self.isPlaying = NO;
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        YXPlayerState state = YXPlayerStateUnknown;
        AVPlayer *player = object;
        switch (player.status) {
            case AVPlayerStatusUnknown:
                state = YXPlayerStateUnknown;
                break;
            case AVPlayerStatusReadyToPlay:{
                state = YXPlayerStateReadyToPlay;
                self.isPlaying = YES;
            }
                break;
            case AVPlayerStatusFailed:
                state = YXPlayerStateFailed;
                break;
                
            default:
                break;
        }
        if (self.stateBlock) {
            self.stateBlock(state);
        }
    }
}

@end
