//
//  YXTextView.h
//  Doctor
//
//  Created by 张良玉 on 17/1/9.
//  Copyright © 2017年 YX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXTextViewDelegate;
@class TextView;
@interface YXTextView : UIView

@property (nonatomic ,weak) id<YXTextViewDelegate>editDelegte;
@property (nonatomic ,strong) NSString *promptStr;

/// 默认为YES，promptStr赋值后自动成为第一相应
@property (nonatomic ) BOOL autoBecomeFirstResponder;
@property (nonatomic ,strong) NSString *placeholderStr;
@property (nonatomic) int textNumber;
@property (nonatomic ) UIEdgeInsets contentInset;

@property (nonatomic ,strong ) NSString *text;
@property (nonatomic ,strong ) UIFont *font;
@property (nonatomic) CGFloat lineSpacing;
@property (nonatomic) UIReturnKeyType returnKeyType;

@property (nonatomic ,strong) TextView *inputView;

@property (nonatomic ,strong) void(^isEditing)(BOOL isEdit);//YES有修改NO没有修改
@property (nonatomic ,strong) void (^didChange)(NSString *text);
@property (nonatomic ,strong) void (^didEndEditing)(NSString *text);

@property (nonatomic) BOOL isShowTextNumber;//显示数字计数器
@end

@protocol YXTextViewDelegate <NSObject>
@optional
- (void)textViewDidChange:(NSString *)text;
- (void)textViewDidEndEditing:(NSString *)text;
- (void)textViewIsEditing:(BOOL )isEdit;
- (void)textViewWillEdit:(UITextView *)textView;
@end

@interface TextView : UITextView
@property (nonatomic ) BOOL menuVisible;
@end
