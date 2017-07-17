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

@property(nonatomic,strong)UITabBarItem *oldSelecteditem;
@end

@implementation IKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
//
//    [self.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"IK_tabbarSelectImage"]];
    
//    [self.tabBar setUnselectedItemTintColor:IKGeneralLightGray];
    self.delegate = self;
    [self setTabBarTitle:@[@"首页",@"求职",@"招聘",@"我"] imageName:@[@"IK_homePage",@"IK_applyJob",@"IK_findPeople",@"IK_me"] isCompany:YES];
    //[self setTabBarTitle:@[@"首页",@"求职",@"我"] imageName:@[@"homePage",@"applyJob",@"me"] isCompany:NO];

    NSDictionary *normalAttri = @{NSFontAttributeName :[UIFont systemFontOfSize:12.0f],NSForegroundColorAttributeName : IKSubHeadTitleColor};
    NSDictionary *selectAttri = @{NSFontAttributeName :[UIFont systemFontOfSize:12.0f],NSForegroundColorAttributeName : IKGeneralBlue};

    NSArray *items = self.tabBar.items;
    UITabBarItem *homeItem = items[0];
    homeItem.imageInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);

    homeItem.image = [[UIImage imageNamed:@"IK_homePage"]
                      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [homeItem setTitleTextAttributes:normalAttri forState:UIControlStateNormal];
    [homeItem setTitleTextAttributes:selectAttri forState:UIControlStateSelected];

    homeItem.selectedImage = [[UIImage imageNamed:@"IK_homePageSelected"]
                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   
    UITabBarItem *jobItem = items[1];
    jobItem.imageInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);

    jobItem.image = [[UIImage imageNamed:@"IK_applyJob"]
                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    jobItem.selectedImage = [[UIImage imageNamed:@"IK_applyJobSelected"]
                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [jobItem setTitleTextAttributes:normalAttri forState:UIControlStateNormal];
    [jobItem setTitleTextAttributes:selectAttri forState:UIControlStateSelected];
    
    UITabBarItem *findItem = items[2];
    findItem.imageInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);

    findItem.image = [[UIImage imageNamed:@"IK_findPeople"]
                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    findItem.selectedImage = [[UIImage imageNamed:@"IK_findPeopleSelected"]
                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [findItem setTitleTextAttributes:normalAttri forState:UIControlStateNormal];
    [findItem setTitleTextAttributes:selectAttri forState:UIControlStateSelected];
    
    UITabBarItem *meItem = items[3];
    meItem.imageInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);

    meItem.image = [[UIImage imageNamed:@"IK_me"]
                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    meItem.selectedImage = [[UIImage imageNamed:@"IK_meSelected"]
                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [meItem setTitleTextAttributes:normalAttri forState:UIControlStateNormal];
    [meItem setTitleTextAttributes:selectAttri forState:UIControlStateSelected];
    
    self.oldSelecteditem = homeItem;
    // Do any additional setup after loading the view.
}

- (void)setTabBarTitle:(NSArray *)title
             imageName:(NSArray *)image
             isCompany:(BOOL)isCompany
{
    if (isCompany) {
        [self createCompanyVersionVcTitle:title imageName:image];
    }
    else{
        [self createUserVersionVcTitle:title imageName:image];
    }
}

- (void)createCompanyVersionVcTitle:(NSArray *)title
                          imageName:(NSArray *)image
{
    IKHomePageVC *c1 = [[IKHomePageVC alloc]init];
    c1.tabBarItem.title = [title objectAtIndex:0];
    c1.tabBarItem.image = [[UIImage imageNamed:[image objectAtIndex:0]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    c1.tabBarItem.selectedImage = [UIImage imageNamed:@"IK_homePageSelected@3x"];
//    c1.tabBarItem.imageInsets = UIEdgeInsetsMake(45, 45, 45, 45);
    
    
    UIViewController *c2 = [[UIViewController alloc]init];
    c2.view.backgroundColor = [UIColor brownColor];
    c2.tabBarItem.title = [title objectAtIndex:1];
    c2.tabBarItem.image = [UIImage imageNamed:[image objectAtIndex:1]];

//    c2.tabBarItem.image = [[UIImage imageNamed:[image objectAtIndex:1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    c2.tabBarItem.selectedImage = [[UIImage imageNamed:@"IK_applyJobSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    c2.tabBarItem.imageInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    UIViewController *c3 = [[UIViewController alloc]init];
    c3.tabBarItem.title = [title objectAtIndex:2];
    c3.tabBarItem.image = [UIImage imageNamed:[image objectAtIndex:2]];
   
    UIViewController *c4 = [[UIViewController alloc]init];
    c4.tabBarItem.title = [title objectAtIndex:3];
    c4.tabBarItem.image = [UIImage imageNamed:[image objectAtIndex:3]];

    
    [self setViewControllers:@[c1,c2,c3,c4]];

}

- (void)createUserVersionVcTitle:(NSArray *)title
                          imageName:(NSArray *)image
{
    UIViewController *c1 = [[UIViewController alloc]init];
    c1.view.backgroundColor = [UIColor grayColor];
    c1.tabBarItem.title = [title objectAtIndex:0];
    c1.tabBarItem.image = [UIImage imageNamed:[image objectAtIndex:0]];
    
    UIViewController *c2 = [[UIViewController alloc]init];
    c2.view.backgroundColor = [UIColor brownColor];
    c2.tabBarItem.title = [title objectAtIndex:1];
    c2.tabBarItem.image = [UIImage imageNamed:[image objectAtIndex:1]];
    
    UIViewController *c3 = [[UIViewController alloc]init];
    c3.tabBarItem.title = [title objectAtIndex:2];
    c3.tabBarItem.image = [UIImage imageNamed:[image objectAtIndex:2]];
    
    [self setViewControllers:@[c1,c2,c3]];
    
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (![NSStringFromClass([viewController class]) isEqualToString:@"IKHomePageVC"]) {
        self.navigationItem.titleView.hidden = YES;
    }
    else{
        self.navigationItem.titleView.hidden = NO;
    }
    return YES;
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item == self.oldSelecteditem) {
        item.imageInsets = UIEdgeInsetsZero;
        self.oldSelecteditem.imageInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
    }
    self.oldSelecteditem = item;

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
