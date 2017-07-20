//
//  IKHomePageVC.m
//  IamKing
//
//  Created by Luris on 2017/7/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKNavIconView.h"
#import "IKHomePageVC.h"
#import "IKLoopPlayView.h"
#import "IKChooseCityVC.h"
#import "IKLocationManager.h"
#import "IKMoreTypeVC.h"
#import "IKSearchVC.h"
#import "IKSearchView.h"
#import "IKJobTypeView.h"
#import "IKJobInfoScrollView.h"
#import "IKTableView.h"
#import "IKBottomTableViewCell.h"
#import "IKJobInfoModel.h"
#import "IKInfoTableViewCell.h"

static NSString * const loadingAnimationKey = @"loadingAnimationKey";


@interface IKHomePageVC ()<UIScrollViewDelegate,IKChooseCityViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,IKJobTypeViewDelegate,IKSearchViewDelegate,IKSearchViewControllerDelegate,IKBottomTableViewCellDelegate,UIGestureRecognizerDelegate>
{
    BOOL  _navRightBtnHadClick;
    BOOL isScrollToTop;
    BOOL _hadAddViewInSelf;
    
    BOOL _isLoading;
    CGFloat lpHeight;
}
@property(nonatomic,strong)IKNavIconView *navLogoView;
@property(nonatomic,strong)UIBarButtonItem *leftBarBtn;
@property(nonatomic,strong)UIBarButtonItem *rightBarBtn;
@property(nonatomic,strong)IKScrollView *bottomScrollView;

@property(nonatomic,strong)IKTableView *bottomTableView;
@property (nonatomic,strong)IKTableView *jobTableView;
@property (nonatomic,strong)IKJobInfoModel *model;
@property(nonatomic,strong)IKSearchView *searchView;

@property(nonatomic,assign)NSUInteger   selectedTableView;
@property(nonatomic,strong)NSMutableArray<IKTableView *> *infoTableViewArray;
@property(nonatomic,strong)IKJobTypeView *jobTypeView;
@property(nonatomic,strong)UISearchController *searchVc;
@property(nonatomic,strong)IKLoopPlayView *lpView;
@property(nonatomic,strong)UIImageView *loadingView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation IKHomePageVC


#pragma mark - System Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _navRightBtnHadClick = NO;
    _hadAddViewInSelf = NO;
    isScrollToTop = NO;
    _isLoading = NO;
    
    lpHeight = (IKSCREEN_WIDTH/375)*180;
    _infoTableViewArray = [[NSMutableArray alloc] init];
    
    NSLog(@"IKSCREEN_WIDTH = %.0f",lpHeight);
    
    [self testData];
        // 初始化导航栏内容
    [self initNavigationContent];
    
    [self initLoopPlayView];
    
    [self initBottomTableView];
    
    [self initBottomScrollView];
    //    // 职位列表
    [self initTableView];
    
    [self initSearchVC];
    
    IKLog(@"self.navigationController = %@",self.navigationController);
}

