//
//  BGHaveLineView.m
//  Doctor
//
//  Created by yuanxin on 15/5/19.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import "BGLineView.h"
#import "ToolsHeader.h"
@implementation BGLineView

-(instancetype)initWithFrame:(CGRect)frame lineType:(LineType)type backgroundColor:(UIColor *)backgroundColor;
{
    self = [super initWithFrame:frame];
    _type = type;
    if (self) {
        if (_type != NoLine) {
            
            switch (_type) {
                case TopLine:
                {
                    _topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
                    _topLine.backgroundColor = RGB_COLOR_WITH_0x(CellLineViewColor);
                    [self addSubview:_topLine];
                }
                    break;
                case BottomLine:
                {
                    _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, kScreenWidth, 0.5)];
                    _bottomLine.backgroundColor = RGB_COLOR_WITH_0x(CellLineViewColor);
                    [self addSubview:_bottomLine];
                }
                    break;
                case TopAndBottomLine:
                {
                    _topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
                    _topLine.backgroundColor = RGB_COLOR_WITH_0x(CellLineViewColor);
                    _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, kScreenWidth, 0.5)];
                    _bottomLine.backgroundColor = RGB_COLOR_WITH_0x(CellLineViewColor);
                    [self addSubview:_topLine];
                    [self addSubview:_bottomLine];
                }
                    break;
                    
                default:
                    break;
            }
        }
        if (backgroundColor) {
            self.backgroundColor = backgroundColor;
        }else{
            self.backgroundColor = RGB_COLOR_WITH_0x(WhiteColor);
        }
    }
    
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (_topLine) {
        _topLine.frame = CGRectMake(self.topLeading, 0, self.width-self.topLeading, 0.5);
    }
    if (_bottomLine) {
        _bottomLine.frame = CGRectMake(self.bottomLeading, self.frame.size.height-0.5, self.width-self.bottomLeading, 0.5);
    }
    
}

@end
