//
//  KKDLoadingViewUtil.m
//  KKDictionary
//
//  Created by KungJack on 14/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import "KKDLoadingViewUtil.h"
#import "RotationView.h"
#import "ToolsHeader.h"
@implementation KKDLoadingViewUtil

static RotationView *tskRotationView;
static UIView *bgHUD;
static UIView *bgInterceptView;


+(void)showLoading:(BOOL)screemLock{
    
    [KKDLoadingViewUtil showLoading:screemLock title:@"正在加载..."];
    
}

+(void)showLoading:(BOOL)screemLock title:(NSString *)title{
    [KKDLoadingViewUtil showLoading:screemLock title:title intercept:NO];
}

+(void)showLoading:(BOOL)screemLock title:(NSString *)title intercept:(BOOL)intercept{
    UIWindow *nowWindow=  [[UIApplication sharedApplication] keyWindow];
    if (intercept&&!bgInterceptView) {
        bgInterceptView = [[UIView alloc] initWithFrame:nowWindow.frame];
        [nowWindow addSubview:bgInterceptView];
    }
    
    if(!tskRotationView){
        CGRect rect = nowWindow.frame;
        rect.origin.x = (rect.size.width - 33)/2;
        rect.origin.y = (rect.size.height - 33)/2;
        rect.size = CGSizeMake(33, 33);
        tskRotationView = [[RotationView alloc] initWithFrame:rect];
    }
    [tskRotationView removeAnimation];
    CGFloat width = [title getStringSizeWithFont:kSystemFont(16.0f)].width+20;
    if (width<110) {
        width = 110;
    }
    if (screemLock) {
        if (!bgHUD) {
            CGRect rect = CGRectMake(80, 160, 110, 100);
            bgHUD = [[UIView alloc] initWithFrame:rect];
            bgHUD.layer.cornerRadius = 4.0f;
            bgHUD.layer.masksToBounds = YES;
        }
        bgHUD.width = width;
        bgHUD.centerX = kScreenWidth/2;
        bgHUD.backgroundColor = RGBA(0, 0, 0, 0.0);
        CGRect rect = bgHUD.frame;
        rect.origin.x = (rect.size.width - 33)/2;
        rect.origin.y = (rect.size.height - 33)/2-10;
        rect.size = CGSizeMake(33, 33);
        
        tskRotationView.frame = rect;
        [tskRotationView startAnimation];
        [bgHUD addSubview:tskRotationView];
        for(UIView *view in [bgHUD subviews]){
            if([view isKindOfClass:[UILabel class]]){
                [view removeFromSuperview];
            }
        }
        UILabel *titleLabel = [UIViewUtil creatLableWithFrame:CGRectMake(10, (bgHUD.height - 40), bgHUD.width-20, 30) font:kSystemFont(16.0f) textAlignment:NSTextAlignmentCenter textColor:RGB_COLOR_WITH_0x(WhiteColor)];
        titleLabel.text = title;
        [bgHUD addSubview:titleLabel];
        [nowWindow addSubview:bgHUD];
        
    }else{
        
        if (!bgHUD) {
            bgHUD = [[UIView alloc] initWithFrame:CGRectMake(86, isiPhone5?180:138, 110, 100)];
        }
        
        [nowWindow addSubview:bgHUD];
        
        CGRect rect = bgHUD.frame;
        rect.origin.x = (rect.size.width - 33)/2;
        rect.origin.y = (rect.size.height - 33)/2-10;
        rect.size = CGSizeMake(33, 33);
        tskRotationView.frame  = rect;
        [tskRotationView startAnimation];
        [bgHUD addSubview:tskRotationView];
        
    }
    bgHUD.backgroundColor = RGBA(0, 0, 0, 0.7);
    bgHUD.center = CGPointMake(kScreenWidth/2, kScreenHeight*2/5);
    
}

+(void)dismissLoading{
    
    [tskRotationView removeAnimation];
    [tskRotationView removeFromSuperview];
    if(bgHUD){
        [bgHUD removeFromSuperview];
    }
    if(bgInterceptView){
        [bgInterceptView removeFromSuperview];
        bgInterceptView = nil;
    }
}

+(void)toast:(NSString *)content time:(float)time{
    
    UIWindow *nowWindow=  [[UIApplication sharedApplication] keyWindow];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(50, 180, 220, 44)];
    bgView.tag = 1000001;
    bgView.layer.cornerRadius =6.0f;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = RGBA(0, 0, 0, 0.7);// RGBA(0, 0, 0, 0.9);
    UILabel *toastLabel = [UIViewUtil creatLableWithFrame:CGRectMake(10,  0, 200, 44) font:kSystemFont(15.0f) textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor]];
    toastLabel.clipsToBounds = YES;
    toastLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;//(UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin);
    toastLabel.backgroundColor = [UIColor clearColor];
    toastLabel.numberOfLines = 0;
    toastLabel.lineBreakMode = NSLineBreakByCharWrapping;
    toastLabel.text = content;
    [bgView addSubview:toastLabel];
    [nowWindow addSubview:bgView];
    if(content.length>=14){
        
        CGSize size = [content getStringSizeWithFont:kSystemFont(15.0f) constrainedToSize:CGSizeMake(200, MAXFLOAT)];
        //        CGRect rect = toastLabel.frame;
        //        rect.size.height = size.height+20;
        //        toastLabel.frame = rect;
        CGRect bgRect = bgView.frame;
        bgRect.size.height = size.height+20;
        bgView.frame = bgRect;
        
    }else{
        
        CGSize size = [content getStringSizeWithFont:kSystemFont(15.0f)];
        CGRect rect = bgView.frame;
        rect.size.width = size.width + 40;
        bgView.frame = rect;
        
    }
    bgView.center = CGPointMake(kScreenWidth/2, (bgView.frame.size.height/2 + 180));
    
    bgView.transform = CGAffineTransformMakeScale(0.01,0.01);
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         bgView.transform = CGAffineTransformMakeScale(1.2,1.2);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2
                                               delay:0
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^(void){
                                              bgView.transform = CGAffineTransformMakeScale(0.9,0.9);
                                          } completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.2
                                                                    delay:0
                                                                  options:UIViewAnimationOptionAllowUserInteraction
                                                               animations:^(void){
                                                                   bgView.transform = CGAffineTransformMakeScale(1,1);
                                                               } completion:^(BOOL finished) {
                                                               }];
                                          }];
                     }];
    
    [KKDLoadingViewUtil performSelector:@selector(hiddenToastView) withObject:nil afterDelay:time];
    
}

+(void)hiddenToastView{
    
    UIWindow *nowWindow=  [[UIApplication sharedApplication] keyWindow];
    UIView *toastLabel = (UIView *)[nowWindow viewWithTag:1000001];
    [toastLabel removeFromSuperview];
    
}

@end
