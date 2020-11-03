//
//  YXSearchBar.m
//  Doctor
//
//  Created by 张良玉 on 2018/5/9.
//  Copyright © 2018年 YX. All rights reserved.
//

#import "YXSearchBar.h"
#import "UIImage+Tint.h"
#import "NSString+AttributedString.h"
#import "ToolsHeader.h"
@interface YXSearchBar ()<UITextFieldDelegate>
@property (nonatomic, strong)UIView *searchView;
@property (nonatomic, strong)UIImageView * leftView;
@property (nonatomic, strong)UIButton * deleteBtn;
@property (nonatomic, strong)UIButton * cancelBtn;
@end
@implementation YXSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAllViews];
        self.backgroundColor = RGB_COLOR_WITH_0x(WhiteColor);
    }
    return self;
}

- (void)initAllViews
{
    CGFloat height = self.height-2*kGetWidth(6);
    CGFloat X = kGetWidth(15);
    self.searchView = [[UIView alloc]initWithFrame:CGRectMake(X, kGetWidth(6), self.width-2*X, height)];
    self.searchView.backgroundColor = RGB_COLOR_WITH_0x(BgViewColor);
    [self addSubview:self.searchView];
    self.searchView.layer.masksToBounds = YES;
    self.searchView.layer.cornerRadius = height/2;
    CGFloat imageWidith = kGetWidth(15);
    _leftView = [[UIImageView alloc] initWithFrame:CGRectMake(imageWidith, (height - imageWidith) / 2, imageWidith, imageWidith)];
    _leftView.image = [UIImage imageNamed:@"search_icon.png"];
    [self.searchView addSubview:_leftView];
    
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.delegate = self;
        _textField.font = kSystemFitFont(15);
        [_textField addTarget:self action:@selector(textFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
        [self.searchView addSubview:_textField];
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
//        [_textField setValue:kSystemFitFont(15) forKeyPath:@"_placeholderLabel.font"];
        
        NSString *hConstraintStr = [NSString stringWithFormat:@"H:[leftView]-(%f)-[textField]-(%f)-|",kGetWidth(10),self.searchView.height];
        NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hConstraintStr options:0 metrics:nil views:@{@"leftView":_leftView,@"textField":_textField}];
        NSString *vConstraintStr = [NSString stringWithFormat:@"V:|-(1)-[textField]-(1)-|"];
        NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:vConstraintStr options:0 metrics:nil views:@{@"textField":_textField}];
        [self addConstraints:hConstraints];
        [self addConstraints:vConstraints];
    }
    
    if (_deleteBtn == nil) {
        _deleteBtn = [[UIButton alloc]init];
        _deleteBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_deleteBtn setImage:[UIImage imageNamed:@"search_delete_icon"] forState:UIControlStateNormal];
        
        [_deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.searchView addSubview:_deleteBtn];
        
        NSString *hConstraintStr = [NSString stringWithFormat:@"H:[deleteBtn(%f)]-(1)-|",self.searchView.height-2];
        NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hConstraintStr options:0 metrics:nil views:@{@"deleteBtn":_deleteBtn}];
        NSString *vConstraintStr = [NSString stringWithFormat:@"V:|-(1)-[deleteBtn(%f)]-(1)-|",self.searchView.height-2];
        NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:vConstraintStr options:0 metrics:nil views:@{@"deleteBtn":_deleteBtn}];
        [self addConstraints:hConstraints];
        [self addConstraints:vConstraints];
        _deleteBtn.hidden = YES;
    }
    if (!_cancelBtn&&!self.isHiddenCancel) {
        
        _cancelBtn = [UIViewUtil creatButtonWithFrame:CGRectMake(self.width-45-X, 3, 45, self.height-6) font:kSystemFitFont(15) title:@"取消" titleColor:RGB_COLOR_WITH_0x(BlackText666Color) bgNormalImage:nil bgHightLightImage:nil];
        [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        _cancelBtn.hidden = YES;
        [self addSubview:_cancelBtn];
    }
}

