//
//  KKDSegmentBarGroup.m
//  Test
//
//  Created by KungJack on 13/11/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import "KKDSegmentBarGroup.h"
#import "KKDSegmentBarItem.h"
#import "ToolsHeader.h"
@interface KKDSegmentBarGroup (){
    NSMutableArray *itemArray;
    UIButton *bgButton;
    UIButton *titleLabel;
}
@property(nonatomic,strong)NSMutableArray *itemArray;
@property(nonatomic,strong)UIButton *bgButton;
@property(nonatomic,strong)UIButton *titleLabel;

@end

@implementation KKDSegmentBarGroup

@synthesize itemArray;
@synthesize bgButton;
@synthesize titleLabel;

-(void)dealloc{

    self.onItemSelect = nil;
    self.onPopItemSelect = nil;
    self.bgButton = nil;
    self.titleLabel = nil;
    [self.itemArray removeAllObjects];
    self.itemArray = nil;
    self.popViewValues = nil;
    
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if(self){
        self.itemArray = [NSMutableArray arrayWithCapacity:0];
        self.popItemFont = [UIFont systemFontOfSize:15.0f];
        self.popItemsBgColor = [UIColor grayColor];
        self.popItemSelectColor = [UIColor redColor];
        _currentSelectIndex=-1;
//        self.layer.cornerRadius = 3.0f;
//        self.layer.borderWidth = 1.0f;
//        self.layer.borderColor = [UIColor redColor].CGColor;
//        self.layer.masksToBounds = YES;
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
    
}

-(void)setCurrentSelectIndex:(NSInteger)currentSelectIndex{
    
    if(currentSelectIndex>-1){
        
        NSInteger lastSelect = _currentSelectIndex;
        _currentSelectIndex = currentSelectIndex;
        if(lastSelect>-1){
            KKDSegmentBarItem *lastItem = [self.itemArray objectAtIndex:lastSelect];
            if(lastItem.itemType == ButtonItem){
                lastItem.enabled = YES;
            }
        }
        
        KKDSegmentBarItem *item = [self.itemArray objectAtIndex:currentSelectIndex];
        if(item.itemType == ButtonItem){
            item.enabled = NO;
        }
    
    }
    
}

-(void)setBarStyle:(BarStyle)barStyle{
//    DEBUG_LOG(@"%@",NSStringFromSelector(_cmd));
}

-(void)addItem:(KKDSegmentBarItem *)barItem{
    [itemArray addObject:barItem];
}

-(void)updateUI{
    
    NSInteger itemCount = [self.itemArray count];
    
    if(itemCount>0){
        
        CGFloat width = 0;
        CGFloat imageButtonWidth = 50;
        CGFloat height = self.frame.size.height;
        CGFloat contentWidth = 0;
        NSInteger imageButtonCount = 0;
        
        for(KKDSegmentBarItem *item in self.itemArray){
            if(item.itemType == ImageButtonItem){
                imageButtonCount ++;
            }
        }
        
        width = (self.frame.size.width-imageButtonWidth*imageButtonCount)/(itemCount - imageButtonCount);
        if(width<57){
            width = 57;
        }
        
        contentWidth = width*(itemCount-imageButtonCount)+imageButtonWidth*imageButtonCount;
        if(contentWidth>self.frame.size.width){
            self.contentSize = CGSizeMake(contentWidth, height);
        }
        
        for(NSInteger i =0;i<itemCount;i++){
            KKDSegmentBarItem *item = [self.itemArray objectAtIndex:i];
            item.tag = i;
            item.frame = itemCount == 1?CGRectMake(self.frame.size.width - 57, 0, 57, height):CGRectMake(i*width, 0, width-self.layer.borderWidth, height);
            if(item.itemType == ImageButtonItem){
                item.frame = itemCount == 1?CGRectMake(self.frame.size.width - 57, 0, 57, height):CGRectMake(i*width, 0, imageButtonWidth-self.layer.borderWidth, height);
            }
            
            [item addTarget:self action:@selector(onItemPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:item];
        }
        if(self.currentSelectIndex==-1){
            for(KKDSegmentBarItem *item in self.itemArray){
                if(item.itemType == ButtonItem){
                    self.currentSelectIndex = item.tag;
                    break;
                }
            }
        }
        
        titleLabel = [[UIButton alloc]initWithFrame:CGRectMake(1, 1, self.frame.size.width-49, self.frame.size.height-2)];
        titleLabel.layer.cornerRadius = 2.0f;
        titleLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [titleLabel addTarget:self action:@selector(onTitlePressed:) forControlEvents:UIControlEventTouchUpInside];
        titleLabel.layer.masksToBounds = YES;
        NSString *titleText = self.popTitle?self.popTitle:@"";
        [titleLabel setTitle:titleText forState:UIControlStateNormal];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [titleLabel setTitleColor:RGB_COLOR_WITH_0x(BlackText666Color) forState:UIControlStateNormal];
        [titleLabel setBackgroundImage:ImageWithColor(RGB_COLOR_WITH_0x(SelectBgColor)) forState:UIControlStateHighlighted];
        [self addSubview:titleLabel];
        if([self.itemArray count]==1){
            titleLabel.hidden = NO;
        }else{
            titleLabel.hidden = YES;
        }
        
    }

}

-(void)onTitlePressed:(id)sender{
    
    [self showPopView:self.frame];
    
}

-(void)onItemPressed:(id)sender{
    
    
    KKDSegmentBarItem *item = (KKDSegmentBarItem *)sender;
    
    if(item.itemType == ImageButtonItem){
        
        item.enabled = NO;
        [self showPopView:self.frame];
        
    }else{
        KKDSegmentBarItem *lastItem = [self.itemArray objectAtIndex:_currentSelectIndex];
        if(self.onItemSelect&&lastItem.tag!=item.tag){
            lastItem.enabled = YES;
            self.currentSelectIndex = item.tag;
            self.onItemSelect(sender);
            
        }
    }
    
}

-(void)showPopView:(CGRect)rect{
    
    if([_popViewValues count]>0){
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.bgButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [bgButton setFrame:[UIScreen mainScreen].bounds];
        [bgButton setBackgroundColor:[UIColor clearColor]];
        [bgButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [window addSubview:bgButton];
        UIView *popView = [self popView:_popViewValues width:self.frame.size.width];
        CGRect convertRect = [self.superview convertRect:self.frame toView:bgButton];
        
        CGRect popRect = popView.frame;
        popRect.origin.x = convertRect.origin.x;
        popRect.origin.y = convertRect.origin.y + convertRect.size.height - popRect.size.height/2;
        popView.frame = popRect;
        popView.alpha = 0.9;
        [bgButton addSubview:popView];
        
//        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(convertRect.origin.x + 1, convertRect.origin.y + 1, rect.size.width-49, rect.size.height-2)];
//        titleLabel.layer.cornerRadius = 2.0f;
//        titleLabel.layer.masksToBounds = YES;
//        titleLabel.text = self.popTitle;
//        titleLabel.backgroundColor = [UIColor whiteColor];
//        titleLabel.font = [UIFont systemFontOfSize:15.0f];
//        titleLabel.textColor = RGB_COLOR_WITH_0x(kBlackText666Color);//[UIColor blackColor];
//        [bgButton addSubview:titleLabel];
        titleLabel.hidden = NO;
        
        popView.alpha = 0.f;
        popView.transform = CGAffineTransformMakeScale(1.f, 0.0f);
        popView.layer.anchorPoint = CGPointMake(0.5,0.);
        [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            popView.transform = CGAffineTransformMakeScale(1.0f, 1.05f);
            float alpha = 245.0/255.0;
            popView.alpha = alpha;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                popView.transform = CGAffineTransformIdentity;
            } completion:nil];
        }];
        
    }
    
}

