//
//  DXRefresh.h
//  HHRefreshDemo
//
//  Created by 张良玉 on 2018/9/30.
//  Copyright © 2018年 豫风. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHRefreshManager.h"

@interface YXRefresh : NSObject<HHRefreshManagerDelegate>

@property (nonatomic, strong) HHRefreshManager *refreshManager;

@property (nonatomic ) SEL headerAction;
@property (nonatomic ) SEL footerAction;

@property (nonatomic ,strong) dispatch_block_t headerBlock;
@property (nonatomic ,strong) dispatch_block_t footerBlock;

@property (nonatomic ,weak) id headerTarget;
@property (nonatomic ,weak) id footerTarget;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;
@end
