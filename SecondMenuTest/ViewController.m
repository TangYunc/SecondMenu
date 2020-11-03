//
//  ViewController.m
//  SecondMenuTest
//
//  Created by tangyunchuan on 2020/11/3.
//

#import "ViewController.h"
#import "MenuViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self demo7];
}

- (void)demo7{
    UIButton *btnView = [UIViewUtil creatButtonWithFrame:CGRectMake(100, 200, 100, 60) font:kSystemFitFont(13) title:@"测试tableview二级菜单显示与隐藏" titleColor:RGB(111, 111, 111) bgNormalImage:nil bgHightLightImage:nil];
    [btnView addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnView];
    
}

- (void)btnClick {
    
    MenuViewController *menuVC = [[MenuViewController alloc] init];
    
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:menuVC];
    navigation.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navigation animated:NO completion:^{

    }];
//    [self.navigationController pushViewController:navigation animated:YES];
}


@end
