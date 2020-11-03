//
//  YXActionSheet.h
//  PerfectDoc
//
//  Created by 张良玉 on 2019/12/6.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXActionSheet : UIView
@property (nonatomic ,strong) void(^clickedButtonBlock)(NSInteger buttonIndex);
+(void) shareActionSheetWithTitle:(nullable NSString *)title cancelButtonTitle:(nullable NSString *)cancelButtonTitle  otherButtonTitles:(nullable NSArray *)otherButtonTitles clickedButtonBlock:(void(^)(NSInteger buttonIndex))clickedButtonBlock;

+(void) shareActionSheetWithTitle:(nullable NSString *)title cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles clickedButtonBlock:(void(^)(NSInteger buttonIndex))clickedButtonBlock;

+(id) shareActionSheetWithTitle:(nullable NSString *)title cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead.");

+(void) shareActionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles clickedButtonBlock:(void(^)(NSInteger buttonIndex))clickedButtonBlock;
@end

NS_ASSUME_NONNULL_END
