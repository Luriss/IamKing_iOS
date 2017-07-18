//
//  IKSearchResultVC.m
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSearchResultVC.h"
#import "IKSearchView.h"

@interface IKSearchResultVC ()<IKSearchViewDelegate>

@end

@implementation IKSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSearchView];
    // Do any additional setup after loading the view.
}


- (void)initSearchView
{
//    IKSearchView *searchView = [[IKSearchView alloc] init];
//    searchView.delegate = self;
//    [self.view addSubview:searchView];
//    
//    __weak typeof (self) weakSelf = self;
//
//    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.view).offset(20);
//        make.left.and.right.equalTo(weakSelf.view);
//        make.height.mas_equalTo(40);
//    }];
}


#pragma mark -  IKSearchViewDelegate

- (void)searchViewCloseButtonClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)searchViewSearchButtonClick
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
