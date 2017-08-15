//
//  IKLoginView.m
//  IamKing
//
//  Created by Luris on 2017/8/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKLoginView.h"
#import "IKTextField.h"
#import "IKCompanyTypeView.h"
#import "IKGeneralTool.h"
#import "IKMD5Tool.h"

NSString * loginUserType;
NSString * loginUserId;

@interface IKLoginView ()<IKCompanyTypeViewDelegate,UITextFieldDelegate>
{
    CGFloat _totalH;
    CGFloat _registerTotalH;
    
}

@property (nonatomic, strong) IKTextField     *phoneTextfield;
@property (nonatomic, strong) IKTextField     *passwordTextfield;
@property (nonatomic, strong) IKTextField     *verifyTextfield;
@property (nonatomic, strong) IKButton  *paLoginButton;     // phone or account
@property (nonatomic, strong) IKButton  *registerAccount;
@property (nonatomic, strong) IKButton  *findPerson;
@property (nonatomic, strong) IKButton  *chooseTypeBtn;
@property (nonatomic, strong) IKCompanyTypeView *classifyView;
@property (nonatomic, assign) IKLoginViewPasswordType pwdType;

@property (nonatomic, strong) UIButton  *loginButton;
@property (nonatomic, strong) UIButton  *wxLoginButton;
@property (nonatomic, strong) UIButton  *getVerifyCodeBtn;
@property (nonatomic, strong) UIButton  *findJob;
@property (nonatomic, strong) UIButton  *registerButton;
@property (nonatomic, copy) NSString    *verifyCode;


@end

@implementation IKLoginView

-(instancetype)init
{
    self = [super initWithFrame:CGRectMake(20, 0, IKSCREEN_WIDTH - 40, 300)];
    if (self) {
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubviews];
    }
    return self;
}


- (void)addSubviews
{
    _totalH = 0;
    _registerTotalH = 0;
    self.userInteractionEnabled = YES;
    self.pwdType = IKLoginViewPasswordTypePassword;
    
    [self addSubview:self.phoneTextfield];
    
    [self addSubview:self.passwordTextfield];
    
    [self addSubview:self.loginButton];
    
    [self addSubview:self.wxLoginButton];
    
    [self addSubview:self.registerAccount];
    
    [self addSubview:self.paLoginButton];
}

- (IKTextField *)phoneTextfield
{
    if (_phoneTextfield == nil) {
        _phoneTextfield = [[IKTextField alloc] initWithFrame:CGRectMake(22, 40, CGRectGetWidth(self.frame) - 44, 40)];
        _phoneTextfield.backgroundColor = IKGeneralLightGray;
        _phoneTextfield.layer.cornerRadius = 6;
        _phoneTextfield.placeholder = @" 请输入手机号码";
        _phoneTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextfield.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextfield.delegate = self;
        _phoneTextfield.textColor = IKMainTitleColor;
        
        UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [phoneImage setImage:[UIImage imageNamed:@"IK_phone_grey"]];
        _phoneTextfield.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextfield.leftView = phoneImage;
        _totalH = 40 + 40;
    }
    return _phoneTextfield;
}

- (IKTextField *)passwordTextfield
{
    if (_passwordTextfield == nil) {
        _passwordTextfield = [[IKTextField alloc] initWithFrame:CGRectMake(22, _totalH + 10, CGRectGetWidth(self.frame) - 44, 40)];
        _passwordTextfield.backgroundColor = IKGeneralLightGray;
        _passwordTextfield.layer.cornerRadius = 6;
        _passwordTextfield.placeholder = @" 请输入密码";
        _passwordTextfield.secureTextEntry = YES;
        _passwordTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextfield.delegate = self;
        _passwordTextfield.returnKeyType = UIReturnKeyDone;
        _passwordTextfield.textColor = IKMainTitleColor;
        
        UIImageView *passwordImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [passwordImage setImage:[UIImage imageNamed:@"IK_password"]];
        _passwordTextfield.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextfield.leftView = passwordImage;
        
        _totalH += 50;
        _registerTotalH = _totalH;
    }
    return _passwordTextfield;
}

