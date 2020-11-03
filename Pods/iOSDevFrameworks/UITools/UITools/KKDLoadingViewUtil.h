//
//  KKDLoadingViewUtil.h
//  KKDictionary
//
//  Created by KungJack on 14/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKDLoadingViewUtil : NSObject

+(void)showLoading:(BOOL)screemLock;
+(void)showLoading:(BOOL)screemLock title:(NSString *)title;
+(void)showLoading:(BOOL)screemLock title:(NSString *)title intercept:(BOOL)intercept;
+(void)dismissLoading;
+(void)toast:(NSString *)content time:(float)time;

@end
