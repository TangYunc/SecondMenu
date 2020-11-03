//
//  LXCalendarWeekView.m
//  LXCalendar
//
//  Created by chenergou on 2017/11/2.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXCalendarWeekView.h"
#import "UIView+LX_Frame.h"
#import "UIColor+Expanded.h"
#import "UILabel+LXLabel.h"
#import "LxButton.h"
#import "ToolsHeader.h"
@implementation LXCalendarWeekView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(245, 249, 255);
        self.layer.cornerRadius = self.lx_height / 2;
    }
    return self;
}
-(void)setWeekTitles:(NSArray *)weekTitles{
    _weekTitles = weekTitles;
    
    CGFloat width = (self.lx_width - 10) /weekTitles.count;
    for (int i = 0; i< weekTitles.count; i++) {
        UILabel *weekLabel =[UILabel LXLabelWithText:weekTitles[i] textColor:[UIColor hexStringToColor:@"000000"] backgroundColor:[UIColor clearColor] frame:CGRectMake( 5 + i * width, 0, width, self.lx_height) font:Font(14) textAlignment:NSTextAlignmentCenter];
        
        [self addSubview:weekLabel];
    }
}
@end
