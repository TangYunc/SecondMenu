//
//  YXTextView.m
//  Doctor
//
//  Created by 张良玉 on 17/1/9.
//  Copyright © 2017年 YX. All rights reserved.
//

#import "YXTextView.h"
#import <Masonry/Masonry.h>
#import "NSString+AttributedString.h"
#import "ToolsHeader.h"
@interface YXTextView ()<UITextViewDelegate>
@property (nonatomic ,strong)UILabel *placeholderLabel;
@property (nonatomic ,strong)UILabel *numberLabel;
@end

@implementation YXTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB_COLOR_WITH_0x(WhiteColor);
        self.autoBecomeFirstResponder = YES;
        self.inputView = [[TextView alloc]init];
        self.inputView.font = kSystemFitFont(15);
        self.inputView.textColor = RGB_COLOR_WITH_0x(0x333333);
        self.inputView.delegate = self;
        self.inputView.showsVerticalScrollIndicator = NO;
        self.inputView.showsHorizontalScrollIndicator = NO;
        self.inputView.contentInset = UIEdgeInsetsMake(0, -3.5, 0, -3.5);
        self.inputView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.inputView];
        self.inputView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[inputView]-15-|" options:0 metrics:nil views:@{@"inputView":self.inputView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[inputView]-0-|" options:0 metrics:nil views:@{@"inputView":self.inputView}]];
        
        self.placeholderLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:self.inputView.font textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(PlaceholderTextColor)];
        self.placeholderLabel.numberOfLines = 0;
        [self addSubview:self.placeholderLabel];
        self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8.0-[placeholderLabel]" options:0 metrics:nil views:@{@"placeholderLabel":self.placeholderLabel}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-3-[placeholderLabel]-3-|" options:0 metrics:nil views:@{@"placeholderLabel":self.placeholderLabel}]];
    }
    return self;
}

-(void)setPlaceholderStr:(NSString *)placeholderStr
{
    _placeholderStr = placeholderStr;
    if (self.lineSpacing) {
        NSDictionary *dic = self.inputView.typingAttributes;
        self.placeholderLabel.attributedText = [[NSAttributedString alloc]initWithString:placeholderStr attributes:dic];
    }else{
        self.placeholderLabel.text = placeholderStr;
    }
}

-(void)setFont:(UIFont *)font{
    self.placeholderLabel.font = font;
    self.inputView.font = font;
}

-(UIFont *)font{
    return self.inputView.font;
}

-(void)setReturnKeyType:(UIReturnKeyType)returnKeyType{
    self.inputView.returnKeyType = returnKeyType;
}

-(UIReturnKeyType)returnKeyType{
    return self.inputView.returnKeyType;
}

-(void)setPromptStr:(NSString *)promptStr
{
    _promptStr = promptStr;

    if (promptStr&&![promptStr isEqualToString:@""]) {
        self.inputView.text = promptStr;
        self.placeholderLabel.hidden = YES;
    }else{
        self.placeholderLabel.hidden = NO;
    }
    
    if (self.autoBecomeFirstResponder) {
        [self.inputView becomeFirstResponder];
    }else if (self.isShowTextNumber) {
        [self setShowTextNumber:self.inputView.text.length];
    }
}

-(void)setLineSpacing:(CGFloat)lineSpacing{
    _lineSpacing = lineSpacing;
    
    NSDictionary *dic = [NSString getAttributeWithlineSpacing:self.lineSpacing font:self.inputView.font];
    self.inputView.typingAttributes = dic;
    self.placeholderStr = self.placeholderStr;
}

-(void)setContentInset:(UIEdgeInsets)contentInset
{
    _contentInset = contentInset;
    self.inputView.frame = CGRectMake(contentInset.left, contentInset.top, self.width-contentInset.left-contentInset.right, self.height-contentInset.top-contentInset.bottom);
}

-(void)setText:(NSString *)text{
    self.inputView.text = text;
    if (self.inputView.text.length>0) {
        self.placeholderLabel.hidden = YES;
    }else{
        self.placeholderLabel.hidden = NO;
    }
}

-(NSString *)text{
    return self.inputView.text;
}

- (UILabel *)numberLabel{
    if (!_numberLabel) {
        CGFloat height = [NSString getStringSizeWithFont:kSystemFitFont(11)].height;
        _numberLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitFont(11) textAlignment:NSTextAlignmentRight textColor:RGB_COLOR_WITH_0x(BlackText999Color)];
        [self addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(height);
        }];
    }
    return _numberLabel;
}

-(void)setShowTextNumber:(NSInteger)number{
    if (self.textNumber == 0) {
        self.textNumber = 100;
    }
    NSString *numberStr = [NSString stringWithFormat:@"%ld",(long)number];
    NSString *showNumberStr = [NSString stringWithFormat:@"%@/%d",numberStr, self.textNumber];
    self.numberLabel.attributedText = [showNumberStr setAttributedWithIdentifyString:numberStr color:RGB_COLOR_WITH_0x(0xf5ba42)];
}

- (void)setIsShowTextNumber:(BOOL)isShowTextNumber{
    _isShowTextNumber = isShowTextNumber;
    if (_isShowTextNumber) {
        [self setShowTextNumber:self.inputView.text.length];
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        self.placeholderLabel.hidden = YES;
    }else{
        self.placeholderLabel.hidden = NO;
    }
    
    if (self.textNumber == 0) {
        self.textNumber = 100;
    }
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    if (!position) {
        
        BOOL isEdit = !([textView.text isEqualToString:_promptStr]||textView.text.length == 0);
        if (self.isEditing) {
            self.isEditing(isEdit);
        }
        if ([self.editDelegte respondsToSelector:@selector(textViewIsEditing:)]) {
            [self.editDelegte textViewIsEditing:isEdit];
        }
        if (textView.text.length>self.textNumber) {
            textView.text = [textView.text substringToIndex:_textNumber];
        }
        if (self.isShowTextNumber) {
            [self setShowTextNumber:textView.text.length];
        }
        if (self.didChange) {
            self.didChange(textView.text);
        }
        if ([self.editDelegte respondsToSelector:@selector(textViewDidChange:)]) {
            [self.editDelegte textViewDidChange:textView.text];
        }
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.didEndEditing) {
        self.didEndEditing(textView.text);
    }
    if ([self.editDelegte respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.editDelegte textViewDidEndEditing:textView.text];
    }//self.inputView resignFirstResponder
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self endEditing:YES];
        return NO;
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.editDelegte respondsToSelector:@selector(textViewWillEdit:)]) {
        [self.editDelegte textViewWillEdit:textView];
    }
    return YES;
}

-(BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    return [self endEditing:YES];
}

@end

@implementation TextView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.menuVisible = YES;
    }
    return self;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (!self.menuVisible) {
        [UIMenuController sharedMenuController].menuVisible = self.menuVisible;
        return self.menuVisible;
    }
    else{
        return [super canPerformAction:action withSender:sender];
    }
}
@end
