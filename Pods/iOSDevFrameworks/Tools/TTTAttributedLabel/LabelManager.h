//
//  LabelManager.h
//  Doctor
//
//  Created by yuanxin on 15/5/8.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import "TTTAttributedLabel.h"

@interface LabelManager : TTTAttributedLabel

/*
 初始化文本label
 返回为可以显示超链接
 由于需要判断字符串是否存在URL所以初始化“必须传有效字符串”
 */
+(TTTAttributedLabel*)TTTAttributedLabelText:(NSString *)text lableDelegate:(id)delegate lableFont:(UIFont *)font colorForURl:(UIColor *)urlcolor withFrame:(CGRect)frame;

@end
