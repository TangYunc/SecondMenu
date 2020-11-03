//
//  UIScrollView+DXRefresh.h
//  DXRefresh
//
//  Created by xiekw on 10/11/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Refresh)

/// 释放刷新控件，一般的项目中不需要添加
- (void)removeRefreshing;

- (void)addHeaderWithTarget:(id)target action:(SEL)action;

- (void)addHeaderWithBlock:(dispatch_block_t)block;

- (void)headerEndRefreshing;

- (BOOL)isHeaderRefreshing;


- (void)addFooterWithTarget:(id)target action:(SEL)action;

- (void)addFooterWithBlock:(dispatch_block_t)block;

- (void)footerEndRefreshing;

- (BOOL)isFooterRefreshing;

- (void)setNoMoreString:(NSString *)noMoreString;
- (void)setFooterIsNoMore:(BOOL)isNoMore;
- (void)setHeaderIsNoMore:(BOOL)isNoMore;

- (void)setIsNeedRefresh:(BOOL)isNeedRefresh;
- (void)setIsNeedHeadRefresh:(BOOL)isNeedHeadRefresh;
- (void)setIsNeedFootRefresh:(BOOL)isNeedFootRefresh;
@end
