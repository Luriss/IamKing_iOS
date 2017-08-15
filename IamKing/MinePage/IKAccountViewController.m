//
//  IKAccountViewController.m
//  IamKing
//
//  Created by Luris on 2017/8/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKAccountViewController.h"
#import "IKSettingNomalTableViewCell.h"
#import "IKChangePhoneNumberVC.h"
#import "IKChangePasswordVC.h"
#import "IKBindWeiXinVc.h"


@interface IKAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_phoneNumber;
}
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray     *titleArray;

@end

@implementation IKAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavTitle];
    [self initLeftBackItem];
    self.view.backgroundColor = IKGeneralLightGray;
    
    self.titleArray = @[@"手机号",@"微信绑定",@"修改密码"];
    
    _phoneNumber = [IKUSERDEFAULT objectForKey:IKLoginPhoneNumberKey];
    
    
    [self.view addSubview:self.tableView];
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"帐号设置";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    self.navigationView.titleView = title;
    
}


- (void)initLeftBackItem
{
    // 返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 00, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 50);
    [button setImage:[UIImage imageNamed:@"IK_back_white"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_back_white"] forState:UIControlStateHighlighted];
    
    self.navigationView.leftButton = button;
}



- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.rowHeight = 50;
        _tableView.backgroundColor = IKGeneralLightGray;
    }
    return _tableView;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else{
        return 2;
    }

}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    static  NSString *cellId = @"IKSettingNomalTableViewCellId";
    IKSettingNomalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[IKSettingNomalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
    
    if (section == 0) {
        cell.label.text = self.titleArray[0];
        cell.psLabel.text = _phoneNumber;
    }
    else{
        cell.label.text = self.titleArray[indexPath.row+1];
    }
    
    return cell;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    if (section == 0) {
        IKChangePhoneNumberVC *changeVc = [[IKChangePhoneNumberVC alloc] init];
        changeVc.phoneNumber = _phoneNumber;
        [self.navigationController pushViewController:changeVc animated:YES];
    }
    else{
        if (indexPath.row == 0) {
            IKBindWeiXinVc *bindWx = [[IKBindWeiXinVc alloc] init];
            [self.navigationController pushViewController:bindWx animated:YES];
        }
        else{
            IKChangePasswordVC *changeVc = [[IKChangePasswordVC alloc] init];
            [self.navigationController pushViewController:changeVc animated:YES];
        }
    }
 
}

- (void)backButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
