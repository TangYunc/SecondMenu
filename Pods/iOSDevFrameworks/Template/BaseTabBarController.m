//
//  KKDTabBarController.m
//  Doctor
//
//  Created by 赵洋 on 15/5/13.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import "BaseTabBarController.h"
#import "ToolsHeader.h"
@interface BaseTabBarController ()<UITabBarControllerDelegate>
{
    BOOL __shouldAutorotate;
}
@property (nonatomic) CGFloat tabbarHeight;
@end

@implementation BaseTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 13, *)) {
        #ifdef __IPHONE_13_0
        UITabBarAppearance *appearance = [self.tabBar.standardAppearance copy];
        appearance.shadowImage = ImageWithColor(RGB_COLOR_WITH_0x(CellLineViewColor));
        appearance.shadowColor = [UIColor clearColor];
        appearance.backgroundColor = RGB_COLOR_WITH_0x(WhiteColor);
        self.tabBar.standardAppearance = appearance;
        #endif
    } else {
        [[UITabBar appearance] setShadowImage:ImageWithColor(RGB_COLOR_WITH_0x(CellLineViewColor))];
        [[UITabBar appearance] setBackgroundImage:ImageWithColor(RGB_COLOR_WITH_0x(WhiteColor))];
    }
    
    [UITabBar appearance].translucent = NO;

    //MARK:注册旋转屏幕的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(autorotateInterface:) name:@"InterfaceOrientation" object:nil];
}

-(void)viewWillLayoutSubviews{
    CGRect tabFrame = self.tabBar.frame;
    CGFloat tabHeight = self.tabbarHeight;
    tabFrame.size.height = tabHeight;
    tabFrame.origin.y = self.view.frame.size.height - tabHeight;
    self.tabBar.frame = tabFrame;
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    [self setupItem:childVc.tabBarItem];
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字

    // 设置子控制器的图片
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:childVc];
       // 添加为子控制器
    [self addChildViewController:nav];

}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    DEBUG_LOG(@"=========tabBarController.selectedIndex==========%lu",(unsigned long)tabBarController.selectedIndex);
    
    switch (tabBarController.selectedIndex) {
        case 1:
        {
        }
            break;
        case 2:
        {
        }
            break;
            
        default:
            break;
    }
}

- (void)setupItem:(UITabBarItem *)item
{
    // UIControlStateNormal状态下的文字属性
    
    UIColor *textColor = RGB_COLOR_WITH_0x(BlackTextColor);
    if (@available(iOS 13.0, *)) {
         #ifdef __IPHONE_13_0
        UITabBarAppearance *appearance = self.tabBar.standardAppearance;
            // 设置未被选中的颜色
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = @{NSForegroundColorAttributeName: textColor};
            // 设置被选中时的颜色
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = @{NSForegroundColorAttributeName: textColor};
        item.standardAppearance = appearance;
        #endif
    }else{
        UIFont *noneSelectFont = kSystemFont(11);
        UIFont *selectedFont = kSystemFont(11);
        NSDictionary *normalAttrs = @{NSForegroundColorAttributeName:textColor,NSFontAttributeName:noneSelectFont};
        NSDictionary *selectedAttrs = @{NSForegroundColorAttributeName:textColor,NSFontAttributeName:selectedFont};
        // 统一给所有的UITabBarItem设置文字属性
        // 只有后面带有UI_APPEARANCE_SELECTOR的属性或方法, 才可以通过appearance对象来统一设置
        [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
        [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        item.titlePositionAdjustment = UIOffsetMake(0, -4);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- 旋转通知
-(void)autorotateInterface:(NSNotification *)notifition
{
    
    __shouldAutorotate = [notifition.object boolValue];
    NSLog(@"接收到的通知>> %d", __shouldAutorotate);
}

/**
 *
 *  @return 是否支持旋转
 */
-(BOOL)shouldAutorotate
{
    return __shouldAutorotate;
}

/**
 *  适配旋转的类型
 *
 *  @return 类型
 */
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    if (!__shouldAutorotate) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskAll;
}

@end

@implementation UINavigationController (Autorotate)
- (BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end

