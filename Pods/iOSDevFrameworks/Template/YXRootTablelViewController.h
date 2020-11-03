//
//  YXRootTablelViewController.h
//  PerfectDoc
//
//  Created by tangyunchuan on 2019/11/28.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "BaseRootViewController.h"
#import "UIImage+Tint.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXRootTablelViewController : BaseRootViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
