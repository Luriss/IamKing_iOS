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
#import "IKHomePageConfig.h"
#import "IKHotCityModel.h"
#import "IKProvinceModel.h"



#define IKJobTypeHeaderHeight   (45.0f)


static NSString * const loadingAnimationKey = @"loadingAnimationKey";


@interface IKHomePageVC ()<UIScrollViewDelegate,IKChooseCityViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,IKJobTypeViewDelegate,IKSearchViewDelegate,IKSearchViewControllerDelegate,IKBottomTableViewCellDelegate,UIGestureRecognizerDelegate>
{
    BOOL  _navRightBtnHadClick;
    BOOL isScrollToTop;
    BOOL _hadAddViewInSelf;
    
    BOOL _isLoading;
    
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
@property(nonatomic,strong)UIImageView *loadMoreView;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,assign)CGFloat lpHeight;
@property(nonatomic,strong)UIImageView *refreshView;
@property(nonatomic,strong)NSArray *hotCity;
@property(nonatomic,strong)NSArray *provinceCityData;
@property(nonatomic,strong)NSArray *jobTypeData;



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
    
    self.lpHeight = 0.48*IKSCREEN_WIDTH;
    _infoTableViewArray = [[NSMutableArray alloc] init];
    
    NSLog(@"IKSCREEN_WIDTH = %.0f",IKSCREENH_HEIGHT );
    
    [self requestHomePageData];
    
//    [self testData];
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

- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSArray alloc] init];
    }
    
    return _dataArray;
}

- (NSArray *)hotCity
{
    if (_hotCity == nil) {
        _hotCity = [[NSArray alloc] init];
    }
    
    return _hotCity;
}

- (NSArray *)provinceCityData
{
    if (_provinceCityData == nil) {
        _provinceCityData = [[NSArray alloc] init];
    }
    
    return _provinceCityData;
}


- (NSArray *)jobTypeData
{
    if (_jobTypeData == nil) {
        _jobTypeData = [[NSArray array] init];
    }
    
    return _jobTypeData;
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
    
    NSString *cityStr = [IKUSERDEFAULT objectForKey:@"selectedCity"];
    [button setTitle:cityStr forState:UIControlStateNormal];
    
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
    _bottomTableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT -64 - 49) style:UITableViewStylePlain];
    _bottomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _bottomTableView.backgroundColor = IKGeneralLightGray;
    _bottomTableView.delegate = self;
    _bottomTableView.dataSource = self;
    _bottomTableView.bounces = YES;
    [self.view addSubview:_bottomTableView];
    
    
    UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(IKSCREEN_WIDTH * 0.5 - 13, -38, 26, 26)];
    imageV1.image = [UIImage imageNamed:@"IK_logo_grey"];
    [_bottomTableView addSubview:imageV1];
    
    UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(IKSCREEN_WIDTH * 0.5 - 15, -40, 30, 30)];
    imageV2.image = [UIImage imageNamed:@"IK_cycle"];
    [_bottomTableView addSubview:imageV2];
    
    self.refreshView = imageV2;
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
                return IKJobTypeHeaderHeight;
            }
            else if (indexPath.row == 1){
                return self.lpHeight;
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
//        cell.backgroundColor = [UIColor clearColor];
        if (indexPath.section == 0){
            if (indexPath.row == 0) {
                cell.isShowSearchView = YES;
                cell.isShowTopLine = YES;
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
//            view.backgroundColor = [UIColor redColor];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(view.center.x - 40, view.center.y - 7.5, 15, 15)];
        imageV.image = [UIImage imageNamed:@"IK_loading"];
        
        [view addSubview:imageV];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(view.center.x - 20, view.center.y - 10, 100, 20)];
        label.text = @"玩命加载中...";
        label.textColor = IKSubHeadTitleColor;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:12.0f];
//        label.backgroundColor = [UIColor redColor];
        [view addSubview:label];
        self.loadMoreView = imageV;
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

    CGFloat offsetY = scrollView.contentOffset.y;

    // 判断是上下滑还是左右滑.
    CGPoint point = [scrollView.panGestureRecognizer translationInView:scrollView];
    if ((fabs(point.x) + 5)<fabs(point.y)) {
        // 上下滑时,禁止 scrollview 滑动.
        _bottomScrollView.scrollEnabled = NO;
    }
    else{
        _bottomTableView.scrollEnabled = YES;
    }
    
    CGFloat lph = [[IKHomePageConfig shareInstance] getLoopPlayViewHight];

    if (scrollView == _bottomTableView) {
        // 底部的 tableView 滑动时,导航栏设置0.95的透明度.
        if (offsetY > 0) {
            [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 0.95;
        }
        else{
            [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1;
        }
        
        // _bottomTableView 拉倒最下面就禁止拉.
        if (offsetY > _bottomTableView.contentSize.height) {
            [_bottomTableView setContentOffset:CGPointMake(0, _bottomTableView.contentSize.height)];
        }
        
//        NSLog(@"scrollView.contentOffset.y = %.0f",scrollView.contentOffset.y);
        
        if (offsetY < 0) {
            CGFloat s = offsetY/30;
            self.refreshView.transform = CGAffineTransformMakeRotation(-2*M_PI*s);
        }
        
        // 判断职位类型是否滑到顶部
        if (!isScrollToTop) {
            // 职位类型滑到了顶部.
            if (offsetY >= (self.lpHeight + IKJobTypeHeaderHeight - 2)) {
                // 这里不能用 self.lpHeight.很奇怪... 只能用数字
                _bottomTableView.contentOffset = CGPointMake(0, (lph + IKJobTypeHeaderHeight - 2));
                _jobTypeView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.95];
                self.jobTableView.showsVerticalScrollIndicator = YES;
                _bottomTableView.showsVerticalScrollIndicator = NO;
                isScrollToTop = YES;
            }
            else{
                isScrollToTop = NO;
                _jobTypeView.backgroundColor = [UIColor whiteColor];
                [self.jobTableView setContentOffset:CGPointZero];
            }
        }
    }
    
    
    if (isScrollToTop && _jobTableView.contentOffset.y > 0) {
        [_bottomTableView setContentOffset:CGPointMake(0,(lph + IKJobTypeHeaderHeight - 2))];
        self.jobTableView.showsVerticalScrollIndicator = YES;
    }
    else{
        isScrollToTop = NO;
        _bottomTableView.showsVerticalScrollIndicator = YES;
        self.jobTableView.showsVerticalScrollIndicator = NO;
    }
    
    // 显示加载更多.
    CGFloat offset = offsetY + _jobTableView.frame.size.height;
    if (offset >= _jobTableView.contentSize.height) {
        CGFloat x = offsetY - (_jobTableView.contentSize.height-_jobTableView.frame.size.height);
        self.loadMoreView.transform = CGAffineTransformMakeRotation(M_PI*(x/26));
    }
    
    // 拉倒了最上面就不拉了.
    if (scrollView == _jobTableView) {
        
        if (offsetY < 0) {
            [_jobTableView setContentOffset:CGPointZero];
        }
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

    
    if (scrollView == _bottomTableView) {
        if (scrollView.contentOffset.y < -45) {
            _bottomTableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
            _isLoading = YES;
            [self startRefreshAnimation];
        }
    }
    
    
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


- (void)startRefreshAnimation
{
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 1;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [self.refreshView.layer addAnimation:animation forKey:loadingAnimationKey];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self stopLoadingAnimation];
        
//        [self.dataArray addObjectsFromArray:self.dataArray];
        [self.jobTableView reloadData];
    });
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
    [self.loadMoreView.layer addAnimation:animation forKey:loadingAnimationKey];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self stopLoadingAnimation];
        
