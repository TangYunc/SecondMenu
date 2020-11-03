//
//  BaseRootViewController.h
//  KKDictionary
//
//  Created by KungJack on 7/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger ,NavigationBackItemType) {
    NavigationBackItemTypeDefault,
    NavigationBackItemTypeWhite
};

@interface BaseRootViewController : UIViewController

@property(nonatomic ,copy) void (^backAction)(id sender);
@property (nonatomic ,assign) NavigationBackItemType backItemType;

@property (nonatomic ,weak) UIButton *leftBackButton;
@property(nonatomic,readonly) BOOL isVisible;

@property(nonatomic ) BOOL isHiddenShadowLine;

@property(nonatomic ,strong) UIImageView *blankViewNoticeImage;

@property(nonatomic ,strong) UIButton *rigthItemButton;

@property (nonatomic ,strong) void(^viewUpdateBlock) (void);

@property (nonatomic ) BOOL isRequesting;

/// 设置NavigationBar返回图片
-(void)setNavigationBackItemImage:(NSString *)imageName;
-(void)setNavigationBackItemImage:(NSString *)imageName transitionMaskImage:(NSString *)transitionMaskImageName;

-(void)setNavigationRigthItemTitle:(NSString *)title itemImage:(UIImage *)image action:(SEL)action;
-(void)setNavigationRigthItemTitle:(NSString *)title itemImage:(UIImage *)image;

-(void)setBlankViewNoticeImage:(UIImage *)noticeImage noticeText:(NSString *)noticeText;

-(void)onBackButtonPressed:(id)sender;

-(void)addTapGestureEndEditing;

- (void)addChildVc:(UIViewController *)childVc;
- (void)removeChildVc:(UIViewController *)childVc;

/**
 控制导航栏显示与隐藏

 @return 在需要隐藏的子类中，重写此方法，返回YES即可
 */
- (BOOL)hiddenNavigationBar;
@end
