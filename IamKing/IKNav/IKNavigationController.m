//
//  IKNavigationController.m
//  IamKing
//
//  Created by Luris on 2017/7/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKNavigationController.h"

@interface IKNavigationController ()

@end

@implementation IKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationBar.alpha = 0.5f;
    // Do any additional setup after loading the view.
}





- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 影藏底部的tabbar。
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    
    [super pushViewController:viewController animated:animated];
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
