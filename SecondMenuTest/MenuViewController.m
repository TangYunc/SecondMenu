//
//  MenuViewController.m
//  SecondMenuTest
//
//  Created by tangyunchuan on 2020/11/3.
//

#import "MenuViewController.h"

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL status[10]; //记录每个单元格的状态   默认no闭合
}

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItems];
    [self setupSubviews];
}

-(void)setNavigationItems{
    
    UIButton *btnView = [UIViewUtil creatButtonWithFrame:CGRectMake(100, 200, 100, 60) font:kSystemFitFont(13) title:@"返回" titleColor:RGB(111, 111, 111) bgNormalImage:nil bgHightLightImage:nil];
    [btnView addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc]initWithCustomView:btnView];
    
    self.navigationItem.leftBarButtonItem = rightItem2;
}

- (void)setupSubviews {
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    //tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight + kStatusBarHeigth, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped]; //采用group分组样式
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.tableView];
    //默认第一个分组是打开的
//    status[0] = YES;
}

#pragma mark------tableview处理
//三个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}
//每个分组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    BOOL closeAge = status[section];
    //关闭显示为0行
    if (closeAge == NO) {
        return 0;
    }
    
    return 3;
}

//UITableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cell_id = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        cell.backgroundColor = [UIColor orangeColor];
        cell.textLabel.textColor = [UIColor cyanColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"设备名称%ld", (long)indexPath.row];
    return cell;
}
//自定义section的header view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIControl *titileView = [[UIControl alloc] initWithFrame:CGRectZero];
    titileView.backgroundColor = [UIColor greenColor];
    titileView.tag = section;
    [titileView addTarget:self action:@selector(sectionAction:) forControlEvents:UIControlEventTouchUpInside];
    //设置  头视图的标题什么的
    UIImageView *firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 30, 30)];
    firstImageView.backgroundColor = [UIColor redColor];
    firstImageView.image = [UIImage imageNamed:@"share.png"];
    [titileView addSubview:firstImageView];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(25+30, 10, 100, 30)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textColor = [UIColor blackColor];
    titleLable.font = [UIFont systemFontOfSize:18];
    titleLable.text = [NSString stringWithFormat:@"设备组%ld", (long)section];
    [titleLable sizeToFit];
    [titileView addSubview:titleLable];
    
    UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-30-20, 10, 30, 30)];
    lastImageView.backgroundColor = [UIColor redColor];
    lastImageView.image = [UIImage imageNamed:@"cellIndat"];
    [titileView addSubview:lastImageView];
    
    return titileView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
//点击section的header view的方法实现，保存当前section的闭合状态
- (void)sectionAction:(UIControl *)control{
    
    NSInteger section = control.tag;
    
    status[section] = !status[section];
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade]; //刷新制定单元格
    
}
//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //选中单元格的表现
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DEBUG_LOG("%ld---%ld", (long)indexPath.section, (long)indexPath.row);
//    [self.navigationController pushViewController:[[EquipmentDeatilViewController alloc] init] animated:YES];
}

//section的header view的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}


#pragma mark -- 按钮事件
- (void)btnClick{
    [self dismissViewControllerAnimated:NO completion:nil];
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
