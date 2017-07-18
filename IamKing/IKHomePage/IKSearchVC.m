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
#import "IKSearchResultView.h"
#import "IKJobInfoModel.h"


@interface IKSearchVC ()<IKSearchViewDelegate,LRTagsViewDelegate>
{
    IKSearchResultView    *_searchResultView;
}
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
//
    _bottomScrollView.hidden = YES;
    _bottomScrollView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    _searchResultView = [[IKSearchResultView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64)];
    _searchResultView.backgroundColor = [UIColor whiteColor];
    
    IKJobInfoModel  *model = [[IKJobInfoModel alloc] init];
    model.logoImageUrl = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646722_1456498424671_800x600.jpg";
    model.title = @"高级营销总监";
    model.salary = @"13~18k";
    model.address = @"杭州";
    model.experience = @"6~8年";
    model.education = @"本科";
    model.skill1 = @"销售能手好";
    model.skill2 = @"NAFC";
    model.skill3 = @"形象好";
    model.introduce = @"时尚连锁健身俱乐部品牌,致力于提供超乎想象的健身运动体验.在江浙沪,拥有36家直营店铺.时尚连锁健身俱乐部品牌,致力于提供超乎想象的健身运动体验.在江浙沪,拥有36家直营店铺.";
    
    _searchResultView.jobModel = model;
    _searchResultView.hidden = YES;
    [self.view addSubview:_searchResultView];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self startSearchViewAnimation];
    
    _bottomScrollView.hidden = NO;

    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _bottomScrollView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    
    }];

}

- (void)initSearchView
{
    _searchView = [[IKSearchView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
    _searchView.delegate = self;
    _searchView.hiddenColse = NO;
    _searchView.backgroundColor = [UIColor whiteColor];
    [_searchView.searchBar becomeFirstResponder];
    self.navigationItem.titleView = _searchView;

}


- (void)initBottomScrollView
{
    IKScrollView *scrollView = [[IKScrollView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 44 - 230)];
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
    tags.delegate = self;
    [_bottomScrollView addSubview:tags];
    
    NSArray *arr2 = @[@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",];
    CGFloat x2 = arr.count/3;
    LRTagsView *tags2 = [[LRTagsView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(tags.frame) + 5, CGRectGetWidth(self.view.bounds), 35*x2)];
    tags2.title = @"热门技能";
    tags2.titleImageName = @"IK_hot";
    tags2.tagsData = arr2;
    tags2.delegate = self;

    [_bottomScrollView addSubview:tags2];

    NSArray *arr3 = @[@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身"];
    CGFloat x3 = arr.count/3;
    LRTagsView *tags3 = [[LRTagsView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(tags.frame) + 10 + CGRectGetHeight(tags2.frame), CGRectGetWidth(self.view.bounds), 35*x3)];
    tags3.title = @"热门职位";
    tags3.titleImageName = @"IK_hot";
    tags3.tagsData = arr3;
    tags3.delegate = self;

    [_bottomScrollView addSubview:tags3];
    
    
    _bottomScrollView.contentSize = CGSizeMake(IKSCREEN_WIDTH, tags3.frame.origin.y + CGRectGetHeight(tags3.frame));
    
    
}


- (void)startSearchViewAnimation
{
    _searchView.hidden = NO;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _searchView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44);
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


- (void)searchViewStartSearch
{
    [_searchResultView resetOldSelectedView:nil];
    
}


- (void)searchViewSearchBarSearchButtonClicked:(nullable UISearchBar *)searchBar
{
    IKLog(@"searchViewSearchBarSearchButtonClicked");
    
    [self showSearchResultView];
}


- (void)tagsCollectionViewDidSelectItemWithTitle:(nullable NSString *)title
{
    _searchView.searchBar.text = title;
    
    [self showSearchResultView];
}

- (void)showSearchResultView
{
    if (_searchResultView.hidden) {
        _searchResultView.hidden = NO;
    }
    else{
        [_searchResultView reloadData];
    }
    [_searchView.searchBar resignFirstResponder];

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
