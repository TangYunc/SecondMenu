//
//  UIScrollView+DXRefresh.m
//  DXRefresh
//
//  Created by xiekw on 10/11/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import <objc/runtime.h>
#import "YXRefresh.h"

@interface UIScrollView ()
@property (nonatomic ,strong)YXRefresh *yxRefresh;

@end

@implementation UIScrollView (Refresh)

static char DXYXRefreshKey;

-(YXRefresh *)yxRefresh{
    YXRefresh *yxRefresh = objc_getAssociatedObject(self, &DXYXRefreshKey);
    if (!yxRefresh) {
        yxRefresh = [[YXRefresh alloc]initWithScrollView:self];
        objc_setAssociatedObject(self, &DXYXRefreshKey, yxRefresh, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return yxRefresh;
}

- (void)removeRefreshing{
    objc_removeAssociatedObjects(self);
}

- (void)addHeaderWithTarget:(id)target action:(SEL)action
{
    self.yxRefresh.headerTarget = target;
    self.yxRefresh.headerAction = action;
    self.yxRefresh.refreshManager.isNeedHeadRefresh = YES;
}

- (void)headerEndRefreshing
{
    [self.yxRefresh.refreshManager endRefreshWithType:HHRefreshTypeHeader];
}

- (BOOL)isHeaderRefreshing
{
    return self.yxRefresh.refreshManager.isHeaderRefresh;
}

- (void)addFooterWithTarget:(id)target action:(SEL)action
{
    self.yxRefresh.footerTarget = target;
    self.yxRefresh.footerAction = action;
    self.yxRefresh.refreshManager.isNeedFootRefresh = YES;
}

- (void)footerEndRefreshing
{
    [self.yxRefresh.refreshManager endRefreshWithType:HHRefreshTypeFooter];
}

- (BOOL)isFooterRefreshing
{
    return self.yxRefresh.refreshManager.isFooterRefresh;
}

- (void)addHeaderWithBlock:(dispatch_block_t)block
{
    self.yxRefresh.headerBlock = block;
}

- (void)addFooterWithBlock:(dispatch_block_t)block
{
    self.yxRefresh.footerBlock = block;
}

- (void)setNoMoreString:(NSString *)noMoreString{
    self.yxRefresh.refreshManager.noMoreString = noMoreString;
}

- (void)setFooterIsNoMore:(BOOL)isNoMore{
    self.yxRefresh.refreshManager.isFooterNoMore = isNoMore;
}

- (void)setHeaderIsNoMore:(BOOL)isNoMore{
    self.yxRefresh.refreshManager.isHeaderNoMore = isNoMore;
}

- (void)setIsNeedRefresh:(BOOL)isNeedRefresh{
    self.yxRefresh.refreshManager.isNeedRefresh = isNeedRefresh;
}

- (void)setIsNeedHeadRefresh:(BOOL)isNeedHeadRefresh{
    self.yxRefresh.refreshManager.isNeedHeadRefresh = isNeedHeadRefresh;
}

- (void)setIsNeedFootRefresh:(BOOL)isNeedFootRefresh{
    self.yxRefresh.refreshManager.isNeedFootRefresh = isNeedFootRefresh;
}
@end