- (void)testData
{
    for (int i = 0; i < 10; i ++) {
        
        IKJobInfoModel *model = [[IKJobInfoModel alloc] init];
        
        if (i%2 == 0) {
            model.logoImageUrl = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646705_1456498422529_800x600.jpg";
            model.isAuthen = YES;
            model.title = @"私人教练";
            model.salary = @"20~28k";
            model.address = @"乌鲁木齐";
            model.experience = @"10~20年";
            model.education = @"本科";
            model.skill1 = @"销售能手好";
        }
        else{
            model.logoImageUrl = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646722_1456498424671_800x600.jpg";
            model.isAuthen = NO;
            model.title = @"高级营销总监";
            model.salary = @"13~18k";
            model.address = @"杭州";
            model.experience = @"6~8年";
            model.education = @"本科";
            model.skill1 = @"销售能手好";
            model.skill2 = @"NAFC";
            model.skill3 = @"形象好";
        }
        model.introduce = @"时尚连锁健身俱乐部品牌,致力于提供超乎想象的健身运动体验.在江浙沪,拥有36家直营店铺.时尚连锁健身俱乐部品牌,致力于提供超乎想象的健身运动体验.在江浙沪,拥有36家直营店铺.";
        [self.dataArray addObject:model];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    // 视图显示开始轮播
    [self startLoopPlayView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // 视图消失,停止轮播
    [self stopLoopPlayView];
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    
    return _dataArray;
}

#pragma mark - InitView

- (void)initNavigationContent
{
    // logo
    _navLogoView = [[IKNavIconView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    [self createRightBarItem];
    
    [self createLeftBarItem];
    [self setNavigationContent];
    
}

- (void)createRightBarItem
{
    // 定位
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(showLocationVc:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(10, 20, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(14, 0, 14, 54);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -110, 0, 0);
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    [button setTitleColor:[IKSubHeadTitleColor colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];

    button.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    [button setTitle:@"乌鲁木齐" forState:UIControlStateNormal];
    
    UIImage *image =[UIImage imageByApplyingAlpha:0.8 image:[UIImage imageNamed:@"IK_Address"]];
    [button setImage:[UIImage imageNamed:@"IK_Address"] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];

    _leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)createLeftBarItem
{
    // 分类
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(showClaaifyVc) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 60, 44);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    button.imageEdgeInsets = UIEdgeInsetsMake(14, 20, 14, 34);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -90, 0, 0);
    [button setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    [button setTitleColor:[IKSubHeadTitleColor colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];

    button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [button setTitle:@"分类" forState:UIControlStateNormal];
    
    UIImage *image =[UIImage imageByApplyingAlpha:0.8 image:[UIImage imageNamed:@"IK_classify"]];
    [button setImage:[UIImage imageNamed:@"IK_classify"] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];

    _rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
}


// 设置导航栏内容
- (void)setNavigationContent
{
    IKLog(@"self.navigationController = %@",self.navigationController);

    
    self.navigationItem.rightBarButtonItem = _rightBarBtn;
    self.navigationItem.leftBarButtonItem = _leftBarBtn;
    
    // 导航栏中间logo
    self.navigationItem.titleView = _navLogoView;
}


// 底部 tableView

- (void)initBottomTableView
{
    _bottomTableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64 - 49) style:UITableViewStylePlain];
    _bottomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _bottomTableView.backgroundColor = IKGeneralLightGray;
    _bottomTableView.delegate = self;
    _bottomTableView.dataSource = self;
//    _bottomTableView.bounces = ;
    [self.view addSubview:_bottomTableView];
    
    [_bottomTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}


- (void)initBottomScrollView
{
    IKScrollView *scrollView = [[IKScrollView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT- 64 - 68)];
    //    scrollView.backgroundColor = [UIColor redColor];
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.delaysContentTouches = NO;
    [self.view addSubview:scrollView];
    _bottomScrollView = scrollView;
}




- (void)initLoopPlayView
{
    _lpView = [[IKLoopPlayView alloc]init];
    _lpView.imagesArray = @[
                            @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646722_1456498424671_800x600.jpg",
                            @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646649_1456498410838_800x600.jpg",
                            @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646706_1456498430419_800x600.jpg",
                            @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646723_1456498427059_800x600.jpg",
                            @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646705_1456498422529_800x600.jpg"
                            ];
    _lpView.scrollDirection = IKLPVScrollDirectionHorizontal;
    _lpView.scrollTimeInterval = 4;
    _lpView.pageControlHidden = NO;
    
}


- (void)initTableView
{
    
    _bottomScrollView.contentSize = CGSizeMake(IKSCREEN_WIDTH * 3, IKSCREENH_HEIGHT- 64 - 80);
    
    for (int i = 0; i < 3; i ++) {
        
        IKTableView *tableView = [[IKTableView alloc] initWithFrame:CGRectMake(i *IKSCREEN_WIDTH, 0, IKSCREEN_WIDTH, CGRectGetHeight(_bottomScrollView.frame)) style:UITableViewStylePlain];
        tableView.tag = 1000 + i;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = YES;
        tableView.delegate = self;
        tableView.bounces = YES;
        tableView.dataSource = self;
        tableView.backgroundColor = IKGeneralLightGray;
        [_bottomScrollView addSubview:tableView];
        [_infoTableViewArray addObject:tableView];
    }
    
    self.jobTableView = (IKTableView *)_infoTableViewArray.firstObject;
    self.jobTableView.showsVerticalScrollIndicator = NO;
    
}


- (void)initSearchVC
{
    _searchView = [[IKSearchView alloc] init];
    _searchView.hiddenColse = YES;
    _searchView.hidden = NO;
    _searchView.delegate = self;
}

#pragma mark - Stop & Start LoopPlayView

- (void)startLoopPlayView
{
    [_lpView startAutoScrollPage];
}


- (void)stopLoopPlayView
{
    [_lpView stopAutoScrollPage];
}



#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _bottomTableView) {
        return 2;
    }
    else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _bottomTableView) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                return 45;
            }
            else if (indexPath.row == 1){
                return lpHeight;
            }
            else{
                return 0;
            }
        }
        else{
            return IKSCREENH_HEIGHT- 64 - 70;
        }
    }
    else{
        return (IKSCREEN_WIDTH/375)*110;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _bottomTableView) {
        if (section == 1) {
            return 45;
        }
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView != _bottomTableView) {
        return 30;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_bottomTableView == tableView) {
        if (section == 0) {
            return 2;
        }
        else{
            return 1;
        }
    }
    else{
        return self.dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _bottomTableView) {
        static  NSString *cellId=@"IKBottomTableViewCellId";
        IKBottomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell==nil){
            cell=[[IKBottomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.delegate = self;
        cell.backgroundColor = IKGeneralLightGray;
        if (indexPath.section == 0){
            if (indexPath.row == 0) {
                //                cell.isShowSearchView = YES;
                [cell.contentView addSubview:_searchView];
                [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.contentView).offset(1);
                    make.left.and.right.equalTo(cell.contentView);
                    make.height.mas_equalTo(44);
                }];
            }
            else if (indexPath.row == 1){
                [cell.contentView addSubview:_lpView];
                [_lpView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.contentView).offset(1);
                    make.left.and.right.equalTo(cell.contentView);
                    make.bottom.equalTo(cell.contentView).offset(-2);
                }];
            }
        }
        else{
            [cell addSubview:_bottomScrollView];
            
            [_bottomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell);
                make.left.and.right.and.bottom.equalTo(cell);
            }];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    else{
        static  NSString *cellId=@"IKInfoCellId";
        IKInfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell==nil)
        {
            cell=[[IKInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
        
        [cell addCellData:self.dataArray[indexPath.row]];
        return cell;
    }
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _bottomTableView) {
        _jobTypeView = [[IKJobTypeView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 44)];
        _jobTypeView.backgroundColor = [UIColor whiteColor];
        _jobTypeView.titleArray = @[@"最新职位",@"热门职位",@"推荐职位"];
        _jobTypeView.delegate = self;
        
        return _jobTypeView;
    }
    
    return nil;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView != _bottomTableView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 30)];
        //    view.backgroundColor = [UIColor redColor];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        imageV.image = [UIImage imageNamed:@"IK_loading"];
        imageV.center = CGPointMake(view.center.x, view.center.y);
        
        [view addSubview:imageV];
        
        self.loadingView = imageV;
        return view;
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView != _bottomTableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


