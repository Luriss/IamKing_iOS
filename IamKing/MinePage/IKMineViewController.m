//
//  IKMineViewController.m
//  IamKing
//
//  Created by Luris on 2017/7/29.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKMineViewController.h"
#import "IKNavIconView.h"
#import "IKLoginView.h"
#import "IKSettingTableViewCell.h"
#import "IKSettingHeaderTableViewCell.h"

@interface IKMineViewController ()<IKLoginViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CGFloat _oldLoginViewCenterY;
}


@property(nonatomic, strong)IKLoginView *loginView;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, copy)NSArray       *imageNameArray;
@property(nonatomic, copy)NSArray       *titleArray;
@property(nonatomic, copy)NSString      *loginStatus;

@property(nonatomic, assign)BOOL         isCompanyVersion;


@end

@implementation IKMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _oldLoginViewCenterY = 0;

    _loginStatus = [IKUSERDEFAULT objectForKey:IKLoginSccuessKey];

    if ([_loginStatus isEqualToString:@"1"]) {
        [self addTableView];
    }
    else{
        [self initNavLogo];
        [self initLoginView];
    }
    
    
    [IKNotificationCenter addObserver:self selector:@selector(mineVcKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [IKNotificationCenter addObserver:self selector:@selector(mineVcKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _loginStatus = [IKUSERDEFAULT objectForKey:IKLoginSccuessKey];

    if ([_loginStatus isEqualToString:@"1"]) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}


- (void)setResourceData
{
    NSString *versionType = [IKUSERDEFAULT objectForKey:IKVersionTypeKey];

    if ([versionType isEqualToString:@"1"]) {
        self.imageNameArray = @[@"IK_dealResume",@"IK_managerJob",@"IK_star_hollow_grey",@"IK_companyInfo",@"IK_companyconfirm",@"IK_setting"];
        self.titleArray = @[@"简历处理",@"职位管理",@"收藏简历",@"公司信息",@"公司认证",@"我的设置"];
        _isCompanyVersion = YES;
    }
    else{
        self.imageNameArray = @[@"IK_myResume",@"IK_jobprocess",@"IK_star_hollow_grey",@"IK_companyInfo",@"IK_setting"];
        self.titleArray = @[@"我的简历",@"求职进度",@"收藏职位",@"关注公司",@"我的设置"];
        _isCompanyVersion = NO;

    }
    
}


 - (void)addTableView
{
    [self setResourceData];
    [self.view addSubview:self.tableView];
    
}


- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -5, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 50) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
//        _tableView.bounces = NO;
    }
    return _tableView;
}

- (void)initNavLogo
{
    IKNavIconView *logo = [[IKNavIconView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.navigationItem.titleView =  logo;
}


- (void)initLoginView
{
    CGFloat w = ceilf(IKSCREEN_WIDTH * 0.893);
    CGFloat h = ceilf(IKSCREENH_HEIGHT * 0.435);
    IKLoginView *loginView = [[IKLoginView alloc] initWithFrame:CGRectMake(self.view.center.x - (w * 0.5), self.view.center.y - (h*0.5) - 100, w, h)];

    loginView.delegate = self;
    [self.view addSubview:loginView];
    
    _oldLoginViewCenterY = loginView.center.y;
    _loginView = loginView;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.titleArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 300;
    }
    else{
        return 55;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static  NSString *cellId = @"IKSettingHeaderTableViewCellId";
        IKSettingHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKSettingHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
        
        return cell;
    }
    else{
        static  NSString *cellId = @"IKSettingTableViewCellId";
        IKSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
        [cell settingCellAddData:self.titleArray[indexPath.row - 1] imageName:self.imageNameArray[indexPath.row - 1]];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma - mark IKLoginViewDelegate

- (void)loginViewRefreshFrameWithType:(IKLoginViewLoginType)loginType
{
    switch (loginType) {
        case IKLoginViewLoginTypeRegisterFindJob:
        {
            CGFloat w = ceilf(IKSCREEN_WIDTH * 0.893);
            CGFloat h = ceilf(IKSCREENH_HEIGHT * 0.503);
            _loginView.frame = CGRectMake(self.view.center.x - (w * 0.5), self.view.center.y - (h*0.5) - 100, w, h);
            _oldLoginViewCenterY = _loginView.center.y;
            break;
        }
        case IKLoginViewLoginTypeRegisterFindPerson:
        {
            CGFloat w = ceilf(IKSCREEN_WIDTH * 0.893);
            CGFloat h = ceilf(IKSCREENH_HEIGHT * 0.6);
            _loginView.frame = CGRectMake(self.view.center.x - (w * 0.5), self.view.center.y - (h*0.5) - 100, w, h);
            _oldLoginViewCenterY = _loginView.center.y;
            break;
        }
            break;
        case IKLoginViewLoginTypeAccount:
        case IKLoginViewLoginTypePhoneNumber:
        {
            CGFloat w = ceilf(IKSCREEN_WIDTH * 0.893);
            CGFloat h = ceilf(IKSCREENH_HEIGHT * 0.435);
            _loginView.frame = CGRectMake(self.view.center.x - (w * 0.5), self.view.center.y - (h*0.5) - 100, w, h);
            _oldLoginViewCenterY = _loginView.center.y;
            break;
        }

        default:
            break;
    }
}

- (void)loginViewLoginButtonClick
{
    _loginView.hidden = YES;
    [_loginView removeFromSuperview];
    _loginView = nil;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self addTableView];
}



#pragma - mark KeyboardNotification
- (void)mineVcKeyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = keyboardRect.origin.y;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSLog(@"yyyyy = %.0f  === %.0f == %.0f",y,_loginView.center.y,self.view.center.y);
    
    if ((y-_loginView.center.y) < 130) {
        [UIView animateWithDuration:duration.doubleValue animations:^{
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:[curve intValue]];
            _loginView.center = CGPointMake(_loginView.center.x, _loginView.center.y - 50);
        }];
    }
}


- (void)mineVcKeyboardWillHide:(NSNotification *)notification
{
    NSLog(@"_oldLoginViewCenterY = %.0f",_oldLoginViewCenterY);
    if (_loginView.center.y != _oldLoginViewCenterY) {
        NSDictionary *userInfo = [notification userInfo];
        NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        
        [UIView animateWithDuration:duration.doubleValue animations:^{
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:[curve intValue]];
            _loginView.center = CGPointMake(_loginView.center.x,_oldLoginViewCenterY);
        }];
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    NSLog(@"touch = %@",touch.view);
    
    if (![touch.view isKindOfClass:[UITextField class]]) {
        [_loginView textFieldNeedResignFirstResponder];
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
