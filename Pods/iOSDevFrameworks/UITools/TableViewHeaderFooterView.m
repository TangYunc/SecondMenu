
//  TableViewHeaderFooterView.m
//  Doctor
//
//  Created by 张良玉 on 16/5/9.
//  Copyright © 2016年 YX. All rights reserved.
//

#import "TableViewHeaderFooterView.h"
#import "UIImage+Tint.h"
#import "ToolsHeader.h"
@interface TableViewHeaderFooterView ()
{
    UIView *_bgView;
}
@end

@implementation TableViewHeaderFooterView

+(id)shareTableHeaderFooterView:(UITableView *)tableView
{
    TableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerFooterView"];
    if (!headerFooterView) {
        headerFooterView = [[TableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerFooterView"];
    }
    headerFooterView.height = kGetWidth(44);
    return headerFooterView;
}

+(id)shareTableHeaderFooterView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier
{
    TableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (!headerFooterView) {
        headerFooterView = [[TableViewHeaderFooterView alloc]initWithReuseIdentifier:reuseIdentifier];
    }
    headerFooterView.height = kGetWidth(44);
    return headerFooterView;
}

-(void)setHeight:(CGFloat)height
{
    _bgView.height = height;
    _titleLabel.height = height;
    _bottomLine.y = height;
    _subtitleView.height = height;
    _subtitleLabel.height = height;
    
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kGetWidth(44))];
        _bgView.backgroundColor = RGB_COLOR_WITH_0x(WhiteColor);
        [self addSubview:_bgView];
        
        _topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        _topLine.backgroundColor = RGB_COLOR_WITH_0x(CellLineViewColor);
        [self addSubview:_topLine];
        
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(kGetWidth(15), self.frame.size.height-0.5, kScreenWidth-kGetWidth(15), 0.5)];
        _bottomLine.backgroundColor = RGB_COLOR_WITH_0x(CellLineViewColor);
        _bottomLine.hidden = YES;
        [self addSubview:_bottomLine];
        
        _titleLabel = [UIViewUtil creatLableWithFrame:CGRectMake(kGetWidth(15), 0, kScreenWidth-2*kGetWidth(15)-100, kGetWidth(44)) font:kSystemFitFont(15) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(BlackTextColor)];
        [self addSubview:_titleLabel];
        
        _subtitleView = [[UIView alloc]initWithFrame:CGRectMake(_bgView.width-kGetWidth(15), 0, 20, _bgView.height)];
        [self addSubview:_subtitleView];
        
        UIImage *image = [UIImage imageNamed:@"arrow"];
        CGFloat width = kGetWidth(12);
        CGFloat height = width*image.size.height/image.size.width;
        self.nextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_subtitleView.width-width, (_subtitleView.height-height)/2, width, height)];
        self.nextImageView.image = image;
        [_subtitleView addSubview:self.nextImageView];
        
        self.subtitleLabel = [UIViewUtil creatLableWithFrame:CGRectMake(0, 0, 0, _subtitleLabel.height) font:kSystemFitFont(13) textAlignment:NSTextAlignmentRight textColor:RGB_COLOR_WITH_0x(0xc7c9cf)];
        [_subtitleView addSubview:self.subtitleLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCilck)];
        [_subtitleView addGestureRecognizer:tap];
        _subtitleView.hidden = YES;
    }
    return self;
}

-(void)tapCilck{
    if (self.tapClickBlock) {
        self.tapClickBlock();
    }
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    _bgView.backgroundColor = backgroundColor;
}

-(void)setSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
    if (subtitle&&![subtitle isEqualToString:@""]) {
        self.subtitleView.hidden = NO;
        self.subtitleLabel.text = subtitle;
        CGSize size = [subtitle getStringSizeWithFont:kSystemFitFont(13)];
        if (self.nextHidden) {
            self.subtitleView.frame = CGRectMake(_bgView.width-size.width-kGetWidth(15), 0, size.width, self.subtitleView.height);
            self.subtitleLabel.frame = CGRectMake(0, 0, size.width, self.subtitleLabel.height);
        }else{
            self.nextImageView.hidden = NO;
            CGFloat width = size.width+kGetWidth(5)+self.nextImageView.width;
            self.subtitleView.frame = CGRectMake(_bgView.width-width-kGetWidth(15), 0, width, self.subtitleView.height);
            self.subtitleLabel.frame = CGRectMake(0, 0, size.width, self.subtitleView.height);
            self.nextImageView.centerY = self.subtitleView.height/2;
            self.nextImageView.x = self.subtitleView.width-self.nextImageView.width;
        }
    }
}

-(void)setNextHidden:(BOOL)nextHidden{
    _nextHidden = nextHidden;
    self.nextImageView.hidden = nextHidden;
    if (self.nextHidden) {
        self.subtitleView.frame = CGRectMake(self.width-self.subtitleLabel.width-kGetWidth(15), 0, self.subtitleLabel.width, self.height);
    }else{
        CGFloat width = self.subtitleLabel.width+kGetWidth(5)+self.nextImageView.width;
        self.subtitleView.frame = CGRectMake(self.width-width-kGetWidth(15), 0, width, self.height);
    }
}

@end
