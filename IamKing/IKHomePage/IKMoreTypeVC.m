//
//  IKMoreTypeVC.m
//  IamKing
//
//  Created by Luris on 2017/7/12.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKMoreTypeVC.h"
#import "IKSearchView.h"


@interface IKMoreTypeVC ()<IKSearchViewDelegate>

@end

@implementation IKMoreTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initSearchView];
    // Do any additional setup after loading the view.
}


- (void)initSearchView
{
    IKSearchView *searchView = [[IKSearchView alloc] init];
//    searchView.backgroundColor = [UIColor redColor];
    searchView.delegate = self;
    [self.view addSubview:searchView];
    
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
}

- (void)searchViewCloseButtonClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
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
