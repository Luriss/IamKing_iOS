//
//  IKSearchVC.m
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSearchVC.h"
#import "IKSearchView.h"


@interface IKSearchVC ()<IKSearchViewDelegate>
@property(nonatomic,strong)IKSearchView *searchView;

@end

@implementation IKSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSearchView];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startSearchViewAnimation];

}

- (void)initSearchView
{
    _searchView = [[IKSearchView alloc] initWithFrame:CGRectMake(0, 65, CGRectGetWidth(self.view.bounds), 44)];
    _searchView.delegate = self;
    _searchView.hiddenColse = NO;
    _searchView.hidden = YES;
    _searchView.backgroundColor = [UIColor whiteColor];
    [_searchView.searchBar becomeFirstResponder];
    [self.view addSubview:_searchView];
    
//    __weak typeof (self) weakSelf = self;

//    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.view).offset(65);
//        make.left.and.right.equalTo(weakSelf.view);
//        make.height.mas_equalTo(40);
//    }];
}


- (void)startSearchViewAnimation
{
    _searchView.hidden = NO;
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _searchView.frame = CGRectMake(0, 20, CGRectGetWidth(self.view.bounds), 44);
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark -  IKSearchViewDelegate

- (void)searchViewCloseButtonClick
{
    __weak typeof (self) weakSelf = self;
    [self dismissViewControllerAnimated:NO completion:^{
        if ([weakSelf.delegate respondsToSelector:@selector(searchViewControllerDismiss)]) {
            [weakSelf.delegate searchViewControllerDismiss];
        }
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
