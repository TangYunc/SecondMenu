//
//  KKDSegmentBarItem.m
//  Test
//
//  Created by KungJack on 13/11/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import "KKDSegmentBarItem.h"

@implementation KKDSegmentBarItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setTitle:(NSString *)title forState:(UIControlState)state{

    switch (self.itemType) {
        case ButtonItem:
        {
            [super setTitle:title forState:state];
        }
            break;
        case DisableItem:
        {
            [super setTitle:@"—" forState:state];
        }
            break;
        case ImageButtonItem:
        {
            [super setTitle:@"" forState:state];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)setItemType:(SegmentBarItemType)itemType{
    
    _itemType = itemType;
    switch (itemType) {
        case ButtonItem:
        {
            
        }
            break;
        case DisableItem:
        {
            self.enabled = NO;
            [self setTitle:@"—" forState:UIControlStateDisabled];
        }
            break;
        case ImageButtonItem:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}


@end