- (UIButton *)loginButton
{
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = IKGeneralBlue;
        _loginButton.frame = CGRectMake(22, _totalH + 20, CGRectGetWidth(self.frame) - 44, 40);
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [_loginButton setBackgroundImage:IKButtonBlueBgImgae forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
        _loginButton.layer.cornerRadius = 6;
        _loginButton.layer.masksToBounds = YES;
        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _totalH += 60;
    }
    return _loginButton;
}


- (UIButton *)wxLoginButton
{
    if (_wxLoginButton == nil) {
        _wxLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _wxLoginButton.frame = CGRectMake(22, _totalH + 15, CGRectGetWidth(self.frame) - 44, 40);
        [_wxLoginButton setTitle:@"微信快捷登录" forState:UIControlStateNormal];
        [_wxLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _wxLoginButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [_wxLoginButton setBackgroundImage:[UIImage GetImageWithColor:IkGeneralGreen size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
        [_wxLoginButton setBackgroundImage:[UIImage GetImageWithColor:IKColorFromRGB(0x1aab05) size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
        _wxLoginButton.layer.cornerRadius = 6;
        _wxLoginButton.layer.masksToBounds = YES;
        
        _totalH += 55;
    }
    return _wxLoginButton;
}



- (IKButton *)registerAccount
{
    if (_registerAccount == nil) {
        _registerAccount = [IKButton buttonWithType:UIButtonTypeCustom];
        _registerAccount.frame = CGRectMake(22, _totalH + 20, 80, 20);
        [_registerAccount setTitle:@"注册帐号" forState:UIControlStateNormal];
        [_registerAccount setTitleColor: IKMainTitleColor forState:UIControlStateNormal];
        _registerAccount.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _registerAccount.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        [_registerAccount addTarget:self action:@selector(registerAccountClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _registerAccount;
}

- (UIButton *)findJob
{
    if (_findJob == nil) {
        CGFloat w = (CGRectGetWidth(self.frame) - 44)*0.5 - 15;
        _findJob = [UIButton buttonWithType:UIButtonTypeCustom];
        _findJob.frame = CGRectMake(22, _registerTotalH + 10, w, 40);
        [_findJob setTitle:@"找工作" forState:UIControlStateNormal];
        [_findJob setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        _findJob.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _findJob.layer.cornerRadius = 6;
        _findJob.layer.masksToBounds = YES;
        _findJob.layer.borderColor = IKSubHeadTitleColor.CGColor;
        _findJob.layer.borderWidth = 1.0f;
        [_findJob addTarget:self action:@selector(findJobButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _registerTotalH += 50;
    }
    return _findJob;
}


- (IKButton *)findPerson
{
    if (_findPerson == nil) {
        CGFloat w = (CGRectGetWidth(self.frame) - 44)*0.5 - 15;
        _findPerson = [IKButton buttonWithType:UIButtonTypeCustom];
        _findPerson.frame = CGRectMake(_findJob.frame.size.width + 22 + 30, _findJob.frame.origin.y, w, 40);
        [_findPerson setTitle:@"招人" forState:UIControlStateNormal];
        [_findPerson setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        _findPerson.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _findPerson.layer.cornerRadius = 6;
        _findPerson.layer.masksToBounds = YES;
        _findPerson.layer.borderColor = IKSubHeadTitleColor.CGColor;
        _findPerson.layer.borderWidth = 1.0f;
        
        [_findPerson addTarget:self action:@selector(findPersonButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _findPerson;
}

- (UIButton *)registerButton
{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _registerButton.frame = CGRectMake(22, _registerTotalH + 20, CGRectGetWidth(self.frame) - 44, 40);
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [_registerButton setBackgroundImage:IKButtonBlueBgImgae forState:UIControlStateNormal];
        [_registerButton setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
        _registerButton.layer.cornerRadius = 6;
        _registerButton.layer.masksToBounds = YES;
        
        _registerTotalH += 60;
    }
    return _registerButton;
}


- (IKButton *)paLoginButton
{
    if (_paLoginButton == nil) {
        _paLoginButton = [IKButton buttonWithType:UIButtonTypeCustom];
        _paLoginButton.frame = CGRectMake(CGRectGetWidth(self.frame) - 102, _totalH + 20, 80, 20);
        [_paLoginButton setTitle:@"手机登录" forState:UIControlStateNormal];
        [_paLoginButton setTitleColor: IKMainTitleColor forState:UIControlStateNormal];
        _paLoginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _paLoginButton.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        
        [_paLoginButton addTarget:self action:@selector(paLoginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _paLoginButton;
}

- (IKTextField *)verifyTextfield
{
    if (_verifyTextfield == nil) {
        _verifyTextfield = [[IKTextField alloc] initWithFrame:CGRectMake(22, _passwordTextfield.frame.origin.y, ceilf(CGRectGetWidth(self.frame) * 0.48), 40)];
        _verifyTextfield.backgroundColor = IKGeneralLightGray;
        _verifyTextfield.layer.cornerRadius = 6;
        _verifyTextfield.placeholder = @" 验证码";
        _verifyTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _verifyTextfield.keyboardType = UIKeyboardTypePhonePad;
        _verifyTextfield.delegate = self;
        _verifyTextfield.textColor = IKMainTitleColor;
        
        UIImageView *passwordImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [passwordImage setImage:[UIImage imageNamed:@"IK_verify_gray"]];
        _verifyTextfield.leftViewMode = UITextFieldViewModeAlways;
        _verifyTextfield.leftView = passwordImage;
        
    }
    return _verifyTextfield;
}


- (UIButton *)getVerifyCodeBtn
{
    if (_getVerifyCodeBtn == nil) {
        
        CGFloat x = _verifyTextfield.frame.origin.x + _verifyTextfield.frame.size.width + 10;
        _getVerifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getVerifyCodeBtn.backgroundColor = IKGeneralBlue;
        _getVerifyCodeBtn.frame = CGRectMake(x, _verifyTextfield.frame.origin.y,CGRectGetWidth(self.frame) - x - 22, 40);
        [_getVerifyCodeBtn setTitle:@"获取" forState:UIControlStateNormal];
        [_getVerifyCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _getVerifyCodeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [_getVerifyCodeBtn setBackgroundImage:IKButtonBlueBgImgae forState:UIControlStateNormal];
        [_getVerifyCodeBtn setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
        _getVerifyCodeBtn.layer.cornerRadius = 6;
        _getVerifyCodeBtn.layer.masksToBounds = YES;
        [_getVerifyCodeBtn addTarget:self action:@selector(verifyCodeBtnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getVerifyCodeBtn;
}

- (IKButton *)chooseTypeBtn
{
    if (_chooseTypeBtn == nil) {
        _chooseTypeBtn = [IKButton buttonWithType:UIButtonTypeCustom];
        _chooseTypeBtn.frame = CGRectMake(22, self.findJob.frame.origin.y + self.findJob.frame.size.height + 10, CGRectGetWidth(self.frame) - 44, 40);
        _chooseTypeBtn.backgroundColor = IKGeneralLightGray;
        _chooseTypeBtn.adjustsImageWhenHighlighted = NO;
        [_chooseTypeBtn setImage:[UIImage imageNamed:@"IK_classify_gray"] forState:UIControlStateNormal];
        [_chooseTypeBtn setTitle:@"请选择公司类型" forState:UIControlStateNormal];
        [_chooseTypeBtn setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        _chooseTypeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _chooseTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _chooseTypeBtn.layer.cornerRadius = 6;
        _chooseTypeBtn.layer.masksToBounds = YES;
        CGFloat w = CGRectGetWidth(_chooseTypeBtn.frame);
        _chooseTypeBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, w - 30);
        _chooseTypeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        
        [_chooseTypeBtn addTarget:self action:@selector(chooseTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseTypeBtn;
}


- (IKCompanyTypeView *)classifyView
{
    if (_classifyView == nil) {
        CGFloat y = _chooseTypeBtn.frame.origin.y + _chooseTypeBtn.frame.size.height;
        _classifyView = [[IKCompanyTypeView alloc] initWithFrame:CGRectMake(22, y, _chooseTypeBtn.frame.size.width, 140)];
        _classifyView.backgroundColor = [UIColor redColor];
        _classifyView.layer.cornerRadius = 6;
        _classifyView.layer.masksToBounds = YES;
        _classifyView.layer.borderColor = IKGeneralLightGray.CGColor;
        _classifyView.layer.borderWidth = 1;
        _classifyView.delegate = self;
    }
    return _classifyView;
}

#pragma - mark Button Action

- (void)loginButtonClick:(UIButton *)button
{
    if (_phoneTextfield.text.length != 11 ) {
        [LRToastView showTosatWithText:@"请输入正确的手机号码" inView:self.superview];
    }
    else{
        BOOL isPhoneNumber = [IKGeneralTool validateContactNumber:_phoneTextfield.text];
        
        if (!isPhoneNumber) {
            [LRToastView showTosatWithText:@"请输入正确的手机号码" inView:self.superview];
        }
        else{
            switch (self.pwdType) {
                case IKLoginViewPasswordTypePassword:
                {
                    IKPasswordValidateResult passwordLegal = [IKGeneralTool validatePassWordLegal:_passwordTextfield.text];
                    
                    switch (passwordLegal) {
                        case IKPasswordValidateResultNumberError:
                        {
                            [LRToastView showTosatWithText:@"请输入6~16位长度的密码" inView:self.superview];
                            break;
                        }
                        case IKPasswordValidateResultDigitalAlphabetError:
                        {
                            [LRToastView showTosatWithText:@"请输入数字字母的组合密码" inView:self.superview];
                            break;
                        }
                        case IKPasswordValidateResultSuccess:
                        {
                            NSString *newPassword = [IKMD5Tool MD5ForLower32Bate:_passwordTextfield.text];
                            NSLog(@"newPassword = %@",newPassword);
                            
                            [[IKNetworkManager shareInstance] getLoginInfoWithParam:@{@"accessToken":@"",@"account":_phoneTextfield.text,@"openId":@"",@"passwd":newPassword} backData:^(NSDictionary *dict, BOOL success) {
                                if (success) {
                                    [self saveLoginData:dict];
                                }
                            }];
                            break;
                        }
                            
                        default:
                            break;
                    }
                    break;
                }
                
                case IKLoginViewPasswordTypeVerifyCode:
                {
                    if (_verifyTextfield.text.length > 0) {
                        [[IKNetworkManager shareInstance] getLoginInfoWithVerifyCodeParam:@{@"accessToken":@"",@"account":_phoneTextfield.text,@"openId":@"",@"code":_verifyTextfield.text} backData:^(NSDictionary *dict, BOOL success) {
                            if (success) {
                                [self saveLoginData:dict];
                            }
                        }];
                    }
                    else{
                        [LRToastView showTosatWithText:@"请输入验证码" inView:self.superview];
                    }
                }
                    
                default:
                    break;
            }
        }
    }
}


- (void)chooseTypeBtnClick:(IKButton *)button
{
    if (!button.isClick) {
        if (_classifyView == nil) {
            [self insertSubview:self.classifyView aboveSubview:button];
        }
        else{
            _classifyView.hidden = NO;
        }
        button.isClick = YES;
    }
    else{
        _classifyView.hidden = YES;
        button.isClick = NO;
    }
    
    [self textFieldNeedResignFirstResponder];
}

- (void)verifyCodeBtnButtonClick:(UIButton *)button
{
    BOOL isPhoneNumber = [IKGeneralTool validateContactNumber:_phoneTextfield.text];
    
    if (!isPhoneNumber) {
        [LRToastView showTosatWithText:@"请输入正确的手机号码" inView:self.superview];
    }
    else{
        [[IKNetworkManager shareInstance] getChangePhoneNumberVerifyCode:@{@"codeMethod":@"2",@"phoneNumber":_phoneTextfield.text,@"useType":@"7"} backData:^(NSString *verifyCode, BOOL success) {
            NSLog(@"verifyCode = %@",verifyCode);
            self.verifyCode = verifyCode;
        }];
    }
}

- (void)paLoginButtonClick:(IKButton *)button
{
    NSLog(@"paLoginButtonClick = %d",button.isClick);
    
    if ([self.delegate respondsToSelector:@selector(loginViewRefreshFrameWithType:)]) {
        [self.delegate loginViewRefreshFrameWithType:IKLoginViewLoginTypePhoneNumber];
    }
    
    _findJob.hidden = YES;
    _findPerson.hidden = YES;
    _registerButton.hidden = YES;
    _chooseTypeBtn.hidden = YES;
    _registerAccount.frame = CGRectMake(22, _totalH + 20, 80, 20);
    _paLoginButton.frame = CGRectMake(CGRectGetWidth(self.frame) - 102, _totalH + 20, 80, 20);
    _registerAccount.isClick = NO;
    [_registerAccount setTitle:@"注册帐号" forState:UIControlStateNormal];
    
    if (!button.isClick) {
        [button setTitle:@"帐号登录" forState:UIControlStateNormal];
        button.isClick = YES;
        self.pwdType = IKLoginViewPasswordTypeVerifyCode;

        [self phoneLoginAjustFrame];
    }
    else{
        [button setTitle:@"手机登录" forState:UIControlStateNormal];
        self.pwdType = IKLoginViewPasswordTypePassword;

        button.isClick = NO;
        _passwordTextfield.hidden = NO;
        self.verifyTextfield.hidden = YES;
        self.getVerifyCodeBtn.hidden = YES;
        _loginButton.hidden = NO;
        _wxLoginButton.hidden = NO;
    }
    
    [self textFieldNeedResignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_phoneTextfield becomeFirstResponder];
    });
}

- (void)registerAccountClick:(IKButton *)button
{
    
    if (!button.isClick) {
        
        if ([self.delegate respondsToSelector:@selector(loginViewRefreshFrameWithType:)]) {
            [self.delegate loginViewRefreshFrameWithType:IKLoginViewLoginTypeRegisterFindJob];
        }
        
        [button setTitle:@"登录帐号" forState:UIControlStateNormal];
        button.isClick = YES;
        
        [self registerAjustFrame];
        
        [_findJob setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        _findJob.layer.borderColor = IKSubHeadTitleColor.CGColor;
        
        _findPerson.layer.borderColor = IKSubHeadTitleColor.CGColor;
        [_findPerson setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    }
    else{
        if ([self.delegate respondsToSelector:@selector(loginViewRefreshFrameWithType:)]) {
            [self.delegate loginViewRefreshFrameWithType:IKLoginViewLoginTypeAccount];
        }
        [button setTitle:@"注册帐号" forState:UIControlStateNormal];
        button.isClick = NO;
        [self accountLoginAjustFrame];
    }
    [self textFieldNeedResignFirstResponder];
}

- (void)findJobButtonClick:(UIButton *)button
{
    [button setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
    button.layer.borderColor = IKGeneralBlue.CGColor;
    
    _classifyView.hidden = YES;
    _chooseTypeBtn.isClick = NO;
    
    _findPerson.layer.borderColor = IKSubHeadTitleColor.CGColor;
    [_findPerson setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(loginViewRefreshFrameWithType:)]) {
        [self.delegate loginViewRefreshFrameWithType:IKLoginViewLoginTypeRegisterFindJob];
    }
    
    [self registerAjustFrame];
    [self textFieldNeedResignFirstResponder];
}

- (void)findPersonButtonClick:(IKButton *)button
{
    _findJob.layer.borderColor = IKSubHeadTitleColor.CGColor;
    [_findJob setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    [button setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
    button.layer.borderColor = IKGeneralBlue.CGColor;
    
    if ([self.delegate respondsToSelector:@selector(loginViewRefreshFrameWithType:)]) {
        [self.delegate loginViewRefreshFrameWithType:IKLoginViewLoginTypeRegisterFindPerson];
    }
    
    [self findPersonAdjustFrame];
    [self textFieldNeedResignFirstResponder];
}


- (void)saveLoginData:(NSDictionary *)dict
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [IKUSERDEFAULT setObject:dict forKey:IKLoginSaveDataKey];
        loginUserType = [NSString stringWithFormat:@"%@",[dict objectForKey:@"userType"]];
        loginUserId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
        [IKUSERDEFAULT setObject:_phoneTextfield.text forKey:IKLoginPhoneNumberKey];
        [IKUSERDEFAULT setObject:_passwordTextfield.text forKey:IKLoginPasswordKey];

        [IKUSERDEFAULT setObject:@"1" forKey:IKLoginSccuessKey];
        [IKUSERDEFAULT synchronize];
        
        
        if ([loginUserType isEqualToString:@"0"]) {
            [IKNotificationCenter postNotificationName:@"IKRefreshTabBarItems" object:nil];
        }
        
        if ([self.delegate respondsToSelector:@selector(loginViewLoginSuccess:)]) {
            [self.delegate loginViewLoginSuccess:dict];
        }
        
    });
}


#pragma - mark AdjustFrame

- (void)findPersonAdjustFrame
{
    if (_chooseTypeBtn == nil) {
        [self addSubview:self.chooseTypeBtn];
    }
    else{
        _chooseTypeBtn.hidden = NO;
    }
    
    [_chooseTypeBtn setTitle:@"请选择公司类型" forState:UIControlStateNormal];
    [_chooseTypeBtn setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    
    CGFloat y = _chooseTypeBtn.frame.origin.y + _chooseTypeBtn.frame.size.height;
    _registerButton.frame = CGRectMake(22, y + 10, CGRectGetWidth(self.frame) - 44, 40);
    
    _paLoginButton.frame = CGRectMake(CGRectGetWidth(self.frame) - 102, y + 50 + 20, 80, 20);
    _registerAccount.frame = CGRectMake(22, y + 50 + 20, 80, 20);
}

- (void)registerAjustFrame
{
    _loginButton.hidden = YES;
    _wxLoginButton.hidden = YES;
    _passwordTextfield.hidden = NO;
    _chooseTypeBtn.hidden = YES;
    
    
    if (_verifyTextfield == nil) {
        [self addSubview:self.verifyTextfield];
        [self addSubview:self.getVerifyCodeBtn];
    }
    else{
        _verifyTextfield.hidden = NO;
        _getVerifyCodeBtn.hidden = NO;
    }
    
    CGFloat y = _passwordTextfield.frame.origin.y + _passwordTextfield.frame.size.height;
    self.verifyTextfield.frame = CGRectMake(22, y + 10, ceilf(CGRectGetWidth(self.frame) * 0.48), 40);
    CGFloat x = _verifyTextfield.frame.origin.x + _verifyTextfield.frame.size.width + 10;
    _getVerifyCodeBtn.frame = CGRectMake(x, _verifyTextfield.frame.origin.y,CGRectGetWidth(self.frame) - x - 22, 40);
    
    _registerTotalH = y + 50;
    
    if (_findJob == nil) {
        [self addSubview:self.findJob];
        [self addSubview:self.findPerson];
    }
    else{
        _findJob.hidden = NO;
        _findPerson.hidden = NO;
    }
    
    if (_registerButton == nil) {
        [self addSubview:self.registerButton];
    }
    else{
        self.registerButton.hidden = NO;
    }
    
    CGFloat reBtnY = self.findJob.frame.origin.y + self.findJob.frame.size.height;
    
    _registerButton.frame = CGRectMake(22, reBtnY + 20, CGRectGetWidth(self.frame) - 44, 40);
    
    CGFloat buttonY = reBtnY + 60 + 15;
    _paLoginButton.frame = CGRectMake(CGRectGetWidth(self.frame) - 102, buttonY, 80, 20);
    _registerAccount.frame = CGRectMake(22, buttonY, 80, 20);
    
}


- (void)accountLoginAjustFrame
{
    _loginButton.hidden = NO;
    _wxLoginButton.hidden = NO;
    _chooseTypeBtn.hidden = YES;
    self.verifyTextfield.hidden = YES;
    self.getVerifyCodeBtn.hidden = YES;
    _findJob.hidden = YES;
    _findPerson.hidden = YES;
    self.registerButton.hidden = YES;
    _registerAccount.frame = CGRectMake(22, _totalH + 20, 80, 20);
    _paLoginButton.frame = CGRectMake(CGRectGetWidth(self.frame) - 102, _totalH + 20, 80, 20);
}


- (void)phoneLoginAjustFrame
{
    _passwordTextfield.hidden = YES;
    _loginButton.hidden = NO;
    _wxLoginButton.hidden = NO;
    if (_verifyTextfield == nil) {
        [self addSubview:self.verifyTextfield];
        [self addSubview:self.getVerifyCodeBtn];
    }
    else{
        _verifyTextfield.hidden = NO;
        _getVerifyCodeBtn.hidden = NO;
    }
    
    _verifyTextfield.frame = CGRectMake(22, _passwordTextfield.frame.origin.y, ceilf(CGRectGetWidth(self.frame) * 0.48), 40);
    CGFloat x = _verifyTextfield.frame.origin.x + _verifyTextfield.frame.size.width + 10;
    _getVerifyCodeBtn.frame = CGRectMake(x, _verifyTextfield.frame.origin.y,CGRectGetWidth(self.frame) - x - 22, 40);
}

- (void)textFieldNeedResignFirstResponder
{
    if (_phoneTextfield.isFirstResponder) {
        [_phoneTextfield resignFirstResponder];
    }
    
    if (_passwordTextfield.isFirstResponder) {
        [_passwordTextfield resignFirstResponder];
    }
    
    if (_verifyTextfield.isFirstResponder) {
        [_verifyTextfield resignFirstResponder];
    }
}

#pragma -mark IKCompanyTypeViewDelegate


- (void)selectCompanyTypeViewDidSelectIndexPath:(NSIndexPath *)indexPath selectContent:(NSString *)select
{
    NSLog(@"select = %@",select);
    
    [_chooseTypeBtn setTitle:select forState:UIControlStateNormal];
    [_chooseTypeBtn setTitleColor:IKMainTitleColor forState:UIControlStateNormal];
    
    _classifyView.hidden = YES;
    _chooseTypeBtn.isClick = NO;
}


#pragma -mark UITextFieldDelegate

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _phoneTextfield) {
        NSLog(@"_phoneTextfield = %@",textField.text);
    }
    else if (textField == _passwordTextfield){
        NSLog(@"_passwordTextfield.text = %@",_passwordTextfield.text);
    }
    else{
        NSLog(@"_passwordTextfield.text = %@",_verifyTextfield.text);
    }
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//
//}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textField = %@",textField);
    [self textFieldNeedResignFirstResponder];
    return YES;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
