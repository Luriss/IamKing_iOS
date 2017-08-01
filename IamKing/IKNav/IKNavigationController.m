//
//  IKNavigationController.m
//  IamKing
//
//  Created by Luris on 2017/7/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKNavigationController.h"


@interface IKNavigationController ()<UINavigationControllerDelegate>

@property(nonatomic,strong)UIImageView *shadowImage;

@end

@implementation IKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationBar.barTintColor = [UIColor whiteColor];
//    self.delegate = self;
    
    [self.navigationBar setBackgroundImage:[UIImage GetImageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 64)] forBarMetrics:UIBarMetricsDefault];
//    self.navigationBar.alpha = 0.5f;
    [self fineNavigationBottomLine:self.navigationBar];

    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.shadowImage.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.shadowImage.hidden = NO;
    NSLog(@"viewDidDisappear");

}

- (void)fineNavigationBottomLine:(UIView *)view
{
    if ([view isKindOfClass:[UIImageView class]] && (CGRectGetHeight(view.bounds) <= 1.0)) {
        IKLog(@"======= %@",view);
//        view.backgroundColor = IKLineColor;
//        view.frame = CGRectMake(view.bounds.origin.x, view.bounds.origin.y, view.bounds.size.width, 2);
        view.hidden = YES;
        self.shadowImage = (UIImageView *)view;
        self.shadowImage.hidden = YES;
        return;
    }
    
    for (UIView *subview in view.subviews) {
        [self fineNavigationBottomLine:subview];
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
