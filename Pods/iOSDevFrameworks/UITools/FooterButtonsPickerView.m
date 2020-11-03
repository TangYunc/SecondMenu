//
//  FooterButtonsPickerView.m
//  OnlineHosptial
//
//  Created by 张良玉 on 2018/11/23.
//  Copyright © 2018年 zhangliangyu. All rights reserved.
//

#import "FooterButtonsPickerView.h"
#import "ToolsHeader.h"
#define FooterButtonsPickerCellID @"FooterButtonsPickerCell"
#define CustomButtonTitle @"自定义"
@interface FooterButtonsPickerView() <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ) NSInteger selectedIndex;
@end
@implementation FooterButtonsPickerView
+(void) shareFootButtonsPickerWithContents:(NSArray *)contents showContents:(NSArray<NSString *> *)showContents selected:(id)selectedContent isCustom:(BOOL)isCustom selectSuccess:(void (^)(id, BOOL))selectSuccess dismis:(void (^)(void))dismis{
    FooterButtonsPickerView *footPicker = [[FooterButtonsPickerView alloc]init];
    footPicker.selectedContent = selectedContent;
    footPicker.isCustom = isCustom;
    footPicker.showContents = [NSMutableArray arrayWithArray:(showContents&&showContents.count==contents.count)?showContents:contents];
    if (isCustom) {
        [footPicker.showContents addObject:CustomButtonTitle];
    }
    footPicker.contents = contents;
    footPicker.selectSuccess = selectSuccess;
    footPicker.dismis = dismis;
    [footPicker show];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.alpha = 0.4;
        CGFloat width = self.width;
        CGFloat height = self.height;
        self.buttonsPickerView = [[UIView alloc]initWithFrame:CGRectMake(0, height, width, 0)];
        self.buttonsPickerView.backgroundColor = RGB_COLOR_WITH_0x(WhiteColor);
        [self addSubview:self.buttonsPickerView];
        
        CGFloat buttonWidth = kGetWidth(65);
        CGFloat buttonHeight = kGetWidth(40);
        UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, buttonHeight)];
        buttonView.backgroundColor = RGB_COLOR_WITH_0x(BgViewColor);
        [self.buttonsPickerView addSubview:buttonView];
        UIFont *font = kSystemFitFont(14);
        UIButton *cancelButton = [UIViewUtil creatButtonWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight) font:font title:@"取消" titleColor:RGB_COLOR_WITH_0x(BlackText666Color) bgNormalImage:nil bgHightLightImage:nil];
        [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:cancelButton];
        
        UIButton *sendButton = [UIViewUtil creatButtonWithFrame:CGRectMake( width-buttonWidth, 0, buttonWidth, buttonHeight) font:font title:@"确定" titleColor:RGB_COLOR_WITH_0x(DocBlueColor) bgNormalImage:nil bgHightLightImage:nil];
        [sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:sendButton];
        
        
        CGFloat margin = kGetWidth(15);
        CGFloat spacing = kGetWidth(10);
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((width-margin*2-spacing*2)/3, kGetWidth(35));
        layout.minimumInteritemSpacing = spacing;
        layout.minimumLineSpacing = margin;
        layout.sectionInset = UIEdgeInsetsMake(margin+margin, margin, margin+(isiPhoneX?34:kGetWidth(25)), margin);
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, UIViewBottomY(buttonView), width, 100) collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.buttonsPickerView addSubview:self.collectionView];
        [self.collectionView registerClass:[FooterButtonsPickerCell class] forCellWithReuseIdentifier:FooterButtonsPickerCellID];
        self.buttonsPickerView .height = UIViewBottomY(self.buttonsPickerView)+kGetWidth(25)+(isiPhoneX?spacing:0);
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.buttonsPickerView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake( spacing, spacing)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.buttonsPickerView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.buttonsPickerView.layer.mask = maskLayer;
    }
    return self;
}

