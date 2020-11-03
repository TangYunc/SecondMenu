//
//  FooterButtonView.m
//  Doctor
//
//  Created by 张良玉 on 2018/11/22.
//  Copyright © 2018年 zhangliangyu. All rights reserved.
//

#import "FooterButtonView.h"
#import "ToolsHeader.h"
@implementation FooterButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB_COLOR_WITH_0x(WhiteColor);
        self.layer.shadowOffset = CGSizeMake(0, -1);
        self.layer.shadowRadius = 2;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowColor = RGB_COLOR_WITH_0x(ShadowColor).CGColor;
    }
    return self;
}

@end
