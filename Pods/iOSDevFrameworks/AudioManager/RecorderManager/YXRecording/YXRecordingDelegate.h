//
//  YXRecordingDelegate.h
//  OnlineHosptial
//
//  Created by 张良玉 on 2019/4/20.
//  Copyright © 2019年 zhangliangyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YXRecordingDelegate <NSObject>
@optional
- (void)levelMeterChanged:(float)levelMeter interval:(NSInteger)interval;
- (void)recordingFinishedWithFileName:(NSString *)filePath;
- (void)recordingTimeout;
- (void)recordingTimeDidChange:(NSTimeInterval)time;
- (void)recordingFailed:(NSString *)failureInfoString;

- (void)recordingWithSpeechFinished;
- (void)recordingWithSpeechContent:(NSString *)content changeString:(NSString *)changeString;
- (void)recordingCancel;

/**
 录音机关闭
 */
- (void)recorderEnd;
- (void)recordStopError;
@end

NS_ASSUME_NONNULL_END
