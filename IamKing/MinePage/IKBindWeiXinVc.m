//
//  IKBindWeiXinVc.m
//  IamKing
//
//  Created by Luris on 2017/8/14.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKBindWeiXinVc.h"
#import "LRToastView.h"

@interface IKBindWeiXinVc ()

@end

@implementation IKBindWeiXinVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavTitle];
    [self initLeftBackItem];
    [self initSubViews];
    
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"微信绑定";
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


- (void)initSubViews
{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x - 32, 144, 64, 64)];
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IK_weixin_128" ofType:@"png"]];
    [imageV setImage:image];
    [self.view addSubview:imageV];
    
    UIButton *weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    weixinBtn.backgroundColor = IkGeneralGreen;
    weixinBtn.frame = CGRectMake(40, 270, IKSCREEN_WIDTH - 80, 40);
    [weixinBtn setTitle:@"在微信中打开进行绑定" forState:UIControlStateNormal];
    [weixinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [weixinBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateDisabled];
    weixinBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [weixinBtn setBackgroundImage:[UIImage GetImageWithColor:IkGeneralGreen size:CGSizeMake(10, 1)] forState:UIControlStateNormal];
    [weixinBtn setBackgroundImage:[UIImage GetImageWithColor:IkGeneralGreenClick size:CGSizeMake(10, 1)] forState:UIControlStateHighlighted];
    weixinBtn.layer.cornerRadius = 6;
    weixinBtn.layer.masksToBounds = YES;
    [weixinBtn addTarget:self action:@selector(weixinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weixinBtn];
}

- (void)weixinBtnClick:(UIButton *)button
{
    [LRToastView showTosatWithText:@"正在开发中" inView:self.view];
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
