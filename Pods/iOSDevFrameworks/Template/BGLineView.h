//
//  BGLineView.h
//  Doctor
//
//  Created by yuanxin on 15/5/19.
//  Copyright (c) 2015年 YX. All rights reserved.
//
typedef NS_ENUM(NSInteger, LineType){
    TopAndBottomLine,
    TopLine,
    BottomLine,
    NoLine
};
#import <UIKit/UIKit.h>
@interface BGLineView : UIView

@property (nonatomic ,strong) UIView *topLine;
@property (nonatomic ,strong) UIView *bottomLine;
@property (nonatomic) LineType type;
@property (nonatomic) CGFloat topLeading;
@property (nonatomic) CGFloat bottomLeading;
-(instancetype)initWithFrame:(CGRect)frame lineType:(LineType)type backgroundColor:(UIColor *)backgroundColor;


@end
