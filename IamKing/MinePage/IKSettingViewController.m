//
//  IKSettingViewController.m
//  IamKing
//
//  Created by Luris on 2017/8/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSettingViewController.h"
#import "IKSettingNomalTableViewCell.h"
#import "IKAccountViewController.h"
#import "IKContactUsViewController.h"
#import "IKFeedbackViewController.h"



@interface IKLoginoutTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *logoImage;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIView *bgView;


@end

@implementation IKLoginoutTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews
{
    [self.contentView addSubview:self.bgView];

    [_bgView addSubview:self.label];
    [_bgView addSubview:self.logoImage];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(90);
    }];
    
    
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left);
        make.centerY.equalTo(_bgView.mas_centerY);
        make.width.and.height.mas_equalTo(18);
    }];
    
    
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView.mas_top);
        make.left.equalTo(_logoImage.mas_right).offset(5);
        make.right.equalTo(_bgView.mas_right);
        make.bottom.equalTo(_bgView.mas_bottom);
    }];
}



- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont boldSystemFontOfSize:15.0f];
        _label.textColor = IKGeneralRed;
        _label.textAlignment = NSTextAlignmentLeft;
        _label.text = @"退出帐号";
    }
    return _label;
}


- (UIView *)bgView
{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
    }
    return _bgView;
}


- (UIImageView *)logoImage
{
    if (_logoImage == nil) {
        _logoImage = [[UIImageView alloc] init];
        [_logoImage setImage:[UIImage imageNamed:@"IK_loginout_red"]];
    }
    return _logoImage;
}

@end


@interface IKSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray     *titleArray;

@end

@implementation IKSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavTitle];
    [self initLeftBackItem];
    self.view.backgroundColor = IKGeneralLightGray;
    
    self.titleArray = @[@"黑名单",@"账号设置",@"意见反馈",@"联系国王"];
    
    [self.view addSubview:self.tableView];
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"我的设置";
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
        _tableView.backgroundColor = IKGeneralLightGray;
    }
    return _tableView;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    else if (section == 1){
        return 2;
    }
    else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section != 2) {
        static  NSString *cellId = @"IKSettingNomalTableViewCellId";
        IKSettingNomalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKSettingNomalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
        
        if (section == 0) {
            cell.label.text = self.titleArray[indexPath.row];
        }
        else{
            cell.label.text = self.titleArray[indexPath.row+2];
        }
        
        
        return cell;
    }
    else{ //
        static  NSString *cellId = @"IKLoginoutTableViewCellId";
        IKLoginoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKLoginoutTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
        
        return cell;
    }
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
        if (indexPath.row == 0) {
            
        }
        else{
            IKAccountViewController *account = [[IKAccountViewController alloc] init];
            [self.navigationController pushViewController:account animated:YES];
        }
    }
    else if (section == 1){
        if (indexPath.row == 0) {
            IKFeedbackViewController *feedback = [[IKFeedbackViewController alloc] init];
            [self.navigationController pushViewController:feedback animated:YES];
        }
        else{
            IKContactUsViewController *contactUs = [[IKContactUsViewController alloc] init];
            [self.navigationController pushViewController:contactUs animated:YES];
        }
    }
    else{
        
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
