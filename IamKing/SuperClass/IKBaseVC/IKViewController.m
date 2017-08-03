//
//  IKViewController.m
//  IamKing
//
//  Created by Luris on 2017/7/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKViewController.h"


@interface IKViewController ()
@property(nonatomic,strong)UIImageView *shadowImage;
@property(nonatomic,strong)IKTabBarController *tabBarVc;

@end

@implementation IKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    NSLog(@"tabBarController = %@",self.tabBarController);
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHideOrShow];
    
    NSLog(@"self = %@",self);
    
    [self fineNavigationBottomLine:self.tabBarController.navigationController.navigationBar];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.navigationController.viewControllers.count > 1){
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    else{
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.shadowImage.hidden = NO;
}

- (void)fineNavigationBottomLine:(UIView *)view
{
    if ([view isKindOfClass:[UIImageView class]] && (CGRectGetHeight(view.bounds) <= 1.0)) {
        self.shadowImage = (UIImageView *)view;
        self.shadowImage.hidden = YES;
        return;
    }
    
    for (UIView *subview in view.subviews) {
        [self fineNavigationBottomLine:subview];
    }
}


- (void)setTabBarHideOrShow
{
    NSString *selfClass = NSStringFromClass([self class]);
    if ([selfClass isEqualToString:@"IKHomePageVC"] ||
        [selfClass isEqualToString:@"IKCompanyViewController"] ||
        [selfClass isEqualToString:@"IKMineViewController"] ||
        [selfClass isEqualToString:@"IKMessageViewController"])
    {
        NSLog(@"tabBarController 1 = %@",self.tabBarController);
        [self showTabBar];
    }
    else{
        [self hideTabBar];
    }
}


- (void)showTabBar
{
    [self showOrHideTabBar:YES];
}


- (void)hideTabBar
{
    [self showOrHideTabBar:NO];
}

- (void)showOrHideTabBar:(BOOL )isShow
{
    // 影藏底部的tabbar。
    IKTabBarController *tabBarController = nil;
    
    if ([self.tabBarController isKindOfClass:[IKTabBarController class]]) {
        tabBarController = (IKTabBarController *)self.tabBarController;
    }
    else{
        UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
        UIViewController *vc = keyWindow.rootViewController;
        if ([vc isKindOfClass:[IKTabBarController class]] ) {
            tabBarController = (IKTabBarController *)vc;
        }
    }
    
    tabBarController.customTabBar.hidden = !isShow ;
    tabBarController.tabBarTopLine.hidden = !isShow;
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
