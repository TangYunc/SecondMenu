//
//  KKDSegmentBarItem.h
//  Test
//
//  Created by KungJack on 13/11/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    ButtonItem = 0,
    DisableItem,
    ImageButtonItem,
    
}SegmentBarItemType;

@interface KKDSegmentBarItem : UIButton

@property(nonatomic,assign)SegmentBarItemType itemType;

@end
