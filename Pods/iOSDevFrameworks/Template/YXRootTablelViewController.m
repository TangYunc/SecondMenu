//
//  YXRootTablelViewController.m
//  PerfectDoc
//
//  Created by tangyunchuan on 2019/11/28.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "YXRootTablelViewController.h"
#import "ToolsHeader.h"
@interface YXRootTablelViewController ()

@end

@implementation YXRootTablelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                         RGB_COLOR_WITH_0x(BlackTextColor), NSForegroundColorAttributeName,
                                                                         [UIFont systemFontOfSize:20.0], NSFontAttributeName,
                                                                         nil]];
        self.view.backgroundColor = RGB_COLOR_WITH_0x(RootVCBgColor);//[UIColor whiteColor];
        
        if([[self.navigationController viewControllers] count]>1){
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backButton.frame = CGRectMake(0, 0, 44, 44);
            [backButton setImage:[[UIImage imageNamed:@"back_normal_icon.png"] yx_imageWithTintColor:RGB_COLOR_WITH_0x(WhiteColor)] forState:UIControlStateNormal];
            backButton.imageEdgeInsets = UIEdgeInsetsMake(5,isIOS6?7:0, 5,isIOS6?27:34);// 20 34
            [backButton setTitleColor:RGB_COLOR_WITH_0x(RedColor) forState:UIControlStateNormal];
            [backButton addTarget:self action:@selector(onBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
            self.navigationItem.leftBarButtonItem = backItem;
            self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
        }
        
    //    UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    //    self.tableView.tableFooterView = foot;
        
        self.blankViewNoticeImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, kGetWidth(125), kScreenWidth, kGetWidth(200))];
        self.blankViewNoticeImage.backgroundColor = [UIColor clearColor];
        self.blankViewNoticeImage.contentMode = UIViewContentModeCenter|UIViewContentModeTop;
        [self.view addSubview:self.blankViewNoticeImage];
        self.blankViewNoticeImage.hidden = YES;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[ImageWithColor(RGB_COLOR_WITH_0x(NavBgColor)) stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:ImageWithColor([UIColor clearColor])];
//        self.navigationController.navigationBar.barTintColor = RGB_COLOR_WITH_0x(kNavBgColor);
//        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB_COLOR_WITH_0x(kBlackText333Color),NSFontAttributeName:kSystemFont(18)}];
    self.tabBarController.tabBar.tintColor = RGB_COLOR_WITH_0x(BlueColor);

    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     RGB_COLOR_WITH_0x(WhiteColor), NSForegroundColorAttributeName,
                                                                     [UIFont systemFontOfSize:20.0], NSFontAttributeName,
                                                                     nil]];
    
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

#pragma mark - tableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kGetWidth(0);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
