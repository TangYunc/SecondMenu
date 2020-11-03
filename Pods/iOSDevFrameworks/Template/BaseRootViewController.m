//
//  BaseRootViewController.m
//  KKDictionary
//
//  Created by KungJack on 7/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import "BaseRootViewController.h"
#import "NSString+KKDSizeWithFont.h"
#import "UINavigationBar+NavAlpha.h"
#import "UINavigationController+NavAlpha.h"
#import "BaseWebViewController.h"
#import "ToolsHeader.h"

@interface BaseRootViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init{

    self = [super init];
    if(self){
//        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

-(BOOL)isVisible
{
    return (self.isViewLoaded && self.view.window);
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navBarTintColor = RGB_COLOR_WITH_0x(WhiteColor);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.hideShadow = self.isHiddenShadowLine;
    
    if (!self.isHiddenShadowLine) {
        [self.navigationController.navigationBar setShadowImage:ImageWithColor(RGB_COLOR_WITH_0x(BgViewColor))];
    }else{
        [self.navigationController.navigationBar setShadowImage:nil];
    }
     [self.navigationController setNavigationBarHidden:[self hiddenNavigationBar] animated:YES];
    
    self.tabBarController.tabBar.tintColor = RGB_COLOR_WITH_0x(0x2087fb);
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isHiddenShadowLine = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.tintColor = RGB_COLOR_WITH_0x(0x2087fb);
    self.view.backgroundColor = RGB_COLOR_WITH_0x(BgViewColor);
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    if([[self.navigationController viewControllers] count]>1){
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 45, 40);
        backButton.imageEdgeInsets = UIEdgeInsetsMake( 0, 0, 0, 35);
        [backButton setTitleColor:RGB_COLOR_WITH_0x(RedColor) forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(onBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backItem;
        self.leftBackButton = backButton;
        self.backItemType = NavigationBackItemTypeDefault;
    }
}

-(void)setBackItemType:(NavigationBackItemType)backItemType{
    _backItemType = backItemType;
    if (backItemType == NavigationBackItemTypeWhite) {
        [self setNavigationBackItemImage:@"back_click_white_icon" transitionMaskImage:@"back_normal_white_icon"];
    }else {
        [self setNavigationBackItemImage:@"back_click_icon" transitionMaskImage:@"back_normal_icon"];
    }
}

-(void)setNavigationBackItemImage:(NSString *)imageName{
    [self setNavigationBackItemImage:imageName transitionMaskImage:imageName];
}
-(void)setNavigationBackItemImage:(NSString *)imageName transitionMaskImage:(NSString *)transitionMaskImageName{
    [self.leftBackButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [self.leftBackButton setImage:[UIImage imageNamed:transitionMaskImageName] forState:UIControlStateNormal];
}

-(UIImageView *)blankViewNoticeImage
{
    if (!_blankViewNoticeImage) {
        _blankViewNoticeImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, kGetWidth(125), kScreenWidth, kGetWidth(200))];
        _blankViewNoticeImage.backgroundColor = [UIColor clearColor];
        _blankViewNoticeImage.userInteractionEnabled = YES;
        _blankViewNoticeImage.contentMode = UIViewContentModeCenter|UIViewContentModeTop;
        [self.view addSubview:_blankViewNoticeImage];
        _blankViewNoticeImage.hidden = YES;
    }
    return _blankViewNoticeImage;
}

-(void)setBlankViewNoticeImage:(UIImage *)noticeImage noticeText:(NSString *)noticeText
{
    self.blankViewNoticeImage.image = noticeImage;
    CGSize imageSize = noticeImage.size;
    self.blankViewNoticeImage.height = imageSize.height;
    if (noticeText) {
        CGFloat labelWidth = kScreenWidth - 2 * kGetWidth(15);
        CGFloat labelHeigth = [noticeText boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kSystemFitFont(17)} context:nil].size.height;
        UILabel *label = [UIViewUtil creatLableWithFrame:CGRectMake(kGetWidth(15), self.blankViewNoticeImage.height+kGetWidth(25), labelWidth, labelHeigth) font:kSystemFitFont(17) textAlignment:NSTextAlignmentCenter textColor:RGB_COLOR_WITH_0x(BlackText999Color)];
        label.text = noticeText;
        label.numberOfLines = 2;
        [self.blankViewNoticeImage addSubview:label];
    }
    self.blankViewNoticeImage.hidden = NO;
}

-(UIButton *)rigthItemButton{
    if (!_rigthItemButton) {
        _rigthItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rigthItemButton.frame = CGRectMake(0, 0, kGetWidth(60), 44);
        _rigthItemButton.titleLabel.font = kSystemFitFont(15);
        [_rigthItemButton setTitleColor:RGB_COLOR_WITH_0x(BlackTextColor) forState:UIControlStateNormal];
        [_rigthItemButton setTitleColor:RGB_COLOR_WITH_0x(BlackText999Color) forState:UIControlStateSelected];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rigthItemButton];
    }
    return _rigthItemButton;
}

