//
//  IKChangePhoneNumberVC.m
//  IamKing
//
//  Created by Luris on 2017/8/14.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKChangePhoneNumberVC.h"
#import "IKTextField.h"
#import "LRToastView.h"
#import "IKGeneralTool.h"


@interface IKChangePhoneNumberVC ()<UITextFieldDelegate>


@property(nonatomic, strong)UIView *bottomView;
@property(nonatomic, strong)UITextField *phoneTf;
@property(nonatomic, strong)UITextField *verifyTf;
@property(nonatomic, strong)UIButton    *verifyButton;
@property(nonatomic, strong)UIButton    *okButton;
@property(nonatomic, assign)NSInteger    countdown;
@property (nonatomic, weak) NSTimer *timer;


@end

@implementation IKChangePhoneNumberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavTitle];
    [self initLeftBackItem];
    
    [self initBottomView];
    [self initBottomSubViews];
    
    [IKNotificationCenter addObserver:self selector:@selector(changePhoneVcKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [IKNotificationCenter addObserver:self selector:@selector(changePhoneVcKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc
{
    [IKNotificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [IKNotificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"手机号";
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

- (void)initBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, self.view.bounds.size.height - 64)];
//    bottomView.backgroundColor = [UIColor cyanColor];
    [self.view insertSubview:bottomView belowSubview:self.navigationView];
    
    self.bottomView = bottomView;
}


- (void)initBottomSubViews
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, IKSCREEN_WIDTH - 40, 35)];
//    title.backgroundColor = [UIColor redColor];
    title.text = @"更换手机号";
    title.textColor = IKGeneralBlue;
    title.font = [UIFont boldSystemFontOfSize:15.0f];
    title.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:title];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x - 45, 75, 90, 90)];
//    imageV.backgroundColor = [UIColor redColor];
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IK_changePhoneNumber" ofType:@"png"]];
    [imageV setImage:image];
    [self.bottomView addSubview:imageV];
    
    UILabel *psLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 185, IKSCREEN_WIDTH - 40, 30)];
    //    title.backgroundColor = [UIColor redColor];
    psLabel1.text = @"您当前的手机为";
    psLabel1.textColor = IKSubHeadTitleColor;
    psLabel1.font = [UIFont boldSystemFontOfSize:13.0f];
    psLabel1.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:psLabel1];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 225, IKSCREEN_WIDTH - 40, 30)];
    //    title.backgroundColor = [UIColor redColor];
    phoneLabel.text = self.phoneNumber;
    phoneLabel.textColor = IKGeneralBlue;
    phoneLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:phoneLabel];
    
    
    UILabel *psLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 265, IKSCREEN_WIDTH - 40, 30)];
    //    title.backgroundColor = [UIColor redColor];
    psLabel2.text = @"更换后可用新手机号登录";
    psLabel2.textColor = IKSubHeadTitleColor;
    psLabel2.font = [UIFont boldSystemFontOfSize:13.0f];
    psLabel2.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:psLabel2];
    
    IKTextField *phoneTextfield = [[IKTextField alloc] initWithFrame:CGRectMake(40, 320, IKSCREEN_WIDTH - 80, 50)];
//    phoneTextfield.backgroundColor = IKGeneralLightGray;
//    phoneTextfield.layer.cornerRadius = 6;
    phoneTextfield.placeholder = @" 请输入手机号码";
    phoneTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextfield.keyboardType = UIKeyboardTypePhonePad;
    phoneTextfield.delegate = self;
    phoneTextfield.textColor = IKMainTitleColor;
    
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [phoneImage setImage:[UIImage imageNamed:@"IK_phone_grey"]];
    phoneTextfield.leftViewMode = UITextFieldViewModeAlways;
    phoneTextfield.leftView = phoneImage;
    [self.bottomView addSubview:phoneTextfield];
    self.phoneTf = phoneTextfield;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(38, 370, IKSCREEN_WIDTH - 76, 1)];
    lineView.backgroundColor = IKLineColor;
    [self.bottomView addSubview:lineView];
    
    IKTextField *verifyTextfield = [[IKTextField alloc] initWithFrame:CGRectMake(40, 371, IKSCREEN_WIDTH - 80, 50)];
