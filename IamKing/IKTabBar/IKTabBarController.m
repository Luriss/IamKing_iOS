//
//  IKTabBarController.m
//  IamKing
//
//  Created by Luris on 2017/7/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTabBarController.h"
#import "IKHomePageVC.h"

@interface IKTabBarController ()<UITabBarControllerDelegate,UITabBarDelegate>

@end

@implementation IKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = self.tabBar.frame;
    [self.tabBar removeFromSuperview];  //移除TabBarController自带的下部的条

    IKHomePageVC *c1 = [[IKHomePageVC alloc]init];
    IKNavigationController *nav = [[IKNavigationController alloc] initWithRootViewController:c1];
    
    UIViewController *c2 = [[UIViewController alloc]init];
    c2.view.backgroundColor = [UIColor whiteColor];
    UIViewController *c3 = [[UIViewController alloc]init];
    c3.view.backgroundColor = [UIColor yellowColor];

    UIViewController *c4 = [[UIViewController alloc]init];
    c4.view.backgroundColor = [UIColor orangeColor];

    
    [self addChildViewController:nav];
    [self addChildViewController:c2];
    [self addChildViewController:c3];
    [self addChildViewController:c4];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    IKTabBar *tabBar = [[IKTabBar alloc] initWithFrame:rect];
    
    tabBar.tabBarItemAttributes = @[@{kIKTabBarItemTitle:@"职位", kIKTabBarItemNormalImageName: @"IK_applyJob", kIKLTabBarItemSelectedImageName: @"IK_applyJobSelected"},@{kIKTabBarItemTitle : @"公司", kIKTabBarItemNormalImageName : @"IK_homePage", kIKLTabBarItemSelectedImageName : @"IK_homePageSelected"}, @{kIKTabBarItemTitle:@"消息", kIKTabBarItemNormalImageName:@"IK_Message", kIKLTabBarItemSelectedImageName:@"IK_MessageSelected"}, @{kIKTabBarItemTitle : @"我", kIKTabBarItemNormalImageName:@"IK_me", kIKLTabBarItemSelectedImageName:@"IK_meSelected"}];

    [self.view addSubview:tabBar];
    
    self.customTabBar = tabBar;
    
    // Do any additional setup after loading the view.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

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
