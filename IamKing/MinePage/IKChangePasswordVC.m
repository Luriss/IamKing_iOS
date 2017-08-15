//
//  IKChangePasswordVC.m
//  IamKing
//
//  Created by Luris on 2017/8/14.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKChangePasswordVC.h"
#import "IKTextField.h"
#import "LRToastView.h"
#import "IKGeneralTool.h"


@interface IKChangePasswordVC ()<UITextFieldDelegate>

@property(nonatomic, strong)UIScrollView *bottomView;
@property(nonatomic, strong)UITextField *oldPasswordTf;
@property(nonatomic, strong)UITextField *neewPasswordTf;
@property(nonatomic, strong)UIButton    *verifyButton;
@end

@implementation IKChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavTitle];
    [self initLeftBackItem];
    
    [self initBottomScorllView];
    [self initBottomScorllViewSubViews];
    
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"修改密码";
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

- (void)backButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)initBottomScorllView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64)];
//    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.scrollEnabled = NO;
    scrollView.bounces = NO;
    //    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.userInteractionEnabled = YES;
    [self.view insertSubview:scrollView aboveSubview:self.navigationView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappp:)];
    
    [scrollView addGestureRecognizer:tap];

    self.bottomView = scrollView;
    self.bottomView.contentSize = CGSizeMake(IKSCREEN_WIDTH*2, IKSCREENH_HEIGHT-64);
}

- (void)tappp:(UITapGestureRecognizer *)tap
{
    if (self.oldPasswordTf.isFirstResponder) {
        [self.oldPasswordTf resignFirstResponder];
    }
    
    if (self.neewPasswordTf.isFirstResponder) {
        [self.neewPasswordTf resignFirstResponder];
    }
}


