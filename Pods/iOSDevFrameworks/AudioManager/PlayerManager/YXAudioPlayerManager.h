//
//  PlayerManager.h
//  MusicDemo




#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    YXPlayer_Original,
    YXPlayer_UnkonwError,
    YXPlayer_ReadyToPlay,
    YXPlayer_Playing,
    YXPlayer_PlayFailed,
    YXPlayer_Pause,
    YXPlayer_Stop,
    YXPlayer_Loading,
    YXPlayer_FinishedPlay,
} YXPlayerStatus;

@protocol YXPlayerDelagate <NSObject>
@optional
- (void)currentPlayerStatus:(YXPlayerStatus)playerStatus;
@end

@interface YXAudioPlayerManager : NSObject
@property (nonatomic, strong) NSData *playingData;
@property (nonatomic ) YXPlayerStatus playerStatus;
// instance method
+ (instancetype)sharedInstance;

/**
 Play music  by URL
 
 @param voiceURL voiceURL description
 */
- (void)playWithVoiceURL:(id)voiceURL;

- (void)play;
// pause
- (void)pause;
// stop
- (void)stop;


// 当前时间(秒数)
@property (nonatomic, assign) NSInteger currentTime;
// 总时间(秒数)
@property (nonatomic, assign) NSInteger finishTime;

@property (nonatomic, assign) YXPlayerStatus status;

@property (nonatomic, weak) id<YXPlayerDelagate> delegate;
@end