#pragma mark - UIScrollViewDelegate

// 是否支持滑动至顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}

// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 判断是上下滑还是左右滑.
    CGPoint point = [scrollView.panGestureRecognizer translationInView:scrollView];
    if ((fabs(point.x) + 5)<fabs(point.y)) {
        NSLog(@"上滑");
        // 上下滑时,禁止 scrollview 滑动.
        _bottomScrollView.scrollEnabled = NO;
    }
    else{
        _bottomTableView.scrollEnabled = YES;
    }
    
    CGFloat x = 0;
    if (iPhone6_6s) {
        x = 223;
    }
    else if (iPhone6P_6sP)
    {
        x = 242;
    }
    else if (iPhone5SE)
    {
        x = 0;
    }
    if (scrollView == _bottomTableView && !isScrollToTop) {
        NSLog(@"lpHeight = %.0f",lpHeight);
        
        
        if (scrollView.contentOffset.y >= (x)) {
            [_bottomTableView setContentOffset:CGPointMake(0, (x))];
            self.jobTableView.showsVerticalScrollIndicator = YES;
            _bottomTableView.showsVerticalScrollIndicator = NO;
            isScrollToTop = YES;
        }
        else{
            isScrollToTop = NO;
            [self.jobTableView setContentOffset:CGPointZero];
        }
    }
    
    if (isScrollToTop && _jobTableView.contentOffset.y > 0) {
        [_bottomTableView setContentOffset:CGPointMake(0,(x))];
        self.jobTableView.showsVerticalScrollIndicator = YES;
    }
    else{
        isScrollToTop = NO;
        _bottomTableView.showsVerticalScrollIndicator = YES;
        self.jobTableView.showsVerticalScrollIndicator = NO;
    }
    
    CGFloat offset = scrollView.contentOffset.y + _jobTableView.frame.size.height;
    
    if (offset >= _jobTableView.contentSize.height) {

        CGFloat x = scrollView.contentOffset.y - (_jobTableView.contentSize.height-_jobTableView.frame.size.height);
        self.loadingView.transform = CGAffineTransformMakeRotation(M_PI*(x/26));
        
    }
    
    
    if (scrollView == _jobTableView) {
        
        if (scrollView.contentOffset.y < 0) {
            [_jobTableView setContentOffset:CGPointZero];
        }
        NSLog(@"y = %.0f",scrollView.contentOffset.y);
    }
    
    
    
}


// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    NSLog(@"scrollViewWillBeginDragging");
    
}

// scrollView 结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
    
    _bottomScrollView.scrollEnabled = YES;

    
    if (scrollView == _jobTableView) {
        
        CGFloat offset = scrollView.contentOffset.y + _jobTableView.frame.size.height;
        
        if (offset >= (_jobTableView.contentSize.height + 26)) {
            
            if (!_isLoading) {
                _isLoading = YES;
                self.jobTableView.contentInset = UIEdgeInsetsMake(0, 0, 26, 0);
                [self startLoadingAnimation];
            }
        }
        else{
            self.jobTableView.contentInset = UIEdgeInsetsZero;
        }
    }
    
}

// scrollView 开始减速（以下两个方法注意与以上两个方法加以区别）
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    //    NSLog(@"scrollViewWillBeginDecelerating");
}

// scrollview 减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _bottomScrollView.scrollEnabled = YES;
    
    // 更改选择项
    CGFloat index = (scrollView.contentOffset.x)/IKSCREEN_WIDTH;
    if (scrollView == _bottomScrollView ) {
        [_jobTypeView adjustBottomLine:index];
        self.selectedTableView = index;
        self.jobTableView = [_infoTableViewArray objectAtIndex:index];
    }
    
}


- (void)startLoadingAnimation
{
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 1;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [self.loadingView.layer addAnimation:animation forKey:loadingAnimationKey];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self stopLoadingAnimation];
        
        [self.dataArray addObjectsFromArray:self.dataArray];
        [self.jobTableView reloadData];
    });
}


- (void)stopLoadingAnimation
{
    [self.loadingView.layer removeAnimationForKey:loadingAnimationKey];
    _isLoading = NO;
    self.jobTableView.contentInset = UIEdgeInsetsZero;
}

#pragma mark - IKJobTypeViewDelegate
-(void)jobTypeViewButtonClick:(UIButton *)button
{
    IKLog(@"button = %@",button);
    
    self.selectedTableView = button.tag-100;
    [_bottomScrollView setContentOffset:CGPointMake((self.selectedTableView-1)*IKSCREEN_WIDTH, 0) animated:YES];
    
}

- (void)searchViewStartSearch
{
    dispatch_async(dispatch_get_main_queue(), ^{
        IKSearchVC *searchvc = [IKSearchVC alloc];
        searchvc.delegate = self;
        searchvc.modalPresentationStyle = UIModalPresentationPopover;
        searchvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        IKNavigationController *nav = [[IKNavigationController alloc] initWithRootViewController:searchvc];
        [self presentViewController:nav animated:NO completion:^{
            
        }];
    });
}

- (void)searchViewControllerDismiss
{
    IKLog(@"searchViewControllerDismiss");
    [_searchView.searchBar resignFirstResponder];
    //
    //    UITableViewCell *cell = [_bottomTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //
    //    [cell.contentView addSubview:_searchView];
    //    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(cell.contentView).offset(1);
    //        make.left.and.right.equalTo(cell.contentView);
    //        make.height.mas_equalTo(44);
    //    }];
    
}


#pragma mark - IKChooseCityViewControllerDelegate

- (void)locationVcDismissChangeNavButtonTitle:(NSString *)title
{
    UIButton *btn = (UIButton *)_leftBarBtn.customView;
    [btn setTitle:title forState:UIControlStateNormal];
    _navRightBtnHadClick = NO;
}

#pragma mark - ButtonAction

- (void)showClaaifyVc
{
    if ([self.presentedViewController isKindOfClass:[IKMoreTypeVC class]]) {
        
        IKLog(@"IKMoreTypeVC had been present,not need present.return.");
        return;
    }
    
    IKMoreTypeVC *moreVC = [[IKMoreTypeVC alloc] init];
    //设置该属性可以使 presentView 在导航栏之下不覆盖原先的 VC
    //    moreVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    moreVC.view.backgroundColor = [UIColor whiteColor];
    
    IKNavigationController *nav = [[IKNavigationController alloc] initWithRootViewController:moreVC];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}


- (void)showLocationVc:(UIButton *)btn
{
    IKChooseCityVC *cityVC = [[IKChooseCityVC alloc] init];
    cityVC.delegate = self;
    
    IKNavigationController *nav = [[IKNavigationController alloc] initWithRootViewController:cityVC];
    [self presentViewController:nav animated:NO completion:^{
        
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
