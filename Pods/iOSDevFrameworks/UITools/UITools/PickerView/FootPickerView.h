//
//  FootPickerView.h
//  Doctor
//
//  Created by 张良玉 on 2017/8/24.
//  Copyright © 2017年 YX. All rights reserved.
//

#import "YXBasePopView.h"

@interface FootPickerView : YXBasePopView

@property (nonatomic ,strong) NSArray *contents;
@property (nonatomic ,strong) NSArray *showContents;
@property (nonatomic ,strong) id selectedContent;
@property (nonatomic ,strong) UIColor *selectedColor;

@property (nonatomic ,strong) void(^selectSuccess)(id content);
@property (nonatomic ,strong) void(^dismis)(void);

+(void) shareFootPickerWithContents:(NSArray *)contents showContents:(NSArray <NSString *>*)showContents selected:(id)selectedContent selectSuccess:(void(^)(id content ))selectSuccess;

+(void) shareFootPickerWithContents:(NSArray *)contents showContents:(NSArray <NSString *>*)showContents  selected:(id)selectedContent selectedColor:(UIColor *)selectedColor selectSuccess:(void(^)(id content ))selectSuccess;

+(void) shareFootPickerWithContents:(NSArray *)contents showContents:(NSArray <NSString *>*)showContents  selected:(id)selectedContent selectedColor:(UIColor *)selectedColor selectSuccess:(void(^)(id content ))selectSuccess dismis:(void(^)(void))dismis;
@end
