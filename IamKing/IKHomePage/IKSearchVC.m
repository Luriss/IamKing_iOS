//
//  IKSearchVC.m
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSearchVC.h"
#import "IKSearchView.h"
#import "LRTagsView.h"

@interface IKSearchVC ()<IKSearchViewDelegate>
@property(nonatomic,strong)IKSearchView *searchView;
@property(nonatomic,strong)IKScrollView *bottomScrollView;

@end

@implementation IKSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSearchView];
    
    [self initBottomScrollView];
    [self initTagsView];
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

}


- (void)initBottomScrollView
{
    IKScrollView *scrollView = [[IKScrollView alloc] initWithFrame:CGRectMake(0, 65, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 44 - 230)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    
    _bottomScrollView = scrollView;
}

- (void)initTagsView
{
    NSArray *arr = @[@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练"];
    CGFloat x = arr.count/3;
    LRTagsView *tags = [[LRTagsView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 35*x)];
    tags.title = @"热门职位";
    tags.titleImageName = @"IK_hot";
    tags.tagsData = arr;

    [_bottomScrollView addSubview:tags];
    
    NSArray *arr2 = @[@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",];
    CGFloat x2 = arr.count/3;
    LRTagsView *tags2 = [[LRTagsView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(tags.frame) + 5, CGRectGetWidth(self.view.bounds), 35*x2)];
    tags2.title = @"热门技能";
    tags2.titleImageName = @"IK_hot";
    tags2.tagsData = arr2;
    
    [_bottomScrollView addSubview:tags2];

    NSArray *arr3 = @[@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身"];
    CGFloat x3 = arr.count/3;
    LRTagsView *tags3 = [[LRTagsView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(tags.frame) + 10 + CGRectGetHeight(tags2.frame), CGRectGetWidth(self.view.bounds), 35*x3)];
    tags3.title = @"热门职位";
    tags3.titleImageName = @"IK_hot";
    tags3.tagsData = arr3;
    
    [_bottomScrollView addSubview:tags3];
    
    
    _bottomScrollView.contentSize = CGSizeMake(IKSCREEN_WIDTH, tags3.frame.origin.y + CGRectGetHeight(tags3.frame));
    
    
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
