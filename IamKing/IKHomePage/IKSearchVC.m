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
#import "IKJobDetailVC.h"
#import "IKCompanyDetailVC.h"


extern NSString * currentSelectedCityId;

@interface IKSearchVC ()<IKSearchViewDelegate,IKTagsViewDelegate,UIScrollViewDelegate,IKSearchResultViewDelegate>
{
    IKSearchResultView    *_searchResultView;
}

@property (nonatomic,strong)IKSearchView *searchView;
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UIView *navView;
@property (nonatomic,copy)NSString *currentSearchText;
@property (nonatomic, nonnull ,strong)NSMutableDictionary *mutableJobDict;
@property (nonatomic, nonnull ,strong)NSMutableDictionary *mutableCompDict;
@property (nonatomic, assign)IKSelectedType selectType;

@end

@implementation IKSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationView.hidden = YES;
    self.selectType = IKSelectedTypeJob;
    
    [self initNavView];
    
    
    [self initSearchView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, self.view.bounds.size.height - 64)];
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];

    [self initTagsView];

    _searchResultView = [[IKSearchResultView alloc] initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64)];
    _searchResultView.backgroundColor = [UIColor whiteColor];
    _searchResultView.hidden = YES;
    _searchResultView.delegate = self;
    
    [self.view insertSubview:_searchResultView belowSubview:_navView];
    // Do any additional setup after loading the view.
}


- (NSMutableDictionary *)mutableJobDict
{
    if (_mutableJobDict == nil) {
        _mutableJobDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:currentSelectedCityId,@"cityId",@"16",@"pageSize",@"",@"searchString",@"0",@"companyType",@"1",@"page",@"0",@"salaryType",@"0",@"workExperienceType", nil];
    }
    return _mutableJobDict;
}


- (NSMutableDictionary *)mutableCompDict
{
    if (_mutableCompDict == nil) {
        _mutableCompDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:currentSelectedCityId,@"cityId",@"16",@"pageSize",@"",@"searchString",@"0",@"companyType",@"1",@"page",@"0",@"businessType",@"0",@"appraiseLevel",@"0",@"shopType", nil];
    }
    return _mutableCompDict;
}



- (void)initNavView
{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 64)];
    navView.backgroundColor = IKGeneralBlue;
    [self.view addSubview:navView];
    
    _navView = navView;
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
    _searchView = [[IKSearchView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.bounds), 44)];
    _searchView.delegate = self;
    _searchView.hiddenColse = NO;
    _searchView.canSearch = YES;
    _searchView.backgroundColor = [UIColor clearColor];
    _searchView.transform = CGAffineTransformMakeTranslation(0, 44);
    [_searchView.searchBar becomeFirstResponder];

    [_navView addSubview:_searchView];
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


#pragma mark -  IKSearchResultViewDelegate

- (void)searchResultViewClickHideKeyBorad
{
    [_searchView.searchBar resignFirstResponder];
}


- (void)searchResultViewSelectType:(IKSelectedType)type
{
    self.selectType = type;
    
    if (type == IKSelectedTypeJob) {
        [self getSearchJobResult:self.mutableJobDict];
    }
    else{
        [self getSearchCompanytResult:self.mutableCompDict];
    }
}


- (void)searchResultViewdidSelectJobWithModel:(IKJobInfoModel *)model
{
    IKJobDetailVC *deatail = [[IKJobDetailVC alloc] init];
    deatail.jobModel = model;
    [self.navigationController pushViewController:deatail animated:YES];
}


- (void)searchResultViewdidSelectCompanyWithModel:(IKCompanyInfoModel *)model
{
    IKCompanyDetailVC *vc = [[IKCompanyDetailVC alloc] init];
    vc.companyInfoModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)searchResultViewdidSelectJobType:(IKSelectedSubType)type selectIndex:(NSInteger )index
{
    NSLog(@"type = %ld,selectStr = %ld",type,index);
    
    switch (type) {
        case IKSelectedSubTypeJobAddress:
        {
            [self.mutableJobDict setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"cityId"];
        }
            break;
            
        case IKSelectedSubTypeJobCompanyType:
        {
            [self.mutableJobDict setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"companyType"];
        }
            break;
            
        case IKSelectedSubTypeJobSalary:
        {
            [self.mutableJobDict setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"salaryType"];
        }
            break;
            
        case IKSelectedSubTypeJobExperience:
        {
            [self.mutableJobDict setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"workExperienceType"];
        }
            break;
            
        case IKSelectedSubTypeCompanyType:
        {
            [self.mutableCompDict setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"companyType"];
        }
            break;
            
        case IKSelectedSubTypeCompanyNumberOfStore:
        {
            [self.mutableCompDict setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"shopType"];
        }
            break;
            
        case IKSelectedSubTypeCompanyDirectlyToJoin:
        {
            [self.mutableCompDict setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"businessType"];
        }
            break;
            
        case IKSelectedSubTypeCompanyEvaluation:
        {
            [self.mutableCompDict setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"appraiseLevel"];
        }
            break;
            
        default:
            break;
    }

    
    if (self.selectType == IKSelectedTypeJob) {
        [self getSearchJobResult:self.mutableJobDict];
    }
    else{
        [self getSearchCompanytResult:self.mutableCompDict];
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
    IKLog(@"searchViewSearchBarSearchButtonClicked = %@",searchBar.text);
    self.currentSearchText = searchBar.text;

    [self showSearchResultView];
    [self.mutableJobDict setObject:self.currentSearchText forKey:@"searchString"];
    [self.mutableCompDict setObject:self.currentSearchText forKey:@"searchString"];
    
    [self getSearchJobResult:self.mutableJobDict];
}


- (void)tagViewDidSelectedTagWithTitle:(NSString *)title  selectedIndex:(NSUInteger)index
{
    [self.mutableJobDict setObject:title forKey:@"searchString"];
    [self.mutableCompDict setObject:title forKey:@"searchString"];

    self.currentSearchText = title;
    [self showSearchResultView];
    
    _searchView.searchBar.text = title;
    [self getSearchJobResult:self.mutableJobDict];
}

- (void)showSearchResultViewWithSearchText:(NSString *)searchText withID:(NSString *)textID
{
    _searchView.searchBar.text = searchText;
    self.currentSearchText = searchText;
    [self showSearchResultView];
}

- (void)showSearchResultView
{
    if (_searchResultView.hidden) {
        _searchResultView.hidden = NO;
    }
    
    _scrollView.hidden = YES;
    [_searchView.searchBar resignFirstResponder];

}


- (void)getSearchJobResult:(NSDictionary *)param
{
    NSLog(@"param ====== %@",param);
    [[IKNetworkManager shareInstance] getSearchPageJobInfoWithParam:param backData:^(NSArray *dataArray, BOOL success) {
        
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _searchResultView.jobDataArray = [dataArray copy];
                [_searchResultView reloadData];
            });
        }
    }];
}

- (void)getSearchCompanytResult:(NSDictionary *)param
{
    [[IKNetworkManager shareInstance] getSearchPageCompanyInfoWithParam:param backData:^(NSArray *dataArray, BOOL success) {
        
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _searchResultView.compDataArray = [dataArray copy];
                [_searchResultView reloadData];
            });
        }
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
