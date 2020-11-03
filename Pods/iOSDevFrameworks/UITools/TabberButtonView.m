
//
//  SelectButtonView.m
//  Doctor
//
//  Created by 张良玉 on 2018/5/8.
//  Copyright © 2018年 YX. All rights reserved.
//

#import "TabberButtonView.h"
#import "ToolsHeader.h"
@interface TabberButtonView ()
@property (nonatomic ,strong) TabberButton *selectButton;
@property (nonatomic ,strong) NSMutableArray *buttonArray;
@end

@implementation TabberButtonView
-(NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        self.normalColor = RGB_COLOR_WITH_0x(BlackTextColor);
        self.selectedColor = RGB_COLOR_WITH_0x(DocBlueColor);
        self.titles = titles;
        self.backgroundColor = RGB_COLOR_WITH_0x(WhiteColor);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles selectedColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!color) {
            color = RGB_COLOR_WITH_0x(DocBlueColor);
        }
        self.normalColor = RGB_COLOR_WITH_0x(BlackTextColor);
        self.selectedColor = color;
        self.titles = titles;
        self.backgroundColor = RGB_COLOR_WITH_0x(WhiteColor);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles selectedColor:(UIColor *)color normalColor:(UIColor *)normalColor selectedHeight:(CGFloat)height{
    self = [super initWithFrame:frame];
    if (self) {
        if (!color) {
            color = RGB_COLOR_WITH_0x(DocBlueColor);
        }
        if (!normalColor) {
            normalColor = RGB_COLOR_WITH_0x(BlackTextColor);
        }
        self.selectedColor = color;
        self.normalColor = normalColor;
        self.selectedLineHeight = height;
        self.titles = titles;
        self.backgroundColor = RGB_COLOR_WITH_0x(WhiteColor);
    }
    return self;
}

-(void)setTitles:(NSArray *)titles{
    _titles = titles;
    if (self.buttonArray.count==titles.count) {
        for (NSInteger i=0; i<self.buttonArray.count; i++) {
            TabberButton *button = [self.buttonArray objectAtIndex:i];
            [button setTitle:titles[i] forState:UIControlStateNormal];
        }
    }else{
        for (UIView *view in [self subviews]) {
            [view removeFromSuperview];
        }
        if (self.buttonArray.count) {
            [self.buttonArray removeAllObjects];
        }
        CGFloat width = self.width/titles.count;
        for (int i=0; i<titles.count; i++) {
            TabberButton *button = [[TabberButton alloc]initWithFrame:CGRectMake(i*(width), 0, width, self.height-0.5)];
            [button setTitle:titles[i] forState:UIControlStateNormal];
            button.selectedColor = self.selectedColor;
            [button setTitleColor:self.normalColor forState:UIControlStateNormal];
            button.tag = i+6000;
            [self addSubview:button];
            [self.buttonArray addObject:button];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i==0) {
                button.selected = YES;
                self.selectButton = button;
            }
        }
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-0.5, kScreenWidth, 0.5)];
        line.backgroundColor = RGB_COLOR_WITH_0x(CellLineViewColor);
        [self addSubview:line];
    }
}

-(void)setSelectedLineHeight:(CGFloat)selectedLineHeight{
    _selectedLineHeight = selectedLineHeight;
    if (selectedLineHeight) {
        for (TabberButton *button in self.buttonArray) {
            button.selectLineView.frame = CGRectMake((button.width-button.selectLineView.width)/2, button.height-selectedLineHeight, button.selectLineView.width, selectedLineHeight);
            button.selectLineView.layer.cornerRadius = selectedLineHeight/2;
        }
    }
}

-(void)setSelectedLineWidth:(CGFloat)selectedLineWidth{
    _selectedLineWidth = selectedLineWidth;
    if (selectedLineWidth) {
        for (TabberButton *button in self.buttonArray) {
            button.selectLineView.frame = CGRectMake((button.width-selectedLineWidth)/2, button.height-button.selectLineView.height, selectedLineWidth, button.selectLineView.height);
        }
    }
}

-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    for (TabberButton *button in self.buttonArray) {
        button.selectedColor = selectedColor;
    }
}

-(void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor;
    for (TabberButton *button in self.buttonArray) {
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    }
}

- (void)setSelectedFont:(UIFont *)selectedFont{
    _selectedFont = selectedFont;
}

-(void)setTitleFont:(UIFont *)titleFont{
    for (TabberButton *button in self.buttonArray) {
        button.titleLabel.font = titleFont;
    }
}

