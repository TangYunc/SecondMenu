//
//  TabberImageButtonView.m
//  Doctor
//
//  Created by 张良玉 on 2018/11/7.
//  Copyright © 2018年 zhangliangyu. All rights reserved.
//

#import "TabberImageButtonView.h"
#import "ToolsHeader.h"
@interface TabberImageButtonView ()
@property (nonatomic ,strong) NSArray *buttonTitles;
@property (nonatomic ,strong) NSMutableArray *buttonViews;
@property (nonatomic ,strong) NSMutableArray *lineViews;
@end
@implementation TabberImageButtonView

- (instancetype)initWithFrame:(CGRect)frame buttonTitles:(NSArray *)buttonTitles buttonImages:(NSArray *)buttonImages clickButtonBlock:(void (^)(NSInteger))clickButtonBlock
{
    return [self initWithFrame:frame buttonTitles:buttonTitles buttonImages:buttonImages clickButtonBlock:clickButtonBlock];
}

-(instancetype)initWithFrame:(CGRect)frame lineType:(LineType)type buttonTitles:(NSArray *)buttonTitles buttonImages:(NSArray *)buttonImages clickButtonBlock:(void (^)(NSInteger))clickButtonBlock{
    self = [super initWithFrame:frame lineType:type backgroundColor:nil];
    if (self) {
        self.buttonTitles = buttonTitles;
        NSInteger count = buttonTitles.count;
        self.buttonViews = [NSMutableArray array];
        self.lineViews = [NSMutableArray array];
        for (NSInteger i=0; i<count; i++) {
            
            TabberImageButton *buttonView = [[TabberImageButton alloc]initWithFrame:CGRectMake(0+i*frame.size.width/count, 0, frame.size.width/count, frame.size.height) title:buttonTitles[i] imagePath:buttonImages[i] clickButton:^(NSString *title) {
                if (clickButtonBlock) {
                    clickButtonBlock([buttonTitles indexOfObject:title]);
                }
            }];
            [self addSubview:buttonView];
            [self.buttonViews addObject:buttonView];
            
            if (i!=0) {
                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0+i*frame.size.width/count-0.5/2, kGetWidth(20), 0.5, frame.size.height-kGetWidth(20)*2)];
                lineView.backgroundColor = RGB_COLOR_WITH_0x(0xf4f4f6);
                [self addSubview:lineView];
                [lineView bringSubviewToFront:self];
                [self.lineViews addObject:lineView];
            }
        }
    }
    return self;
}

-(void)setNewAlertShow:(BOOL)isShow title:(NSString *)title
{
    NSInteger index = [self.buttonTitles indexOfObject:title];
    TabberImageButton *buttonView = [self.buttonViews objectAtIndex:index];
    buttonView.alertNewView.hidden = !isShow;
}

-(void)linesHidden:(BOOL)isHidden{
    for (UIView *line in self.lineViews) {
        line.hidden = isHidden;
    }
}
@end

@interface TabberImageButton ()
@property (nonatomic ,strong) void(^clickButton)(NSString *title);
@property (nonatomic ,strong) NSString *title;
@end
@implementation TabberImageButton
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imagePath:(NSString *)imagePath clickButton:(void(^)(NSString *title))clickButton
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clickButton = clickButton;
        self.title = title;
        UIImage *image = [UIImage imageNamed:imagePath];
        CGSize size = [title getStringSizeWithFont:kSystemFitFont(14)];
        CGFloat imageWidth =kGetWidth(image.size.width);
        CGFloat imageHeight = kGetWidth(image.size.height);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width-imageWidth)/2, (self.height-imageHeight-kGetWidth(10)-size.height)/2, imageWidth, imageHeight)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = image;
        [self addSubview:imageView];
        
        UILabel *titleLabel = [UIViewUtil creatLableWithFrame:CGRectMake(kGetWidth(5), UIViewBottomY(imageView)+kGetWidth(10), self.width-kGetWidth(5)*2, size.height) font:kSystemFitFont(14) textAlignment:NSTextAlignmentCenter textColor:RGB_COLOR_WITH_0x(BlackTextColor)];
        [self addSubview:titleLabel];
        titleLabel.text = title;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonClick:)];
        [self addGestureRecognizer:tap];
        
        CGFloat newAlertViewWidth = kGetWidth(10);
        self.alertNewView = [[UIView alloc]initWithFrame:CGRectMake(UIViewRightX(imageView)-newAlertViewWidth, imageView.y, newAlertViewWidth, newAlertViewWidth)];
        self.alertNewView.layer.cornerRadius = newAlertViewWidth/2;
        self.alertNewView.backgroundColor = RGB_COLOR_WITH_0x(RedColor);
        [self addSubview:self.alertNewView];
        self.alertNewView.hidden = YES;
    }
    return self;
}

-(void)buttonClick:(UITapGestureRecognizer *)gestureRecognizer{
    if (self.clickButton) {
        self.clickButton(self.title);
    }
}
@end
