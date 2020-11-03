//
//  RotationView.h
//  KKDictionary
//
//  Created by KungJack on 7/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//
/////////////////////////////////////////////////////////////////////////////////
/// 自动旋转View
/////////////////////////////////////////////////////////////////////////////////

#define ROTATION_PERIOD 0.7f

#import <UIKit/UIKit.h>

@interface RotationView : UIView

@property (nonatomic,strong)UIImageView *rotationImageView;

-(void)startAnimation;
-(void)removeAnimation;

@end
