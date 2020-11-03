//
//  KKDSegmentBar.m
//  KKDictionary
//
//  Created by KungJack on 19/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import "KKDSegmentBar.h"
#import "ToolsHeader.h"
@interface KKDSegmentBar (){
    UIScrollView *contentView;
    
    NSInteger lastSelectIndex;
    NSMutableArray *itemArray;
}
@property(nonatomic,strong)UIScrollView *contentView;
@end

@implementation KKDSegmentBar

@synthesize contentView;
@synthesize items;
@synthesize enableItems;
@synthesize width;
@synthesize currentSelectIndex;
@synthesize onItemSelect;


-(void)dealloc{
    [self removeObserver:self forKeyPath:@"items"];
    [self removeObserver:self forKeyPath:@"currentSelectIndex"];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        itemArray = [[NSMutableArray alloc]init];
        self.contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        contentView.showsHorizontalScrollIndicator = NO;
        [self addSubview:contentView];
        [self addObserver:self forKeyPath:@"items" options:0 context:@"itemsContent"];
        [self addObserver:self forKeyPath:@"currentSelectIndex" options:0 context:@"currentSelectIndexContent"];
        
    }
    return self;
}

-(void)makeUpMainView{
    
    if([itemArray count]>0){
        [itemArray removeAllObjects];
    }
    
    for(id view in [contentView subviews]){
        if([view isKindOfClass:[UIButton class]]){
            
            if(!self.isHasImage){
                _itemBackgroudSelectImage = nil;
                self.itemSelectColor = [UIColor whiteColor];
                self.itemFont = kSystemFont(12.0f);
            }
            [view removeFromSuperview];
            
        }
    }
    
    if(width==0){
        width = self.frame.size.width/[items count];
        if(width<57){
            width = 57;
            contentView.contentSize = CGSizeMake(width*[items count], self.frame.size.height);
        }
    }
    if([items count]>0){
        
        
        if(!_itemBackgroudSelectImage){
            self.layer.borderColor = RGB_COLOR_WITH_0x(RedColor).CGColor;
            self.layer.borderWidth = 1.0f;
            self.layer.masksToBounds = YES;
            _itemBackgroudSelectImage = [ImageWithColor(RGB_COLOR_WITH_0x(RedColor)) stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        }
        if(!_itemFont){
            self.itemFont = kSystemFont(12.0f);
        }
        if(!_itemSelectColor){
            self.itemSelectColor = [UIColor whiteColor];
        }
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width*[items count], self.frame.size.height)];
        bgView.backgroundColor =RGB_COLOR_WITH_0x(RedColor);
        [contentView addSubview:bgView];
        for(int i =0;i<[items count];i++){
            UIButton *item = [UIViewUtil creatButtonWithFrame:CGRectMake(width*i, 0, width- self.layer.borderWidth, self.frame.size.height) font:_itemFont title:[items objectAtIndex:i] titleColor:RGB_COLOR_WITH_0x(BlackTextColor) bgNormalImage:_itemBackgroudImage bgHightLightImage:_itemBackgroudHighLightImage];
            item.tag = i;
            if(enableItems&&[enableItems count]==[items count]){
                NSString *enableName = [items objectAtIndex:i];
                [item setTitle:enableName forState:UIControlStateDisabled];
                NSString *enable = [enableItems objectAtIndex:i];
                if([enable isEqualToString:@"0"]){
                    item.enabled = NO;
                }
            }else{
                [item setTitle:@"—" forState:UIControlStateDisabled];
            }
            item.backgroundColor = [UIColor whiteColor];
            [item setBackgroundImage:_itemBackgroudSelectImage forState:UIControlStateSelected];
            [item setBackgroundImage:[ImageWithColor(RGB_COLOR_WITH_0x(SelectBgColor)) stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateDisabled];
            [item setTitleColor:_itemSelectColor forState:UIControlStateSelected];
            [item setTitleColor:RGB_COLOR_WITH_0x(GrayColor) forState:UIControlStateDisabled];
            [item addTarget:self action:@selector(onItemPressed:) forControlEvents:UIControlEventTouchUpInside];
            if([[items objectAtIndex:i] isEqualToString:@""]){
                item.enabled = NO;
            }
            [contentView addSubview:item];
            [itemArray addObject:item];
        }
    }
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    if([keyPath isEqualToString:@"items"]){
        [self makeUpMainView];
        for(int i=0; i<[items count];i++){
            if(enableItems&&[enableItems count]==[items count]){
                NSString *item = [enableItems objectAtIndex:i];
                if(![item isEqualToString:@"0"]){
                    self.currentSelectIndex = i;
                    return;
                }
            }else{
                NSString *item = [items objectAtIndex:i];
                if(![item isEqualToString:@""]){
                    self.currentSelectIndex = i;
                    return;
                }
            }
        }
    }
    
    if([keyPath isEqualToString:@"currentSelectIndex"]){
        
        UIButton *button = [itemArray objectAtIndex:lastSelectIndex];
        button.selected = NO;
        UIButton *currentButton = [itemArray objectAtIndex:currentSelectIndex];
        currentButton.selected = YES;
        lastSelectIndex = currentSelectIndex;
        
    }
    
}

-(void)onItemPressed:(id)sender{
    
    UIButton *currentButton = (UIButton *)sender;
    self.currentSelectIndex = currentButton.tag;

    if(onItemSelect){
        onItemSelect(sender);
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
