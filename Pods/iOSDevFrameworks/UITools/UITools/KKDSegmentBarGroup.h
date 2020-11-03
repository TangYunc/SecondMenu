//
//  KKDSegmentBarGroup.h
//  Test
//
//  Created by KungJack on 13/11/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    LineStyle,
    ImageStyle,
} BarStyle;

@class KKDSegmentBarItem;

@interface KKDSegmentBarGroup : UIScrollView

@property(nonatomic,strong)UIColor *popItemSelectColor;
@property(nonatomic,strong)UIColor *popItemsBgColor;
@property(nonatomic,strong)UIFont *popItemFont;
@property(nonatomic,strong)NSString *popTitle;

@property(nonatomic,assign)BarStyle barStyle;
@property(nonatomic,assign)NSInteger currentSelectIndex;
@property(nonatomic,copy)void (^onItemSelect)(id sender);
@property(nonatomic,copy)void (^onPopItemSelect)(id sender);
@property(nonatomic,strong)NSArray *popViewValues;

-(void)addItem:(KKDSegmentBarItem *)barItem;
-(void)updateUI;

@end
