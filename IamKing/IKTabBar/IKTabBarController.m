//
//  IKTabBarController.m
//  IamKing
//
//  Created by Luris on 2017/7/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTabBarController.h"
#import "IKHomePageVC.h"
#import "IKCompanyViewController.h"
#import "IKMineViewController.h"
#import "IKMessageViewController.h"


NSString *const kIKGetHomePageVcData = @"kIKGetHomePageVcData";
NSString *const kIKGetCompanyPageVcData = @"kIKGetCompanyPageVcData";
NSString *const kIKGetMessagePageVcData = @"kIKGetMessagePageVcData";
NSString *const kIKGetMinePageVcData = @"kIKGetMinePageVcData";


@interface IKTabBarController ()<UITabBarControllerDelegate,UITabBarDelegate>

@end

@implementation IKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = self.tabBar.frame;
    [self.tabBar removeFromSuperview];  //移除TabBarController自带的下部的条

    IKHomePageVC *homePage = [[IKHomePageVC alloc]init];
    IKNavigationController *homePageNav = [[IKNavigationController alloc] initWithRootViewController:homePage];
    
    IKCompanyViewController *company = [[IKCompanyViewController alloc]init];
    IKNavigationController *companyNav = [[IKNavigationController alloc] initWithRootViewController:company];
    
    IKMessageViewController *message = [[IKMessageViewController alloc]init];
    message.view.backgroundColor = [UIColor yellowColor];
    IKNavigationController *messageNav = [[IKNavigationController alloc] initWithRootViewController:message];

    IKMineViewController *mine = [[IKMineViewController alloc]init];
    mine.view.backgroundColor = [UIColor orangeColor];
    IKNavigationController *mineNav = [[IKNavigationController alloc] initWithRootViewController:mine];

    
    [self addChildViewController:homePageNav];
    [self addChildViewController:companyNav];
    [self addChildViewController:messageNav];
    [self addChildViewController:mineNav];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    IKTabBar *tabBar = [[IKTabBar alloc] initWithFrame:rect];
    
    tabBar.tabBarItemAttributes = @[@{kIKTabBarItemTitle:@"职位", kIKTabBarItemNormalImageName: @"IK_applyJob", kIKLTabBarItemSelectedImageName: @"IK_applyJobSelected"},@{kIKTabBarItemTitle : @"公司", kIKTabBarItemNormalImageName : @"IK_homePage", kIKLTabBarItemSelectedImageName : @"IK_homePageSelected"}, @{kIKTabBarItemTitle:@"消息", kIKTabBarItemNormalImageName:@"IK_Message", kIKLTabBarItemSelectedImageName:@"IK_MessageSelected"}, @{kIKTabBarItemTitle : @"我", kIKTabBarItemNormalImageName:@"IK_me", kIKLTabBarItemSelectedImageName:@"IK_meSelected"}];

    [self.view addSubview:tabBar];
    
    self.customTabBar = tabBar;
    
    // Do any additional setup after loading the view.
}

- (void)tabBarControllerDidSelectedIndex:(NSInteger)index
{
    NSLog(@"selectedIndex = %ld",index);
    
    if (index == 0) {
        
    }
    else if (index == 1){
        [IKNotificationCenter postNotificationName:kIKGetCompanyPageVcData object:nil];
    }
    else if (index == 2){
        
    }
    else{
        
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
