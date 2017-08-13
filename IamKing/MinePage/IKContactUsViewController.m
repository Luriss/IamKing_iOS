//
//  IKContactUsViewController.m
//  IamKing
//
//  Created by Luris on 2017/8/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKContactUsViewController.h"

@interface IKContactUsViewController ()

@end

@implementation IKContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavTitle];
    [self initLeftBackItem];

    [self initLogoView];
//    [self initWxView];
//    [self initPhoneView];
//    [self initCompanyName];
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"联系国王";
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


- (void)initLogoView
{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x - 40, 150, 80, 80)];
    
//        imageV.backgroundColor = [UIColor cyanColor];
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IK_contactUs" ofType:@"png"]];
    [imageV setImage:image];
    [self.view addSubview:imageV];
   
    
    UIImageView *contactInfo = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x - 112.5, 250, 225, 184)];
    UIImage *image2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IK_contactInfo" ofType:@"png"]];
    contactInfo.userInteractionEnabled = YES;
    [contactInfo setImage:image2];
    [self.view addSubview:contactInfo];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,35, 200, 50)];
    
    [contactInfo addSubview:view];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone)];
    [view addGestureRecognizer:tap];
    
}

//
//- (void)initWxView
//{
//    UILabel *wxLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 80, _totalH + 20, 160, 50)];
//    wxLabel.text = @"WeChat: iamking_2016";
//    wxLabel.textColor = IKGeneralBlue;
//    wxLabel.font = [UIFont systemFontOfSize:15.0f];
//    wxLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:wxLabel];
//    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, 160, 1)];
//    lineView.backgroundColor = IKLineColor;
//    [wxLabel addSubview:lineView];
//    _totalH += 70;
//}
//
//
//- (void)initPhoneView
//{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(self.view.center.x - 75, _totalH, 150, 50);
//
//    [button setTitle:@"Call: 0571-28952466" forState:UIControlStateNormal];
//    [button setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
//    
//    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
//    
//    [self.view addSubview:button];
//
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, 150, 1)];
//    lineView.backgroundColor = IKLineColor;
//    [button addSubview:lineView];
//    
//    _totalH += 50;
//}
//
//
//- (void)initCompanyName
//{
//    UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 67, _totalH, 134, 50)];
//    companyLabel.text = @"杭州狂派科技有限公司";
//    companyLabel.textColor = IKGeneralBlue;
//    companyLabel.font = [UIFont systemFontOfSize:13.0f];
//    companyLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:companyLabel];
//    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, 134, 1)];
//    lineView.backgroundColor = IKLineColor;
//    [companyLabel addSubview:lineView];
//    _totalH += 50;
//}

- (void)callPhone
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://0571-28952466"]];
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
