//
//  IKNavigationController.m
//  IamKing
//
//  Created by Luris on 2017/7/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKNavigationController.h"
#import "IKNavView.h"

@interface IKNavigationController ()<UINavigationControllerDelegate>

@property(nonatomic,strong)IKNavView *iconView;
@property(nonatomic,strong)UIButton *rightButton;

@end

@implementation IKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.delegate = self;
    // 需要在隐藏导航栏之前调用，否则将无法正常隐藏
    [self setNavigationTitleView];
     [self setRightNavBarItem];
    //[self setNavigationBarHidden:YES animated:NO];

    // Do any additional setup after loading the view.
}


// 将导航栏上自定义的view隐藏
- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    [super setNavigationBarHidden:hidden animated:animated];
    
    if (_iconView) {
        _iconView.hidden = hidden;
    }
    
    if (_rightButton) {
        _rightButton.hidden = hidden;
    }
    
}


- (void)hideCustomView
{
    if (_iconView && !_iconView.hidden) {
        _iconView.hidden = YES;
    }
    
    
    if (_rightButton && !_rightButton.hidden) {
        _rightButton.hidden = YES;
    }
}


- (void)showCustomView
{
    if (_iconView && _iconView.hidden) {
        _iconView.hidden = NO;
    }
    
    
    if (_rightButton && _rightButton.hidden) {
        _rightButton.hidden = NO;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 影藏底部的tabbar。
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    
    [super pushViewController:viewController animated:animated];
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 切换到非首页时隐藏导航栏自定义的view
    if ([NSStringFromClass([viewController class]) isEqualToString:@"IKHomePageVC"]) {
        [self showCustomView];
    }
    else{
        [self hideCustomView];
    }
    
    NSLog(@"interactivePopGestureRecognizer = %@",navigationController.interactivePopGestureRecognizer);

}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"11111 %@",viewController);
    
    NSLog(@"interactivePopGestureRecognizer = %ld",navigationController.interactivePopGestureRecognizer.state);
    
    NSLog(@"%@",navigationController.topViewController);
}

- (void)setNavigationTitleView
{
    _iconView = [[IKNavView alloc]initWithFrame: CGRectMake(([UIScreen mainScreen].bounds.size.width - 100)*0.5, 0,100, 44)];
    _iconView.backgroundColor = [UIColor redColor];
    
    self.navigationItem.titleView = _iconView;
}


-(void)setRightNavBarItem
{
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [_rightButton addTarget:self action:@selector(rightNavBarItemClick:)
     forControlEvents:UIControlEventTouchUpInside];
    _rightButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 0, 50, 44);
    _rightButton.backgroundColor = [UIColor redColor];
    
    [self.navigationBar addSubview:_rightButton];
}


- (void)rightNavBarItemClick:(UIButton *)button
{
    NSLog(@"rightNavBarItemClick");
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