- (void)setIsbecomeFirstResponder:(BOOL)isbecomeFirstResponder
{
    _isbecomeFirstResponder = isbecomeFirstResponder;
    if (_isbecomeFirstResponder) {
        [_textField becomeFirstResponder];
    }
}

- (void)setSearBarColor:(UIColor *)searBarColor
{
    _searBarColor = searBarColor;
    self.searchView.backgroundColor = _searBarColor;
    _textField.backgroundColor = _searBarColor;
    _leftView.backgroundColor = _searBarColor;
    _deleteBtn.backgroundColor = _searBarColor;
}


- (void)setSearBarFont:(UIFont *)searBarFont
{
    _searBarFont = searBarFont;
    _textField.font = _searBarFont;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _textField.textColor = _textColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    if (self.placeholdesColor) {
        self.textField.attributedPlaceholder = [placeholder setAttributedWithIdentifyString:placeholder color:self.placeholdesColor font:kSystemFitFont(15)];
    }else{
        _textField.placeholder = _placeholder;
        self.textField.attributedPlaceholder = [placeholder setAttributedWithIdentifyString:placeholder color:nil font:kSystemFitFont(15)];
    }
}

- (void)setPlaceholdesColor:(UIColor *)placeholdesColor
{
    _placeholdesColor = placeholdesColor;
    if (self.placeholder) {
        self.textField.attributedPlaceholder = [self.placeholder setAttributedWithIdentifyString:self.placeholder color:placeholdesColor font:kSystemFitFont(15)];
    }
    
}

- (void)setText:(NSString *)text
{
    _text = text;
    _textField.text = _text;
}

- (void)setDeleteImage:(UIImage *)deleteImage
{
    _deleteImage = deleteImage;
    [_deleteBtn setImage:_deleteImage forState:UIControlStateNormal];
}

#pragma mark - deleteClick
- (void)deleteClick:(UIButton *)delete
{
    [self.textField setText:@""];
    self.deleteBtn.hidden = YES;
}

#pragma mark - CancelClick
- (void)cancelClick:(UIButton *)delete
{
    [self.textField setText:@""];
    self.deleteBtn.hidden = YES;
    [self.textField resignFirstResponder];
    if (!self.isHiddenCancel) {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.1 animations:^{
            weakSelf.searchView.width = weakSelf.width-2*weakSelf.searchView.x;
            weakSelf.cancelBtn.hidden = YES;
        }];
    }
    if ([_delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]) {
        [self.delegate searchBarCancelButtonClicked:self];
    }
}

#pragma mark - textFieldValueChange
- (void)textFieldValueChange:(UITextField *)textField
{
    _text = textField.text;
    if (textField.text.length) {
        self.deleteBtn.hidden = NO;
    }else{
        self.deleteBtn.hidden = YES;
    }
    
    if ([_delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.delegate searchBar:self textDidChange:textField.text];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        if (![self.delegate searchBarShouldBeginEditing:self]) {
            return NO;
        }
    }
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.1 animations:^{
        if (!weakSelf.isHiddenCancel) {
            weakSelf.searchView.width = weakSelf.cancelBtn.x - weakSelf.searchView.x;
            weakSelf.cancelBtn.hidden = NO;
        }
        
        if (weakSelf.text.length>0) {
            weakSelf.deleteBtn.hidden = NO;
        }else{
            weakSelf.deleteBtn.hidden = YES;
        }
    }];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]) {
        [self.delegate searchBarTextDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        return [self.delegate searchBarShouldEndEditing:self];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]) {
        [self.delegate searchBarTextDidEndEditing:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]) {
        if (![self.delegate searchBarSearchButtonClicked:self]) {
            return NO;
        }
    }
    if (textField.text.length>0) {
        [self.textField resignFirstResponder];
        self.deleteBtn.hidden = YES;
        
    }else{
        [self cancelClick:nil];
    }
    return YES;
}

-(void)resignFirstResponder{
    [self.textField resignFirstResponder];
}

-(BOOL)isFirstResponder
{
    return self.textField.text.length||[self.textField isFirstResponder]?YES:NO;
}

-(BOOL)becomeFirstResponder{
    return [self.textField becomeFirstResponder];
}
@end
