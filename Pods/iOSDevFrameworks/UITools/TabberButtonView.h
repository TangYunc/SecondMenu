//
//  SelectButtonView.h
//  Doctor
//
//  Created by 张良玉 on 2018/5/8.
//  Copyright © 2018年 YX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabberButtonView : UIView
@property (nonatomic ,strong) NSArray *titles;
@property (nonatomic ,strong) UIColor *selectedColor;
@property (nonatomic ,strong) UIColor *normalColor;
@property (nonatomic ,strong) UIFont *selectedFont;
@property (nonatomic ,strong) UIFont *normalFont;
@property (nonatomic ) CGFloat selectedLineHeight;
@property (nonatomic ) CGFloat selectedLineWidth;
@property (nonatomic ,strong) UIFont *titleFont;
@property (nonatomic ) NSInteger selectedIndex;
@property (nonatomic ) BOOL isShowLineSpacing;
@property (nonatomic ) BOOL isShowSelectLine;
@property (nonatomic ,strong) BOOL(^selectButtonBlock)(NSInteger index);
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

-(void)selectIndex:(NSInteger)index;

-(void)updateRedAlertIndex:(NSInteger)index isAlert:(BOOL)isAlert;
@end

@interface TabberButton : UIButton
@property (nonatomic ,strong) UIView *selectLineView;
@property (nonatomic ,strong) UIColor *selectedColor;
@property (nonatomic ) BOOL isHiddenRedAlert;
@property (nonatomic ) BOOL isShowSelectLine;
@end