//    verifyTextfield.backgroundColor = IKGeneralLightGray;
//    verifyTextfield.layer.cornerRadius = 6;
    verifyTextfield.placeholder = @" 验证码";
    verifyTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    verifyTextfield.keyboardType = UIKeyboardTypePhonePad;
    verifyTextfield.delegate = self;
    verifyTextfield.textColor = IKMainTitleColor;
    
    UIImageView *passwordImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [passwordImage setImage:[UIImage imageNamed:@"IK_verify_gray"]];
    verifyTextfield.leftViewMode = UITextFieldViewModeAlways;
    verifyTextfield.leftView = passwordImage;
    [self.bottomView addSubview:verifyTextfield];
    self.verifyTf = verifyTextfield;
    
    UIButton *verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    verifyButton.frame = CGRectMake(0, 0, 80, 50);
    [verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verifyButton setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
    verifyButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [verifyButton addTarget:self action:@selector(verifyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.verifyButton = verifyButton;
    
//    verifyButton.backgroundColor = [UIColor redColor];
    verifyTextfield.rightViewMode = UITextFieldViewModeAlways;
    verifyTextfield.rightView = verifyButton;
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(38, 421, IKSCREEN_WIDTH - 76, 1)];
    lineView2.backgroundColor = IKLineColor;
    [self.bottomView addSubview:lineView2];
    
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.backgroundColor = IKGeneralBlue;
    okButton.frame = CGRectMake(38, 442, IKSCREEN_WIDTH - 76, 40);
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateDisabled];
    okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [okButton setBackgroundImage:IKButtonBlueBgImgae forState:UIControlStateNormal];
    [okButton setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
    okButton.layer.cornerRadius = 6;
    okButton.layer.masksToBounds = YES;
    okButton.enabled = NO;
    [okButton addTarget:self action:@selector(okButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:okButton];
    self.okButton = okButton;
}


- (void)verifyButtonClick:(UIButton *)button
{
    NSLog(@"verifyButtonClick:");
    if (self.phoneTf.text.length ==0) {
        [LRToastView showTosatWithText:@"请输入手机号码" inView:self.view];
    }
    
    BOOL isPhoneNumber = [IKGeneralTool validateContactNumber:self.phoneTf.text];
    if (isPhoneNumber) {
        // 开始倒计时
        _countdown = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTime) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        self.verifyButton.enabled = NO;
        
        [[IKNetworkManager shareInstance] getChangePhoneNumberVerifyCode:@{@"codeMethod":@"2",@"phoneNumber":self.phoneTf.text,@"useType":@"7"} backData:^(NSString *verifyCode, BOOL success) {
            
        }];
        
    }
    else{
        [LRToastView showTosatWithText:@"请输入正确的手机号码" inView:self.view];
    }
}

- (void)countDownTime
{
    _countdown --;
    [self.verifyButton setTitle:[NSString stringWithFormat:@"剩余%lds",_countdown] forState:UIControlStateNormal];

    if (_countdown == 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.verifyButton.enabled = YES;
        [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)okButtonClick:(UIButton *)button
{
    NSLog(@"okButtonClick:");
    
    if (self.verifyTf.text.length ==0) {
        [LRToastView showTosatWithText:@"请输入验证码" inView:self.view];
    }
    else{
        // 开始验证.
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.bottomView.alpha = 0.1;
            
        } completion:^(BOOL finished) {
            [self.bottomView removeFromSuperview];
            self.bottomView = nil;
            [self initSuccessView];
        }];
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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(successView.center.x - 40, 100, 80, 100)];
//    view.backgroundColor = [UIColor redColor];
    [successView addSubview:view];
    
    UIImageView *okImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 40, 40)];
    UIImage *okImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IK_feedback_ok" ofType:@"png"]];
    //    topImageView.userInteractionEnabled = YES;
    [okImageView setImage:okImage];
    [view addSubview:okImageView];
    
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 80, 40)];
    descLabel.text = @"已更换";
    descLabel.textColor = IKGeneralBlue;
    descLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.numberOfLines = 0;
    [view addSubview:descLabel];
}

#pragma - mark KeyboardNotification
- (void)changePhoneVcKeyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = keyboardRect.origin.y;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSLog(@"ccccccccccc = %.0f  === %.0f ",y,_bottomView.center.y);
    
    if ((y-_bottomView.center.y) < 100) {
        [UIView animateWithDuration:duration.doubleValue animations:^{
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:[curve intValue]];
            _bottomView.center = CGPointMake(_bottomView.center.x, _bottomView.center.y - 200);
        }];
    }
}


- (void)changePhoneVcKeyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        _bottomView.center = CGPointMake(self.view.center.x, self.view.center.y + 20);
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing = %@",textField.text);
    if (textField == self.verifyTf && self.phoneTf.text.length == 11) {
        self.okButton.enabled = YES;
    }
    else{
        self.okButton.enabled = NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textField.text = %@",textField.text);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"vvvvvv = %@",touches.anyObject.view);
    
    if (self.phoneTf.isFirstResponder) {
        [self.phoneTf resignFirstResponder];
    }
    
    if (self.verifyTf.isFirstResponder) {
        [self.verifyTf resignFirstResponder];
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
