//
//  YXAlertView.h
//  Doctor
//
//  Created by 张良玉 on 16/12/1.
//  Copyright © 2016年 YX. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class YXAlertView;
@protocol YXAlertViewDelegate <NSObject>

@optional
-(void)alertView:(nullable YXAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
-(void)alertView:(nullable YXAlertView *)alertView object:(nullable id)object clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface YXAlertView : UIView

+(void) shareAlerViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message tag:(NSInteger)tag delegate:(nullable id<YXAlertViewDelegate>)delegate  cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle;
+(void) shareAlerViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message tag:(NSInteger)tag delegate:(nullable id<YXAlertViewDelegate>)delegate  cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle object:(nullable id)object;
+(void) shareAlerViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle clickedBlock:(void(^_Nullable)(NSInteger buttonIndex))clickedBlock;

+(void) shareAlerViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message textAlignment:(NSTextAlignment )textAlignment tag:(NSInteger)tag delegate:(nullable id<YXAlertViewDelegate>)delegate  cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle;
+(void) shareAlerViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message textAlignment:(NSTextAlignment )textAlignment tag:(NSInteger)tag delegate:(nullable id<YXAlertViewDelegate>)delegate  cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle object:(nullable id)object;
+(void) shareAlerViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message textAlignment:(NSTextAlignment )textAlignment cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle clickedBlock:(void(^_Nullable)(NSInteger buttonIndex))clickedBlock;
@end

