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
    CGSize size=CGSizeMake(CGRectGetWidth(self.tabBar.bounds)/self.tabBar.items.count,CGRectGetHeight(self.tabBar.bounds));
    
    UIImage *image = [UIImage GetImageWithColor:IKGeneralLightGray size:size];
    IKLog(@"image = %@",image);
    [self.tabBar setSelectionIndicatorImage:[image resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch]];
    
//    [self.tabBar setUnselectedItemTintColor:IKGeneralLightGray];
    self.delegate = self;
    [self setTabBarTitle:@[@"职位",@"公司",@"消息",@"我"] imageName:@[@"IK_homePage",@"IK_applyJob",@"IK_findPeople",@"IK_me"] isCompany:YES];
    //[self setTabBarTitle:@[@"首页",@"求职",@"我"] imageName:@[@"homePage",@"applyJob",@"me"] isCompany:NO];

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
    IKNavigationController *nav = [[IKNavigationController alloc] initWithRootViewController:c1];

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
    
    NSDictionary *normalAttri = @{NSFontAttributeName :[UIFont systemFontOfSize:12.0f],NSForegroundColorAttributeName : IKSubHeadTitleColor};
    NSDictionary *selectAttri = @{NSFontAttributeName :[UIFont systemFontOfSize:12.0f],NSForegroundColorAttributeName : IKGeneralBlue};
    
    c1.tabBarItem.imageInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
    
    c1.tabBarItem.image = [[UIImage imageNamed:@"IK_applyJob"]
                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [c1.tabBarItem setTitleTextAttributes:normalAttri forState:UIControlStateNormal];
    [c1.tabBarItem setTitleTextAttributes:selectAttri forState:UIControlStateSelected];
    
    c1.tabBarItem.selectedImage = [[UIImage imageNamed:@"IK_applyJobSelected"]
                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    c2.tabBarItem.imageInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
    
    c2.tabBarItem.image = [[UIImage imageNamed:@"IK_homePage"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    c2.tabBarItem.selectedImage = [[UIImage imageNamed:@"IK_homePageSelected"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [c2.tabBarItem setTitleTextAttributes:normalAttri forState:UIControlStateNormal];
    [c2.tabBarItem setTitleTextAttributes:selectAttri forState:UIControlStateSelected];
    

    c3.tabBarItem.imageInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
    
    c3.tabBarItem.image = [[UIImage imageNamed:@"IK_Message"]
                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    c3.tabBarItem.selectedImage = [[UIImage imageNamed:@"IK_MessageSelected"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [c3.tabBarItem setTitleTextAttributes:normalAttri forState:UIControlStateNormal];
    [c3.tabBarItem setTitleTextAttributes:selectAttri forState:UIControlStateSelected];
    

    c4.tabBarItem.imageInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
    
    c4.tabBarItem.image = [[UIImage imageNamed:@"IK_me"]
                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    c4.tabBarItem.selectedImage = [[UIImage imageNamed:@"IK_meSelected"]
                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [c4.tabBarItem setTitleTextAttributes:normalAttri forState:UIControlStateNormal];
    [c4.tabBarItem setTitleTextAttributes:selectAttri forState:UIControlStateSelected];
    
    self.oldSelecteditem = c1.tabBarItem;
    
    [self addChildViewController:nav];
    [self addChildViewController:c2];
    [self addChildViewController:c3];
    [self addChildViewController:c4];

//    [self setViewControllers:@[nav,c2,c3,c4]];

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
