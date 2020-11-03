//
//  UITableView+scrollBottom.m
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/4/24.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "UITableView+scrollBottom.h"

@implementation UITableView (scrollBottom)

- (void)scrollToBottom:(BOOL)animated{
    NSUInteger rows = [self numberOfRowsInSection:0];
    if (rows > 0 && (self.contentSize.height > self.bounds.size.height)) {
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}

@end