- (void)initBottomScorllViewSubViews
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, IKSCREEN_WIDTH - 40, 35)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"请验证原密码";
    title.textColor = IKGeneralBlue;
    title.font = [UIFont boldSystemFontOfSize:15.0f];
    title.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:title];
    
    
    IKTextField *passwordTf = [[IKTextField alloc] initWithFrame:CGRectMake(40, 165, IKSCREEN_WIDTH - 80, 50)];
    passwordTf.placeholder = @" 请输入原密码";
    passwordTf.secureTextEntry = YES;
    passwordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTf.returnKeyType = UIReturnKeyDone;
    passwordTf.delegate = self;
    passwordTf.textColor = IKMainTitleColor;
    
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [phoneImage setImage:[UIImage imageNamed:@"IK_password"]];
    passwordTf.leftViewMode = UITextFieldViewModeAlways;
    passwordTf.leftView = phoneImage;
    [self.bottomView addSubview:passwordTf];
    self.oldPasswordTf = passwordTf;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(38, 215, IKSCREEN_WIDTH - 76, 1)];
    lineView.backgroundColor = IKLineColor;
    [self.bottomView addSubview:lineView];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.backgroundColor = IKGeneralBlue;
    nextButton.frame = CGRectMake(38, 240, IKSCREEN_WIDTH - 76, 40);
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateDisabled];
    nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [nextButton setBackgroundImage:IKButtonBlueBgImgae forState:UIControlStateNormal];
    [nextButton setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
    nextButton.layer.cornerRadius = 6;
    nextButton.layer.masksToBounds = YES;
    [nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:nextButton];
    
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(IKSCREEN_WIDTH + 20, 80, IKSCREEN_WIDTH - 40, 35)];
    //    title.backgroundColor = [UIColor redColor];
    title2.text = @"请输入新密码";
    title2.textColor = IKGeneralBlue;
    title2.font = [UIFont boldSystemFontOfSize:15.0f];
    title2.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:title2];
    
    
    IKTextField *passwordTf2 = [[IKTextField alloc] initWithFrame:CGRectMake(IKSCREEN_WIDTH + 40, 165, IKSCREEN_WIDTH - 80, 50)];
    passwordTf2.placeholder = @" 请输入新密码";
    passwordTf2.secureTextEntry = YES;
    passwordTf2.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTf2.returnKeyType = UIReturnKeyDone;
    passwordTf2.delegate = self;
    passwordTf2.textColor = IKMainTitleColor;
    
    UIImageView *phoneImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [phoneImage2 setImage:[UIImage imageNamed:@"IK_password"]];
    passwordTf2.leftViewMode = UITextFieldViewModeAlways;
    passwordTf2.leftView = phoneImage2;
    [self.bottomView addSubview:passwordTf2];
    self.neewPasswordTf = passwordTf2;
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(IKSCREEN_WIDTH + 38, 215, IKSCREEN_WIDTH - 76, 1)];
    lineView2.backgroundColor = IKLineColor;
    [self.bottomView addSubview:lineView2];
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.backgroundColor = IKGeneralBlue;
    okButton.frame = CGRectMake(IKSCREEN_WIDTH + 38, 240, IKSCREEN_WIDTH - 76, 40);
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateDisabled];
    okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [okButton setBackgroundImage:IKButtonBlueBgImgae forState:UIControlStateNormal];
    [okButton setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
    okButton.layer.cornerRadius = 6;
    okButton.layer.masksToBounds = YES;
    [okButton addTarget:self action:@selector(okButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:okButton];
}

- (void)nextButtonClick:(UIButton *)button
{
    if (self.oldPasswordTf.text.length > 1) {
        NSString *pwd = [IKUSERDEFAULT objectForKey:IKLoginPasswordKey];
        NSLog(@"pwwwwwwwwd === %@",pwd);
        if ([pwd isEqualToString:self.oldPasswordTf.text]) {
            [self.bottomView scrollRectToVisible:CGRectMake(IKSCREEN_WIDTH, 64, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64) animated:YES];
            [self.neewPasswordTf becomeFirstResponder];
        }
        else{
            [LRToastView showTosatWithText:@"密码错误" inView:self.view];
        }
    }
    else{
        [LRToastView showTosatWithText:@"请输入原密码" inView:self.view];
    }
}


- (void)okButtonClick:(UIButton *)button
{
    IKPasswordValidateResult result = [IKGeneralTool validatePassWordLegal:self.neewPasswordTf.text];
    
    switch (result) {
        case IKPasswordValidateResultNumberError:
        {
            [LRToastView showTosatWithText:@"请输入6~16位密码" inView:self.view];
            break;
        }
            
        case IKPasswordValidateResultDigitalAlphabetError:
        {
            [LRToastView showTosatWithText:@"请输入字母数字组合密码" inView:self.view];
            break;
        }
        case IKPasswordValidateResultSuccess:
        {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.bottomView.alpha = 0.1;
                
            } completion:^(BOOL finished) {
                [self.bottomView removeFromSuperview];
                self.bottomView = nil;
                [self initSuccessView];
            }];
            break;
        }
        default:
            break;
    }
}

- (void)initSuccessView
{
    UIView *successView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, self.view.bounds.size.height - 64)];
    //    bottomView.backgroundColor = [UIColor cyanColor];
    [self.view insertSubview:successView belowSubview:self.navigationView];
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    UIImage *image2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IK_thankyou" ofType:@"png"]];
    [topImageView setImage:image2];
    [successView addSubview:topImageView];
    
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(successView.mas_bottom).offset(-20);
        make.centerX.equalTo(successView.mas_centerX);
        make.height.mas_equalTo(82.5);
        make.width.mas_equalTo(157.5);
    }];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(successView.center.x - 50, 100, 100, 100)];
    //    view.backgroundColor = [UIColor redColor];
    [successView addSubview:view];
    
    UIImageView *okImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 40, 40)];
    UIImage *okImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IK_feedback_ok" ofType:@"png"]];
    //    topImageView.userInteractionEnabled = YES;
    [okImageView setImage:okImage];
    [view addSubview:okImageView];
    
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 100, 40)];
    descLabel.text = @"密码修改成功";
    descLabel.textColor = IKGeneralBlue;
    descLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.numberOfLines = 0;
    [view addSubview:descLabel];
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
