//
//  IKSearchVC.m
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSearchVC.h"
#import "IKSearchResultView.h"
#import "IKJobInfoModel.h"
#import "IKTagsView.h"
#import "IKImageWordView.h"


@interface IKSearchVC ()<IKSearchViewDelegate,IKTagsViewDelegate,UIScrollViewDelegate>
{
    IKSearchResultView    *_searchResultView;
}

@property (nonatomic,strong)IKSearchView *searchView;
@property (nonatomic,strong)UIScrollView * scrollView;


@end

@implementation IKSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSearchView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];

    [self initTagsView];

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
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _searchView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}


- (void)initSearchView
{
    _searchView = [[IKSearchView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
    _searchView.delegate = self;
    _searchView.hiddenColse = NO;
    _searchView.canSearch = YES;
    _searchView.backgroundColor = [UIColor whiteColor];
    _searchView.transform = CGAffineTransformMakeTranslation(0, 44);
    [_searchView.searchBar becomeFirstResponder];
    self.navigationItem.titleView = _searchView;

}

- (void)initTagsView
{
    IKTagsView *tag1 = [[IKTagsView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_scrollView.bounds), 218)];
    tag1.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:tag1 ];
    
    tag1.delegate = self;
    tag1.data = @[@"私人教练",@"私教主管",@"私教经理",@"私教总监",@"团课教练",@"团课主管",@"团课经理",@"团课总监",@"会籍销售",@"销售主管",@"销售经理",@"销售总监"];
    tag1.lineSpacing = 10.0;
    tag1.verticalSpacing = 20.0;
    tag1.tagHeight = 25;
    tag1.tagBorderWidth = 1;
    tag1.tagBorderColor = IKSubHeadTitleColor;
    tag1.tagCornerRadius = tag1.tagHeight *0.5;
    tag1.tagTitleColor = IKSubHeadTitleColor;
    tag1.tagFont = IKSubTitleFont;
    
    IKImageWordView *view1 = [[IKImageWordView alloc] init];
    view1.imageView.image = [UIImage imageNamed:@"IK_hot"];
    view1.label.text = @"热门职位";
    tag1.titleView = view1;
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = IKLineColor;
    [_scrollView addSubview:line1];
    
    __block CGFloat newHeight = 0;
    [tag1 createViewAdjustViewFrame:^(CGRect newFrame) {
        newHeight = CGRectGetHeight(newFrame);
        line1.frame = CGRectMake(10, newHeight, IKSCREEN_WIDTH - 20, 1);
    }];
    
    IKTagsView *tag2 = [[IKTagsView alloc] initWithFrame:CGRectMake(0, newHeight, CGRectGetWidth(self.view.bounds), 218)];
    [_scrollView addSubview:tag2 ];
    
    //    tag.backgroundColor = [UIColor cyanColor];
    tag2.delegate = self;
    tag2.data = @[@"TRX",@"NTC",@"EXOS",@"CrossFit",@"MFT",@"CPR",@"lesmills",@"SPINNING",@"Zumba",@"Salsation",@"PILOXING",@"POP DANCE",];
    tag2.lineSpacing = 10.0;
    tag2.verticalSpacing = 20.0;
    tag2.tagHeight = 25;
    tag2.tagBorderWidth = 1;
    tag2.tagBorderColor = IKSubHeadTitleColor;
    tag2.tagCornerRadius = tag2.tagHeight *0.5;
    tag2.tagTitleColor = IKSubHeadTitleColor;
    tag2.tagFont = IKSubTitleFont;
    
    IKImageWordView *view2 = [[IKImageWordView alloc] init];
    view2.imageView.image = [UIImage imageNamed:@"IK_hot"];
    view2.label.text = @"热门技能";
    tag2.titleView = view2;
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = IKLineColor;
    [_scrollView addSubview:line2];
    
    [tag2 createViewAdjustViewFrame:^(CGRect newFrame) {
        newHeight += CGRectGetHeight(newFrame);
        line2.frame = CGRectMake(10, newHeight, IKSCREEN_WIDTH - 20, 1);
    }];

    IKTagsView *tag3 = [[IKTagsView alloc] initWithFrame:CGRectMake(0, newHeight, CGRectGetWidth(self.view.bounds), 308)];
    [_scrollView addSubview:tag3 ];
    
    //    tag.backgroundColor = [UIColor cyanColor];
    tag3.delegate = self;
    tag3.data = @[@"威尔士健身",@"一兆韦德健身",@"舒适堡健身",@"浩沙健身",@"乐体健身",@"梦氏健身",@"美日健身",@"奇迹健身",@"超级猩猩",@"乐刻健身",@"星健身",@"OneFit",@"RAW FITNESS",@"ReviveGYM",@"RUNNINGCAT",@"DP健身工作室"];
    tag3.lineSpacing = 10.0;
    tag3.verticalSpacing = 20.0;
    tag3.tagHeight = 25;
    tag3.tagBorderWidth = 1;
    tag3.tagBorderColor = IKSubHeadTitleColor;
    tag3.tagCornerRadius = tag3.tagHeight *0.5;
    tag3.tagTitleColor = IKSubHeadTitleColor;
    tag3.tagFont = IKSubTitleFont;
    
    IKImageWordView *view3 = [[IKImageWordView alloc] init];
    view3.imageView.image = [UIImage imageNamed:@"IK_hot"];
    view3.label.text = @"热门公司";
    tag3.titleView = view3;
    

    [tag3 createViewAdjustViewFrame:^(CGRect newFrame) {
        newHeight += CGRectGetHeight(newFrame);
    }];
    
    _scrollView.contentSize = CGSizeMake(IKSCREEN_WIDTH, (newHeight>IKSCREENH_HEIGHT)?newHeight:(IKSCREENH_HEIGHT + 20));
    
}


- (void)startSearchViewAnimation
{
    _searchView.hidden = NO;
    
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_searchView.searchBar.isFirstResponder) {
        [_searchView.searchBar resignFirstResponder];
    }
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


- (void)tagViewDidSelectedTagWithTitle:(NSString *)title  selectedIndex:(NSUInteger)index
{
    [self showSearchResultViewWithSearchText:title withID:nil];
}

- (void)showSearchResultViewWithSearchText:(NSString *)searchText withID:(NSString *)textID
{
    _searchView.searchBar.text = searchText;
    
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