-(void)setContents:(NSArray *)contents{
    _contents = contents;
    self.selectedIndex = 0;
    if (self.selectedContent) {
        NSInteger index = [_contents indexOfObject:self.selectedContent];
        if (index>=0&&index<contents.count) {
            self.selectedIndex = index;
        }
    }
    [self layoutButtonsPickerView];
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)layoutButtonsPickerView{
    CGFloat spacing = kGetWidth(15);
    CGFloat buttonheight = kGetWidth(35);
    NSInteger count = self.showContents.count>12?12:self.showContents.count;
    NSInteger row = ((int)count/3)+(count%3?1:0);
    self.collectionView.height = row*buttonheight+(row+2)*spacing+(isiPhoneX?34:kGetWidth(25));
    self.buttonsPickerView.height = UIViewBottomY(self.collectionView);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.showContents.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.获得cell
    FooterButtonsPickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FooterButtonsPickerCellID forIndexPath:indexPath];
    [cell setContentString:self.showContents[indexPath.row] isSelcted:(self.selectedIndex == indexPath.row)];
    return cell;
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content = self.showContents[indexPath.row];
    if ([content isEqualToString:CustomButtonTitle]) {
        if (self.selectSuccess) {
            self.selectSuccess(content, YES);
        }
        [self dismiss];
    }else{
        self.selectedIndex = indexPath.row;
    }
    [self.collectionView reloadData];
}

-(void)sendButtonClick{
    id content = self.contents[self.selectedIndex];
    if (self.selectSuccess) {
        self.selectSuccess(content, NO);
    }
    [self dismiss];
}

- (void)show{
    
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window addSubview:self];
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0.4;
        self.buttonsPickerView.y = self.height-self.buttonsPickerView.height;
    } completion:^(BOOL finished) {

    }];
}

- (void)dismiss{
    if (self.dismis) {
        self.dismis();
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0.0;
        self.buttonsPickerView.y = self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end

@interface FooterButtonsPickerCell ()
@property (nonatomic ,strong) UILabel *contentLabel;
@end
@implementation FooterButtonsPickerCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat margin = kGetWidth(5);
        CGFloat width = self.width - margin*2;
        CGFloat height = self.height;
        self.backgroundColor = RGB_COLOR_WITH_0x(BgViewColor);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = height/2;
        self.layer.borderWidth = 0.5;
        
        self.contentLabel = [UIViewUtil creatLableWithFrame:CGRectMake( margin, 0, width, height) font:kSystemFitFont(14) textAlignment:NSTextAlignmentCenter textColor:RGB_COLOR_WITH_0x(BlackTextColor)];
        [self addSubview:self.contentLabel];
    }
    return self;
}

- (void)setContentString:(NSString *)contentString isSelcted:(BOOL) isSelcted{
    self.isSelcted = isSelcted;
    self.contentString = contentString;
    self.contentLabel.text = contentString;
    if ([contentString isEqualToString:CustomButtonTitle]) {
        self.contentLabel.textColor = RGB_COLOR_WITH_0x(DocBlueColor);
        self.backgroundColor = RGB_COLOR_WITH_0x(WhiteColor);
        self.layer.borderColor = RGB_COLOR_WITH_0x(DocBlueColor).CGColor;
    }else{
        if (isSelcted) {
            self.contentLabel.textColor = RGB_COLOR_WITH_0x(WhiteColor);
            self.backgroundColor = RGB_COLOR_WITH_0x(DocBlueColor);
            self.layer.borderColor = RGB_COLOR_WITH_0x(DocBlueColor).CGColor;
        }else{
            self.contentLabel.textColor = RGB_COLOR_WITH_0x(BlackTextColor);
            self.backgroundColor = RGB_COLOR_WITH_0x(BgViewColor);
            self.layer.borderColor = RGB_COLOR_WITH_0x(BgViewColor).CGColor;
        }
    }
}
@end
