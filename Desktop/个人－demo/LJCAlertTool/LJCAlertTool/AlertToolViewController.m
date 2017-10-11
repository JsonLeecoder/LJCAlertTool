//
//  AlertToolViewController.m
//  LJCAlertTool
//
//  Created by jiachen on 17/1/9.
//  Copyright © 2017年 jiachen. All rights reserved.
//

#import "AlertToolViewController.h"
#import "AlertTools.h"
#import "UIViewController+HUD.h"


@interface AlertToolViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * titleArray;

@end

@implementation AlertToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"alertTool";
    _titleArray = @[@"定位",@"拨打",@"联网"];
    
//    [self showHudInView:self.view hint:nil];
    [self creatTableView];
    // Do any additional setup after loading the view.
}

- (void)creatTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"CELL";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //定位
        [AlertTools showTipAlertViewWith:self title:@"允许定位开关" message:@"应用未获取定位服务授权，请进入系统[设置]>[隐私]>[定位服务]中打开开关，并允许使用定位服务" buttonTitle:@"设置" buttonStyle:AlertLocated];
    }else if(indexPath.row == 1){
        //拨打电话
        [AlertTools showTipAlertViewWith:self title:@"每天07:30-20:00,\n竭诚为您服务" message:nil buttonTitle:@"确认拨打" buttonStyle:AlertTelephont];
        
    }else{
        //联网
        [AlertTools showTipAlertViewWith:self title:@"检测到网络未打开" message:@"请确保移动网络或wifi处于打开状态" buttonTitle:@"设置" buttonStyle:AlertNetWork];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
