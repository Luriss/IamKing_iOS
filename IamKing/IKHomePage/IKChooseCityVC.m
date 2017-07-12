//
//  IKChooseCityVC.m
//  IamKing
//
//  Created by Luris on 2017/7/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKChooseCityVC.h"

@interface IKChooseCityVC ()

@property (nonatomic, strong)IKView *bottomView;

@end

@implementation IKChooseCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self initBottomView];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showBottomView];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self hideBottomView];
}

- (void)initBottomView
{
    IKView *bottomView = [[IKView alloc] initWithFrame:self.view.frame];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    _bottomView = bottomView;
    
    _bottomView.transform = CGAffineTransformMakeTranslation(0, -IKSCREENH_HEIGHT);
}




- (void)showBottomView
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        _bottomView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];

}

- (void)hideBottomView
{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        _bottomView.transform = CGAffineTransformMakeTranslation(0, -IKSCREENH_HEIGHT);
    } completion:^(BOOL finished) {
        [_bottomView removeFromSuperview];
        _bottomView = nil;
    }];
}


- (void)dismissSelf
{
    _locationBlock(@"hangzhou");
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        _bottomView.transform = CGAffineTransformMakeTranslation(0, -IKSCREENH_HEIGHT);
    } completion:^(BOOL finished) {
        [_bottomView removeFromSuperview];
        _bottomView = nil;
        
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }];
    
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
