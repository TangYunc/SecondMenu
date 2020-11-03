//
//  TabberImageButtonView.h
//  Doctor
//
//  Created by 张良玉 on 2018/11/7.
//  Copyright © 2018年 zhangliangyu. All rights reserved.
//

#import "BGLineView.h"

@interface TabberImageButtonView : BGLineView
- (instancetype)initWithFrame:(CGRect)frame buttonTitles:(NSArray *)buttonTitles buttonImages:(NSArray *)buttonImages clickButtonBlock:(void(^)(NSInteger index))clickButtonBlock;
- (instancetype)initWithFrame:(CGRect)frame lineType:(LineType)type buttonTitles:(NSArray *)buttonTitles buttonImages:(NSArray *)buttonImages clickButtonBlock:(void(^)(NSInteger index))clickButtonBlock;
- (void)setNewAlertShow:(BOOL)isShow title:(NSString *)title;
- (void)linesHidden:(BOOL)isHidden;
@end

@interface TabberImageButton : UIView
@property (nonatomic ,strong) UIView *alertNewView;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imagePath:(NSString *)imagePath clickButton:(void(^)(NSString *title))clickButton;
@end