-(void)setNavigationRigthItemTitle:(NSString *)title itemImage:(UIImage *)image action:(SEL)action
{
    if (image) {//有图
        [self.rigthItemButton setImage:image forState:UIControlStateNormal];
        if (title&&![title isEqualToString:@""]) {//有图有字
            CGSize size = [title getStringSizeWithFont:kSystemFitFont(17)];
            [self.rigthItemButton setTitle:title forState:UIControlStateNormal];
            if (size.width+image.size.width>self.rigthItemButton.width) {
                self.rigthItemButton.width = size.width+image.size.width;
            }
            self.rigthItemButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -(self.rigthItemButton.width-image.size.width-size.width));
            self.rigthItemButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, self.rigthItemButton.width-size.width-image.size.width);
        }else{//有图无字
            self.rigthItemButton.imageEdgeInsets = UIEdgeInsetsMake(0, self.rigthItemButton.width-image.size.width-5, 0, 5);
        }
        if (action) {
            [self.rigthItemButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        }
    }else{//没图
        if (title&&![title isEqualToString:@""]) {//没图有字
            CGSize size = [title getStringSizeWithFont:kSystemFitFont(17)];
            [self.rigthItemButton setTitle:title forState:UIControlStateNormal];
            if (size.width>self.rigthItemButton.width) {
                self.rigthItemButton.width = size.width;
            }
            self.rigthItemButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -(self.rigthItemButton.width-size.width));
            if (action) {
                [self.rigthItemButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
            }
        }else{//没图无字
            return;
        }
    }
}

-(void)setNavigationRigthItemTitle:(NSString *)title itemImage:(UIImage *)image{
    [self setNavigationRigthItemTitle:title itemImage:image action:nil];
}

-(void)onBackButtonPressed:(id)sender{
    
    if(self.backAction){
        self.backAction(sender);
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)addTapGestureEndEditing{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEndEditingClick)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}

-(void)tapEndEditingClick{
    [self.view endEditing:NO];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 如果 Self 是 NaivationController 的 根试图控制器, 则不允许启动手势
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return YES;
    }else{
        if (self == [self.navigationController.viewControllers firstObject]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    UIView *touchView = touch.view;
    if ([self isTableViewCellContentView:touchView]) {
        return NO;
    }
    return YES;
}

// 获取视图所在的视图控制器
- (BOOL )isTableViewCellContentView:(UIView *)view
{
    if ([view isKindOfClass:[UITableViewCell class]]) {
        return YES;
    }
    // 1.获取当前视图的下一响应者
    UIResponder *responder = view.nextResponder;
    // 2.判断当前对象是否是视图控制器
    while (YES) {
        if ([responder isKindOfClass:[UITableViewCell class]]) {
            return YES;
        } else {
            responder = responder.nextResponder;
            if (responder == nil || [responder isKindOfClass:[UIViewController class]]) {
                return NO;
            }
        }
    }
}

- (void)addChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc willMoveToParentViewController:self];
    [self addChildViewController:childVc];
    [self.view addSubview:childVc.view];
    childVc.view.frame = self.view.bounds;
}

- (void)removeChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc.view removeFromSuperview];
    [childVc willMoveToParentViewController:nil];
    [childVc removeFromParentViewController];
}

- (BOOL)hiddenNavigationBar{
    return NO;
}

/// GrowingIO使用 Universal Link 唤醒APP
/// @param activity_url 要跳转的地址
- (void)jumpControllerWhenIsGrowingIODeeplinkHandlerBy:(NSString *)activity_url {
    [KUserDefault synchronize];
    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *navigationController = tabBar.selectedViewController;
    [navigationController popToRootViewControllerAnimated:NO];
    BaseWebViewController *controller = [[BaseWebViewController alloc] init];
    controller.urlString = activity_url;
    [navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
