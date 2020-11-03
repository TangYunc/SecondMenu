//
//  YXBasePopView.m
//  PerfectDoc
//
//  Created by Fa Kong on 15/10/12.
//  Copyright © 2015年 YX. All rights reserved.
//

#import "YXBasePopView.h"
#import <Masonry/Masonry.h>
#import "ToolsHeader.h"
@interface YXBasePopView ()

@property (nonatomic, strong) UIButton *bgButton;
@property (nonatomic, strong) UIColor *contentViewColor;
@end

@implementation YXBasePopView

-(id)init{

    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    CGSize winSize = window.bounds.size;
    self = [super initWithFrame:CGRectMake(0, 0, winSize.width, winSize.height)];
    if(self){
        
        self.bgButton = [[UIButton alloc]init];
        _bgButton.backgroundColor = [UIColor clearColor];
        [_bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_bgButton];
        [_bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(0);
        }];
    }
    return self;
    
}

-(void)setAlpha:(CGFloat)alpha
{
    if (alpha<0) {
        alpha=0;
    }else if (alpha>1){
        alpha=1;
    }
    _alpha = alpha;
    if (alpha==0) {
        self.bgButton.backgroundColor = [UIColor clearColor];
    }else{
        if (!self.backgroundColor) {
            self.bgButton.backgroundColor = RGB_COLOR_WITH_0x_alpha(0x000000, _alpha);
        }else{
            self.bgButton.alpha = _alpha;
        }
    }
}

-(void)show{

    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window addSubview:self];
}

-(void)showWithView:(UIView *)contentView backgroundColor:(UIColor *)backgroundColor
{
    self.backgroundColor = [UIColor clearColor];
    self.contentViewColor = contentView.backgroundColor;
    contentView.backgroundColor = [UIColor clearColor];
    
    [self show];
    
    contentView.frame = CGRectMake(contentView.x-10, contentView.y-10, contentView.width+20, contentView.height+20);
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.backgroundColor = backgroundColor;
        contentView.backgroundColor = weakSelf.contentViewColor;
        contentView.frame = CGRectMake(contentView.x+10, contentView.y+10, contentView.width-20, contentView.height-20);
    } completion:^(BOOL finished) {
        
    }];

}

-(void)bgButtonAction{

    if(!self.bgButtonClose){
        [self dismiss];
    }
    
}

-(void)dismiss{
    
    [self removeFromSuperview];
}

@end
