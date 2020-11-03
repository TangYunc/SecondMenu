//
//  DXRefresh.m
//  HHRefreshDemo
//
//  Created by 张良玉 on 2018/9/30.
//  Copyright © 2018年 豫风. All rights reserved.
//

#import "YXRefresh.h"
@implementation YXRefresh

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    self = [super init];
    if (self) {
        if ([scrollView isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)scrollView;
            tableView.estimatedRowHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
            tableView.estimatedSectionHeaderHeight = 0;
        }
        if (@available(iOS 11.0, *)) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.refreshManager = [HHRefreshManager refreshWithDelegate:self scrollView:scrollView type:AnimationTypeNormal];
        self.refreshManager.isNeedHeadRefresh = NO;
        self.refreshManager.isNeedFootRefresh = NO;
    }
    return self;
}

- (void)beginRefreshWithType:(HHRefreshType)type{
    if (type == HHRefreshTypeHeader) {
        if (self.headerTarget) {
            if ([self.headerTarget respondsToSelector:self.headerAction]) {
                [self.headerTarget performSelector:self.headerAction];
            }
        }
        
        if (self.headerBlock) {
            self.headerBlock();
        }
    }else{
        if (self.footerTarget) {
            if ([self.footerTarget respondsToSelector:self.footerAction]) {
                [self.footerTarget performSelector:self.footerAction];
            }
        }
        
        if (self.footerBlock) {
            self.footerBlock();
        }
    }
}
@end
