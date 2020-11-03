//
//  HHBaseRefreshView.m
//  https://github.com/yuwind/HHRefreshManager
//
//  Created by 豫风 on 2017/3/30.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "HHBaseRefreshView.h"

@implementation HHBaseRefreshView
-(NSString *)noMoreString{
    if (!_noMoreString) {
        _noMoreString = @"没有更多数据";
    }
    return _noMoreString;
}

-(UILabel *)noMoreLabel{
    if (!_noMoreLabel) {
        _noMoreLabel = [[UILabel alloc]init];
        _noMoreLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        _noMoreLabel.textAlignment = NSTextAlignmentCenter;
        _noMoreLabel.font = [UIFont systemFontOfSize:14];
        _noMoreLabel.text = self.noMoreString;
        _noMoreLabel.hidden = YES;
        [self addSubview:_noMoreLabel];
        _noMoreLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[noMoreLabel]-2-|" options:0 metrics:nil views:@{@"noMoreLabel":_noMoreLabel}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[noMoreLabel]-2-|" options:0 metrics:nil views:@{@"noMoreLabel":_noMoreLabel}]];
    }
    return _noMoreLabel;
}

- (void)normalRefresh:(CGFloat)rate{}
- (void)readyRefresh{}
- (void)beginRefresh{}
- (void)endRefresh{}

@end
