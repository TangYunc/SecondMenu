//
//  RotationView.m
//  KKDictionary
//
//  Created by KungJack on 7/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import "RotationView.h"

#import <QuartzCore/QuartzCore.h>

@interface RotationView (){
}

@end

@implementation RotationView

@synthesize rotationImageView;

-(void)dealloc{
    self.rotationImageView = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, frame.size.width-16, frame.size.height-16)];
        logoView.image = [UIImage imageNamed:@"Icon.png"];
        logoView.layer.cornerRadius = (frame.size.width -16)/2;
        logoView.layer.masksToBounds = YES;
        [self addSubview: logoView];
        logoView.hidden =  YES;
        rotationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        rotationImageView.image = [UIImage imageNamed:@"refresh.png"];
        [self addSubview:rotationImageView];
        
    }
    return self;
    
}

-(void)startAnimation{
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI];
    rotationAnimation.duration = ROTATION_PERIOD;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.cumulative = YES;
    [rotationImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation1"];
    
}

-(void)removeAnimation{
    
    [rotationImageView.layer removeAllAnimations];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
