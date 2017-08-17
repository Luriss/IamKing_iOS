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


@interface IKTabBarController ()<UITabBarControllerDelegate,UITabBarDelegate,LRTabBarDelegate>

@property(nonatomic, strong)IKHomePageVC *homeVc;
@property(nonatomic, strong)IKCompanyViewController *companyVc;
@property(nonatomic, strong)IKMessageViewController *messageVc;
@property(nonatomic, strong)IKMineViewController *meVc;

@end

@implementation IKTabBarController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[UIImage GetImageWithColor:IKLineColor size:CGSizeMake(IKSCREEN_WIDTH, 1)]];
    
    
    [IKNotificationCenter addObserver:self selector:@selector(refreshTabBarItems) name:@"IKRefreshTabBarItems" object:nil];
    
    [self SetupMainTabBar];
    [self SetCustomAllControllers];
}


- (void)dealloc
{
    [IKNotificationCenter removeObserver:self name:@"IKRefreshTabBarItems" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)SetupMainTabBar{
    LRTabBar *mainTabBar = [[LRTabBar alloc] init];
    mainTabBar.frame = self.tabBar.bounds;
    mainTabBar.delegate = self;
    [self.tabBar addSubview:mainTabBar];
    _customTabBar = mainTabBar;
}

- (void)SetCustomAllControllers{
    NSArray *titles = @[@"职位", @"公司", @"消息", @"我"];
    NSArray *images = @[@"IK_applyJob", @"IK_homePage", @"IK_Message", @"IK_me"];
    NSArray *selectedImages = @[@"IK_applyJobSelected", @"IK_homePageSelected", @"IK_MessageSelected", @"IK_meSelected"];
    
    IKHomePageVC *homePage = [[IKHomePageVC alloc]init];
    
    IKCompanyViewController *company = [[IKCompanyViewController alloc]init];
    
    IKMessageViewController *message = [[IKMessageViewController alloc]init];
    message.view.backgroundColor = [UIColor whiteColor];
    
    IKMineViewController *mine = [[IKMineViewController alloc]init];
    mine.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *viewControllers = @[homePage, company, message, mine];
    
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *childVc = viewControllers[i];
        [self SetupChildVc:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}

- (void)setCompanyAllControllers
{
    IKViewController *find = [[IKViewController alloc] init];
    IKNavigationController *findNav = [[IKNavigationController alloc] initWithRootViewController:find];
    [self addChildViewController:findNav];
    
    [self SetupChildVc:find title:@"我" image:@"IK_me" selectedImage:@"IK_meSelected"];
    
    [self changeButtonInfo];
}

- (void)changeButtonInfo
{
    [self.customTabBar changeButtonTitle:@"人才" image:[UIImage imageNamed:@"IK_findPeople"] selectedImage:[UIImage imageNamed:@"IK_findPeopleSelected"]];
}


- (void)SetupChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
    IKNavigationController *nav = [[IKNavigationController alloc] initWithRootViewController:childVc];
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.title = title;
    [self.customTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
    [self addChildViewController:nav];
}

- (void)refreshTabBarItems
{
    [self setCompanyAllControllers];
    
    self.selectedIndex = 4;
}

#pragma mark --------------------mainTabBar delegate
- (void)tabBar:(LRTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag{
    self.selectedIndex = toBtnTag;
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