-(UIView *)popView:(NSArray *)popItems width:(CGFloat)width{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, (([popItems count]-1)/5 +1)*30+20)];
    view.backgroundColor = _popItemsBgColor;
    CGFloat buttonWidth = (width -10)/5;
    for(NSInteger i =0;i<[popItems count];i++){
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(5+i%5*buttonWidth, 10+i/5*30, buttonWidth, 30)];
        button.layer.cornerRadius = 3.0f;
        button.layer.masksToBounds = YES;
        button.tag = i;
        button.titleLabel.font = _popItemFont;
        [button addTarget:self action:@selector(popViewItemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[ImageWithColor(_popItemSelectColor) stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[ImageWithColor(RGB_COLOR_WITH_0x(SelectBgColor)) stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateDisabled];
        button.titleLabel.font = kSystemFont(13.0f);
        [button setTitle:[popItems objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:RGB_COLOR_WITH_0x(GrayColor) forState:UIControlStateDisabled];
        [button setTitleColor:RGB_COLOR_WITH_0x(BlackTextColor) forState:UIControlStateNormal];
        [button setTitleColor:RGB_COLOR_WITH_0x(WhiteColor) forState:UIControlStateHighlighted];
        [view addSubview:button];
    }
    return view;
    
}

-(void)popViewItemPressed:(id)sender{
    
    DEBUG_LOG(@"%@",NSStringFromSelector(_cmd));
    [self dismiss];
    if(self.onPopItemSelect){
        self.onPopItemSelect(sender);
    }
    
}

-(void)dismiss{
    
    [self.bgButton removeFromSuperview];
    if([self.itemArray count]==1){
        titleLabel.hidden = NO;
    }else{
        titleLabel.hidden = YES;
    }
    KKDSegmentBarItem *item = [itemArray lastObject];
    if(item.itemType == ImageButtonItem){
        item.enabled = YES;
    }
//    KKDSegmentBarItem *select = [itemArray objectAtIndex:_currentSelectIndex];
//    if(select.itemType == ButtonItem){
//        select.selected = YES;
//    }
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self updateUI];
}


@end
