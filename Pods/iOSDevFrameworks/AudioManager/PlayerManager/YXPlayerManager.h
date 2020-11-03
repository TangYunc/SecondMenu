//
//  YXPlayerManager.h
//  OnlineHosptial
//
//  Created by 张良玉 on 2019/6/26.
//  Copyright © 2019年 zhangliangyu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger ,YXPlayerState) {
    YXPlayerStateUnknown,
    YXPlayerStateReadyToPlay,
    YXPlayerStateFailed
};

typedef void(^PlayerStateBlock)(YXPlayerState state);

@interface YXPlayerManager : NSObject
@property (nonatomic ,strong) NSString *voiceURL;
@property (nonatomic ) BOOL isPlaying;
+ (instancetype)sharedInstance;
+ (void)destroyInstance;

- (void)playWithVoiceURL:(NSString *)voiceURL status:(PlayerStateBlock )stateBlock;
- (void)pause;
@end