-(void)setIsShowLineSpacing:(BOOL)isShowLineSpacing{
    _isShowLineSpacing = isShowLineSpacing;
    if (isShowLineSpacing) {
        for (int i=0; i<self.buttonArray.count-1; i++) {
            TabberButton *button = self.buttonArray[i];
            CGFloat height = kGetWidth(16);
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(UIViewRightX(button), (button.height-height)/2, 0.5, height)];
            line.backgroundColor = RGB_COLOR_WITH_0x(CellLineViewColor);
            [self addSubview:line];
        }
    }
}

-(void)setIsShowSelectLine:(BOOL)isShowSelectLine{
    _isShowSelectLine = isShowSelectLine;
    for (TabberButton *button in self.buttonArray) {
        button.isShowSelectLine = isShowSelectLine;
        button.selectLineView.hidden = !isShowSelectLine;
    }
}

-(UIFont *)titleFont{
    TabberButton *button = [self.buttonArray firstObject];
    return button.titleLabel.font;
}

-(void)buttonClick:(TabberButton *)button{
    if (button != self.selectButton) {
        button.selected = !button.selected;
        NSInteger index = button.tag-6000;
        BOOL isSelect = YES;
        if (self.selectButtonBlock) {
            isSelect = self.selectButtonBlock(index);
        }
        if (isSelect) {
            self.selectButton.selected = NO;
            self.selectButton = button;
            self.selectedIndex = index;
        }else{
            button.selected = NO;
        }
    }
}

-(void)selectIndex:(NSInteger)index{
    if (index<self.buttonArray.count) {
        TabberButton *button = [self.buttonArray objectAtIndex:index];
        [self buttonClick:button];
    }
}

-(void)updateRedAlertIndex:(NSInteger)index isAlert:(BOOL)isAlert{
    if (index<self.buttonArray.count) {
        TabberButton *button = [self.buttonArray objectAtIndex:index];
        button.isHiddenRedAlert = !isAlert;
    }
}

@end

@interface TabberButton()
@property (nonatomic ,strong) UIView *redAlert;
@end
@implementation TabberButton

- (UIView *)redAlert{
    if (!_redAlert) {
        _redAlert = [[UIView alloc]init];
        _redAlert.backgroundColor = RGB_COLOR_WITH_0x(RedColor);
        CGFloat redAlertWidth = kGetWidth(8);
        _redAlert.layer.cornerRadius = redAlertWidth/2;
        _redAlert.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_redAlert];
        NSDictionary *views = @{@"titleLabel":self.titleLabel,@"redAlert":_redAlert};
        NSString *hConstraintStr = [NSString stringWithFormat:@"H:[titleLabel]-(1)-[redAlert(%f)]",redAlertWidth];
        NSArray *hConstraint = [NSLayoutConstraint constraintsWithVisualFormat:hConstraintStr options:0 metrics:nil views:views];
        CGFloat height = self.titleLabel.font.pointSize;
        NSString *vConstraintStr = [NSString stringWithFormat:@"V:[titleLabel]-(-%f)-[redAlert(%f)]",height,redAlertWidth];
        NSArray *vConstraint = [NSLayoutConstraint constraintsWithVisualFormat:vConstraintStr options:0 metrics:nil views:views];
        [self addConstraints:hConstraint];
        [self addConstraints:vConstraint];
    }
    return _redAlert;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectLineView = [[UIView alloc]initWithFrame:CGRectMake((self.width-15)/2, self.height-1.5, 15, 1.5)];
        self.selectLineView.backgroundColor = RGB_COLOR_WITH_0x(DocBlueColor);
        self.selectLineView.hidden = YES;
        self.selectLineView.layer.masksToBounds = YES;
        self.titleLabel.font = kSystemFitFont(17);
        [self addSubview:self.selectLineView];
        self.isShowSelectLine = YES;
    }
    return self;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected&&self.isShowSelectLine) {
        self.selectLineView.hidden = NO;
    }else{
        self.selectLineView.hidden = YES;
    }
}

-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    self.selectLineView.backgroundColor = selectedColor;
    [self setTitleColor:selectedColor forState:UIControlStateSelected];
}

-(void)setIsHiddenRedAlert:(BOOL)isHiddenRedAlert
{
    _isHiddenRedAlert = isHiddenRedAlert;
    self.redAlert.hidden = isHiddenRedAlert;
}

@end
