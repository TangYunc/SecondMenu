//
//  UIButton+AddClickArea.h
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/7/22.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

/**
 [button setEnlargeEdge:80];
 //或者，两个方法相同
 [button setEnlargeEdgeWithTop:20 right:20 bottom:20 left:50];
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (AddClickArea)

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

- (void)setEnlargeEdge:(CGFloat) size;

@end

NS_ASSUME_NONNULL_END
