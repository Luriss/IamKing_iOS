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
#import "IKSettingViewController.h"
#import "IKSettingView.h"
#import "IKAttentionCompanyVc.h"
#import "IKCollectionJobVc.h"
#import "IKJobResumeVc.h"
#import "IKJobProcessVc.h"
#import "IKIntroduceVc.h"


extern NSString * loginUserType;
extern NSString * loginUserId;


@interface IKMineViewController ()<IKLoginViewDelegate,IKSettingViewDelegate>
{
    CGFloat _oldLoginViewCenterY;
}


@property(nonatomic, strong)IKLoginView *loginView;
@property(nonatomic, strong)UIImageView *logoImageView;

@end

@implementation IKMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationView.hidden = YES;
    
    _oldLoginViewCenterY = 0;

    NSString *loginStatus = [IKUSERDEFAULT objectForKey:IKLoginSccuessKey];
    NSDictionary *dict = [IKUSERDEFAULT objectForKey:IKLoginSaveDataKey];
    NSLog(@"dict = %@",dict);
    loginUserType = [NSString stringWithFormat:@"%@",[dict objectForKey:@"userType"]];
    loginUserId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    
    if ([loginStatus isEqualToString:@"1"]) {
        [self addTableViewWithDict:dict];
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
    
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [self.navigationController setNavigationBarHidden:NO animated:NO];

}



- (void)addTableViewWithDict:(NSDictionary *)dict
{
    IKSettingView *settingView = [[IKSettingView alloc] initWithFrame:CGRectMake(0, -5, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 50)];
    settingView.delegate = self;
    settingView.dictionary = dict;
//    settingView.backgroundColor = [UIColor redColor];
    [self.view addSubview:settingView];
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
    IKLoginView *loginView = [[IKLoginView alloc] initWithFrame:CGRectMake(self.view.center.x - (w * 0.5), self.view.center.y - (h*0.5), w, h)];
//    loginView.backgroundColor = [UIColor redColor];
    loginView.delegate = self;
    [self.view addSubview:loginView];
    
    _oldLoginViewCenterY = loginView.center.y;
    _loginView = loginView;
    
    [self.view addSubview:self.logoImageView];
    
    _logoImageView.frame = CGRectMake(loginView.center.x - 57.5, loginView.frame.origin.y - 65, 115, 65);
}

- (UIImageView *)logoImageView
{
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 115, 65)];
        [_logoImageView setImage:[UIImage imageNamed:@"IK_loginLogo"]];
    }
    return _logoImageView;
}


#pragma - mark IKSettingViewDelegate

- (void)tableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath = %@",indexPath);

    switch (indexPath.row) {
        case 0:
        {
            IKIntroduceVc *introduce = [[IKIntroduceVc alloc] init];
            [self.navigationController pushViewController:introduce animated:YES];
            break;
        }
        case 1:
        {
            IKJobResumeVc *jobResume = [[IKJobResumeVc alloc] init];
            [self.navigationController pushViewController:jobResume animated:YES];
            break;
        }
        case 2:
        {
            IKJobProcessVc *jobProcess = [[IKJobProcessVc alloc] init];
            [self.navigationController pushViewController:jobProcess animated:YES];
            break;
        }
        case 3:
        {
            IKCollectionJobVc *collection = [[IKCollectionJobVc alloc] init];
            [self.navigationController pushViewController:collection animated:YES];
            break;
        }
        case 4:
        {
            IKAttentionCompanyVc *attention = [[IKAttentionCompanyVc alloc] init];
            [self.navigationController pushViewController:attention animated:YES];
            break;
        }
        case 5:
        {
            IKSettingViewController *mySetting = [[IKSettingViewController alloc] init];
            [self.navigationController pushViewController:mySetting animated:YES];
            break;
        }
            
        default:
            break;
    }
}

//- (void)settingViewRightArrowClick
//{
//    NSLog(@"settingViewRightArrowClick");
//}



- (void)loginViewRefreshFrameWithType:(IKLoginViewLoginType)loginType
{
    switch (loginType) {
        case IKLoginViewLoginTypeRegisterFindJob:
        {
            CGFloat w = ceilf(IKSCREEN_WIDTH * 0.893);
            CGFloat h = ceilf(IKSCREENH_HEIGHT * 0.503);
            _loginView.frame = CGRectMake(self.view.center.x - (w * 0.5), self.view.center.y - (h*0.5), w, h);
            _oldLoginViewCenterY = _loginView.center.y;
            _logoImageView.frame = CGRectMake(_loginView.center.x - 57.5, _loginView.frame.origin.y - 65, 115, 65);
            break;
        }
        case IKLoginViewLoginTypeRegisterFindPerson:
        {
            CGFloat w = ceilf(IKSCREEN_WIDTH * 0.893);
            CGFloat h = ceilf(IKSCREENH_HEIGHT * 0.6);
            _loginView.frame = CGRectMake(self.view.center.x - (w * 0.5), self.view.center.y - (h*0.5), w, h);
            _oldLoginViewCenterY = _loginView.center.y;
            _logoImageView.frame = CGRectMake(_loginView.center.x - 57.5, _loginView.frame.origin.y - 65, 115, 65);

            break;
        }
            break;
        case IKLoginViewLoginTypeAccount:
        case IKLoginViewLoginTypePhoneNumber:
        {
            CGFloat w = ceilf(IKSCREEN_WIDTH * 0.893);
            CGFloat h = ceilf(IKSCREENH_HEIGHT * 0.435);
            _loginView.frame = CGRectMake(self.view.center.x - (w * 0.5), self.view.center.y - (h*0.5), w, h);
            _oldLoginViewCenterY = _loginView.center.y;
            _logoImageView.frame = CGRectMake(_loginView.center.x - 57.5, _loginView.frame.origin.y - 65, 115, 65);

            break;
        }

        default:
            break;
    }
}

- (void)loginViewLoginSuccess:(NSDictionary *)dict
{
    _loginView.hidden = YES;
    [_loginView removeFromSuperview];
    _loginView = nil;
    [self addTableViewWithDict:dict];
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
            _logoImageView.frame = CGRectMake(_loginView.center.x - 57.5, _loginView.frame.origin.y - 65, 115, 65);
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
            _logoImageView.frame = CGRectMake(_loginView.center.x - 57.5, _loginView.frame.origin.y - 65, 115, 65);
        }];
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
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
