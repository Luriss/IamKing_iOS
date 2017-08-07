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


@interface IKMineViewController ()<IKLoginViewDelegate>
{
    CGFloat _oldLoginViewCenterY;
}


@property(nonatomic, strong)IKLoginView *loginView;

@end

@implementation IKMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _oldLoginViewCenterY = 0;
    
    [self initNavLogo];
    
    [self initLoginView];
    
    [IKNotificationCenter addObserver:self selector:@selector(mineVcKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [IKNotificationCenter addObserver:self selector:@selector(mineVcKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    // Do any additional setup after loading the view.
}

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



- (void)initNavLogo
{
    IKNavIconView *logo = [[IKNavIconView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.navigationItem.titleView =  logo;
}


- (void)initLoginView
{
    CGFloat w = ceilf(IKSCREEN_WIDTH * 0.893);
    CGFloat h = ceilf(IKSCREENH_HEIGHT * 0.435);
    IKLoginView *loginView = [[IKLoginView alloc] initWithFrame:CGRectMake(self.view.center.x - (w * 0.5), self.view.center.y - (h*0.5) - 50, w, h)];
//    loginView.backgroundColor = [UIColor cyanColor];
    loginView.layer.borderColor = IKLineColor.CGColor;
    loginView.layer.borderWidth = 1.0;
    loginView.layer.cornerRadius = 10;
    loginView.delegate = self;
    [self.view addSubview:loginView];
    
    _oldLoginViewCenterY = loginView.center.y;
    _loginView = loginView;
}

- (void)loginViewRefreshFrameWithType:(IKLoginViewLoginType)loginType
{
    switch (loginType) {
        case IKLoginViewLoginTypeRegisterFindJob:
        {
            CGFloat w = ceilf(IKSCREEN_WIDTH * 0.893);
            CGFloat h = ceilf(IKSCREENH_HEIGHT * 0.503);
            _loginView.frame = CGRectMake(self.view.center.x - (w * 0.5), self.view.center.y - (h*0.5) - 50, w, h);
            _oldLoginViewCenterY = _loginView.center.y;
            break;
        }
        case IKLoginViewLoginTypeRegisterFindPerson:
            
            break;
        case IKLoginViewLoginTypeAccount:
        case IKLoginViewLoginTypePhoneNumber:
        {
            CGFloat w = ceilf(IKSCREEN_WIDTH * 0.893);
            CGFloat h = ceilf(IKSCREENH_HEIGHT * 0.435);
            _loginView.frame = CGRectMake(self.view.center.x - (w * 0.5), self.view.center.y - (h*0.5) - 50, w, h);
            _oldLoginViewCenterY = _loginView.center.y;
            break;
        }

        default:
            break;
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
