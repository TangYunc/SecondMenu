//
//  YXBasePopView.h
//  PerfectDoc
//
//  Created by Fa Kong on 15/10/12.
//  Copyright © 2015年 YX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXBasePopView : UIView
@property (nonatomic) CGFloat alpha;
@property (nonatomic, assign) BOOL bgButtonClose;
-(void)show;
-(void)showWithView:(UIView *)contentView backgroundColor:(UIColor *)backgroundColor;
-(void)dismiss;

@end
