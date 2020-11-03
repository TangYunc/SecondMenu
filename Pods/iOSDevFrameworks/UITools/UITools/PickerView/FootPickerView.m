//
//  FootPickerView.m
//  Doctor
//
//  Created by 张良玉 on 2017/8/24.
//  Copyright © 2017年 YX. All rights reserved.
//

#import "FootPickerView.h"
#import "BGLineView.h"
#import "ToolsHeader.h"
@interface FootPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic ,strong) UIPickerView *pickerView;

@end


@implementation FootPickerView

+(void) shareFootPickerWithContents:(NSArray *)contents showContents:(NSArray *)showContents selected:(id)selectedContent selectSuccess:(void(^)(id content))selectSuccess{
    [FootPickerView shareFootPickerWithContents:contents showContents:showContents selected:selectedContent selectedColor:RGB_COLOR_WITH_0x(BlackTextColor) selectSuccess:selectSuccess];
}

+(void) shareFootPickerWithContents:(NSArray *)contents showContents:(NSArray *)showContents selected:(id)selectedContent selectedColor:(UIColor *)selectedColor selectSuccess:(void(^)(id content ))selectSuccess{
    [FootPickerView shareFootPickerWithContents:contents showContents:showContents selected:selectedContent selectedColor:selectedColor selectSuccess:selectSuccess dismis:nil];
}

+(void) shareFootPickerWithContents:(NSArray *)contents showContents:(NSArray <NSString *>*)showContents  selected:(id)selectedContent selectedColor:(UIColor *)selectedColor selectSuccess:(void(^)(id content ))selectSuccess dismis:(void(^)(void))dismis{
    FootPickerView *footPicker = [[FootPickerView alloc]init];
    footPicker.selectedContent = selectedContent;
    footPicker.showContents = (showContents&&showContents.count==contents.count)?showContents:contents;
    footPicker.selectedColor = selectedColor;
    footPicker.contents = contents;
    footPicker.selectSuccess = selectSuccess;
    footPicker.dismis = dismis;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.alpha = 0.4;
//        self.bgButtonClose = NO;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-kGetWidth(210), kScreenWidth, kGetWidth(210))];
        view.backgroundColor = RGB_COLOR_WITH_0x(WhiteColor);
        [self addSubview:view];
        
        BGLineView *butonView = [[BGLineView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kGetWidth(40)) lineType:BottomLine backgroundColor:RGB_COLOR_WITH_0x(BgViewColor)];
        [view addSubview:butonView];
        
        UIButton *cancelButton = [UIViewUtil creatButtonWithFrame:CGRectMake(kGetWidth(15), 0, 50, kGetWidth(40)) font:kSystemFitFont(16) title:@"取消" titleColor:RGB_COLOR_WITH_0x(BlackText999Color) bgNormalImage:nil bgHightLightImage:nil];
        [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,15)];
        [view addSubview:cancelButton];
        
        UIButton *selectButton = [UIViewUtil creatButtonWithFrame:CGRectMake(kScreenWidth-kGetWidth(15)-60, 0, 60, kGetWidth(40)) font:kSystemFitFont(16) title:@"确定" titleColor:RGB_COLOR_WITH_0x(DocBlueColor) bgNormalImage:nil bgHightLightImage:nil];
        [selectButton addTarget:self action:@selector(selectDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [selectButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 17, 0, 0)];
        [butonView addSubview:selectButton];
        
        UIView *pickerBGView = [[UIView alloc]initWithFrame:CGRectMake(0, UIViewBottomY(butonView), kScreenWidth, kGetWidth(170))];
        [view addSubview:pickerBGView];
        if (isIOS9) {
            BGLineView *selectionView = [[BGLineView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kGetWidth(225)/5) lineType:TopAndBottomLine backgroundColor:[UIColor clearColor]];
            selectionView.centerY = pickerBGView.height/2;
            [pickerBGView addSubview:selectionView];
        }
        
        UIPickerView *pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kGetWidth(5), kScreenWidth , kGetWidth(170)-kGetWidth(5)*2)];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        pickerView.backgroundColor = [UIColor clearColor];
        [pickerBGView addSubview:pickerView];
        
        self.pickerView = pickerView;
        [self show];
    }
    return self;
}

-(void)setContents:(NSArray *)contents
{
    _contents = contents;
    
    [self.pickerView reloadAllComponents];
    NSInteger index = 0;
    if (self.selectedContent) {
        NSInteger indexNew = [_contents indexOfObject:self.selectedContent];
        if (indexNew>=0&&indexNew<contents.count) {
            index = indexNew;
        }else{
            self.selectedContent = _contents[0];
        }
    }else{
        self.selectedContent = _contents[0];
    }
    
    UILabel *label = (UILabel *)[self.pickerView viewForRow:index forComponent:0];
    label.textColor = self.selectedColor;
    label.font = kSystemFitFont(18);
    [self.pickerView selectRow:index inComponent:0 animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.contents.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return kGetWidth(225)/5;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(-10, 0, view.frame.size.width, view.frame.size.height)];
    label.backgroundColor = [UIColor clearColor];
    label.font = kSystemFitFont(16);
    label.textColor = RGB_COLOR_WITH_0x(0x666666);
    label.textAlignment = NSTextAlignmentCenter;
    id content = self.showContents[row];
    if ([content isKindOfClass:[NSString class]]) {
        label.text = content;
    }
    return label;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
    label.textColor = self.selectedColor;
    label.font = kSystemFitFont(18);
    self.selectedContent = self.contents[row];
}

-(void)selectDidClick:(UIButton *)button{
    
    if (self.selectSuccess) {
        self.selectSuccess(self.selectedContent);
    }
    [self dismiss];
}

-(void)dismiss{
    if (self.dismis) {
        self.dismis();
    }
    [self removeFromSuperview];
}

@end
