//
//  FooterButtonsPickerView.h
//  OnlineHosptial
//
//  Created by 张良玉 on 2018/11/23.
//  Copyright © 2018年 zhangliangyu. All rights reserved.
//

#import "YXBasePopView.h"

@interface FooterButtonsPickerView : YXBasePopView
@property (nonatomic ,strong) NSArray *contents;
@property (nonatomic ,strong) NSMutableArray *showContents;
@property (nonatomic ,strong) id selectedContent;
@property (nonatomic ,strong) UIColor *selectedColor;
@property (nonatomic ) BOOL isCustom;

@property (nonatomic ,strong) void(^selectSuccess)(id content ,BOOL isCustom);
@property (nonatomic ,strong) void(^dismis)(void);
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UIView *buttonsPickerView;

+(void) shareFootButtonsPickerWithContents:(NSArray *)contents showContents:(NSArray <NSString *>*)showContents selected:(id)selectedContent isCustom:(BOOL)isCustom selectSuccess:(void(^)(id content ,BOOL isCustom))selectSuccess dismis:(void(^)(void))dismis;
@end

@interface FooterButtonsPickerCell : UICollectionViewCell
@property (nonatomic ,strong) NSString *contentString;
@property (nonatomic ) BOOL isSelcted;
- (void)setContentString:(NSString *)contentString isSelcted:(BOOL) isSelcted;
@end