//        [self.dataArray addObjectsFromArray:self.dataArray];
        [self.jobTableView reloadData];
    });
}


- (void)stopLoadingAnimation
{
    [self.loadMoreView.layer removeAnimationForKey:loadingAnimationKey];
    _isLoading = NO;
    self.jobTableView.contentInset = UIEdgeInsetsZero;
    _bottomTableView.contentInset = UIEdgeInsetsZero;

}

#pragma mark - IKJobTypeViewDelegate
-(void)jobTypeViewButtonClick:(UIButton *)button
{
    IKLog(@"button = %@",button);
    
    self.selectedTableView = button.tag-100;
    [_bottomScrollView setContentOffset:CGPointMake((self.selectedTableView-1)*IKSCREEN_WIDTH, 0) animated:YES];
    
}

- (void)searchViewCellStartSearch
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
    moreVC.jobTypeData = self.jobTypeData;
    IKNavigationController *nav = [[IKNavigationController alloc] initWithRootViewController:moreVC];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}


- (void)showLocationVc:(UIButton *)btn
{
    IKChooseCityVC *cityVC = [[IKChooseCityVC alloc] init];
    cityVC.delegate = self;
    cityVC.hotCity = self.hotCity;
    cityVC.baseProvinceData = self.provinceCityData;
    
    IKNavigationController *nav = [[IKNavigationController alloc] initWithRootViewController:cityVC];
    [self presentViewController:nav animated:NO completion:^{
        
    }];
}



- (void)requestHomePageData
{
    // 轮播图
    [[IKNetworkManager shareInstance] getHomePageLoopPlayImageData:^(NSDictionary *dict, BOOL success) {
        NSLog(@"daaaaaaaaaaa = %@,success = %d",dict,success);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                _lpView.imagesArray = [dict objectForKey:@"imageUrlArray"];
                [_lpView reloadImageData];
            }
        });
    }];
    
    // 获取列表信息.
    NSDictionary *jobParam = @{@"cityId":@"0",@"pageSize":@"16",@"type":@"0"};
    [self getJobInfoTableViewData:jobParam];
    
    
    // 获取热门城市
    [[IKNetworkManager shareInstance] getHomePageHotCityDataWithBackData:^(NSArray *dataArray, BOOL success) {
        if (success) {
            self.hotCity = dataArray;
        }
        for (IKHotCityModel *moel in dataArray) {
            NSLog(@"%@",[moel description]);
        }
    }];
    
    // 获取省市信息.
    [[IKNetworkManager shareInstance] getHomePageProvinceCityDataWithBackData:^(NSArray *dataArray, BOOL success) {
        
        self.provinceCityData = dataArray;
    }];
    
    
    // 获取工作类型.
    [[IKNetworkManager shareInstance] getHomePageWorkListDataWithBackData:^(NSArray *dataArray, BOOL success) {
        
        self.jobTypeData = dataArray;
    }];
}


- (void)getJobInfoTableViewData:(NSDictionary *)param
{
    [[IKNetworkManager shareInstance] getHomePageJobInfoDataWithParam:param backData:^(NSArray *dataArray, BOOL success) {
        self.dataArray = [dataArray mutableCopy];
        [self.jobTableView reloadData];
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
