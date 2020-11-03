//
//  KKDSegmentBar.h
//  KKDictionary
//
//  Created by KungJack on 19/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKDSegmentBar : UIView

@property(nonatomic,strong)NSArray *items;
@property(nonatomic,strong)NSArray *enableItems;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)NSInteger currentSelectIndex;
@property(nonatomic,copy)void (^onItemSelect)(id sender);

@property(nonatomic,strong)UIColor *itemSelectColor;
@property(nonatomic,strong)UIFont *itemFont;
@property(nonatomic,strong)UIImage *itemBackgroudSelectImage;
@property(nonatomic,strong)UIImage *itemBackgroudImage;
@property(nonatomic,strong)UIImage *itemBackgroudHighLightImage;
@property(nonatomic,assign)BOOL isHasImage;

@end
