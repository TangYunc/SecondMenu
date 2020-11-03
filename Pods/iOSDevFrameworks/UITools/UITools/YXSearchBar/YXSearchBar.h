//
//  YXSearchBar.h
//  Doctor
//
//  Created by 张良玉 on 2018/5/9.
//  Copyright © 2018年 YX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXSearchBar;
@protocol YXSearchBarDelegate<NSObject>
@optional
- (BOOL)searchBarShouldBeginEditing:(YXSearchBar *)searchBar;

- (void)searchBarTextDidBeginEditing:(YXSearchBar *)searchBar;

- (BOOL)searchBarShouldEndEditing:(YXSearchBar *)searchBar;

- (void)searchBarTextDidEndEditing:(YXSearchBar *)searchBar;

- (void)searchBar:(YXSearchBar *)searchBar textDidChange:(NSString *)searchText;

- (BOOL)searchBarSearchButtonClicked:(YXSearchBar *)searchBar;//确定按钮

- (void)searchBarCancelButtonClicked:(YXSearchBar *)searchBar;
@end

@interface YXSearchBar : UIView
@property (nonatomic, strong) UITextField * textField;
//文本的颜色
@property (nonatomic, strong) UIColor * textColor;
//字体
@property (nonatomic, strong) UIFont * searBarFont;
//内容
@property (nonatomic, strong) NSString * text;
//背景颜色
@property (nonatomic, strong) UIColor * searBarColor;
//默认文本
@property (nonatomic, copy) NSString * placeholder;
//默认文本的颜色
@property (nonatomic, strong) UIColor * placeholdesColor;
//是否弹出键盘
@property (nonatomic, assign) BOOL isbecomeFirstResponder;
//设置右边按钮的样式
@property (nonatomic, strong) UIImage * deleteImage;
@property (nonatomic, assign) BOOL isHiddenCancel;
//设置代理
@property (nonatomic,weak)id<YXSearchBarDelegate>delegate;

-(void)resignFirstResponder;
-(BOOL)isFirstResponder;
-(BOOL)becomeFirstResponder;
@end
