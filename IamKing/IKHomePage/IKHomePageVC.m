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
#import "IKJobTypeView.h"
#import "IKJobInfoScrollView.h"
#import "IKTableView.h"
#import "IKBottomTableViewCell.h"
#import "IKJobInfoModel.h"
#import "IKInfoTableViewCell.h"
#import "IKHomePageConfig.h"
#import "IKHotCityModel.h"
#import "IKProvinceModel.h"
#import "IKJobDetailVC.h"



#define IKJobTypeHeaderHeight   (45.0f)

extern NSString * currentSelectedCityId;

static NSString * const loadingAnimationKey = @"loadingAnimationKey";


@interface IKHomePageVC ()<UIScrollViewDelegate,IKChooseCityViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,IKJobTypeViewDelegate,IKSearchViewControllerDelegate,IKBottomTableViewCellDelegate,UIGestureRecognizerDelegate>
{
    BOOL  _navRightBtnHadClick;
    BOOL isScrollToTop;
    BOOL _hadAddViewInSelf;
    
    BOOL _isLoading;
    
    BOOL _isRefreshEnd;
    
    BOOL _isScrollToTop;
    
}

// system
@property(nonatomic,strong)UIButton         *leftBtn;
@property(nonatomic,strong)UIBarButtonItem  *rightBarBtn;
@property(nonatomic,strong)UIImageView      *loadMoreView;
@property(nonatomic,strong)UIImageView      *refreshView;
@property(nonatomic,strong)UIView           *sysNavView;
@property(nonatomic,strong)UIView           *tableFooterView;

// custom
@property(nonatomic,strong)IKNavIconView    *navLogoView;
@property(nonatomic,strong)IKScrollView     *bottomScrollView;
@property(nonatomic,strong)IKTableView      *bottomTableView;
@property (nonatomic,strong)IKTableView     *jobTableView;
@property (nonatomic,strong)IKTableView     *hotJobTableView;

@property(nonatomic,strong)IKJobTypeView    *jobTypeView;
@property(nonatomic,strong)IKLoopPlayView   *lpView;
@property(nonatomic,strong)IKJobDetailVC    *jobDetailVc;

// model
@property (nonatomic,strong)IKJobInfoModel  *model;

// system data type
@property(nonatomic,assign)NSUInteger        selectedTableView;
//@property(nonatomic,strong)NSMutableArray<IKTableView *> *infoTableViewArray;
@property(nonatomic,strong)NSArray          *dataArray;
@property(nonatomic,strong)NSArray          *hotDataArray;

@property(nonatomic,assign)CGFloat           lpHeight;
@property(nonatomic,strong)NSArray          *hotCity;
@property(nonatomic,strong)NSArray          *provinceCityData;
@property(nonatomic,strong)NSArray          *jobTypeData;
@property(nonatomic,assign)NSInteger         tableType;
@property(nonatomic,assign)NSInteger         dataPage;


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
    _tableType = 0;  // 默认 0
    _dataPage = 1;
    _isRefreshEnd = NO;
    _isScrollToTop = NO;
    
    self.lpHeight = 0.48*IKSCREEN_WIDTH;
//    _infoTableViewArray = [[NSMutableArray alloc] init];
    
    
    self.sysNavView = [[self.navigationController.navigationBar subviews] objectAtIndex:0];
    
    
    
    NSLog(@"IKSCREEN_WIDTH = %.0f",IKSCREENH_HEIGHT );
    
    [self requestHomePageAllData];
    
    //    [self testData];
    // 初始化导航栏内容
    [self initNavigationContent];
    
    [self initLoopPlayView];
    
    [self initBottomTableView];
    
    [self initBottomScrollView];
    //    // 职位列表
    [self initTableView];
    
    IKLog(@"self.navigationController = %@",self.navigationController);
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 内容视图若有滚动,则设置导航栏透明度95%
    if (_bottomTableView.contentOffset.y > 0) {
        self.sysNavView.alpha = 0.95;
    }
    
    // 视图显示开始轮播
    [self startLoopPlayView];
    
    //
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.sysNavView.alpha = 1.0;
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
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


- (IKJobDetailVC *)jobDetailVc
{
    if (_jobDetailVc == nil) {
        _jobDetailVc = [[IKJobDetailVC alloc] init];
    }
    return _jobDetailVc;
}

#pragma mark - InitView

- (void)initNavigationContent
{
    // logo
    _navLogoView = [[IKNavIconView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappp:)];
    [_navLogoView addGestureRecognizer:tap];
    
    self.navigationView.titleView = _navLogoView;
    
    [self createRightBarItem];
    
    [self createLeftBarItem];
//    [self setNavigationContent];
    
}

- (void)tappp:(UITapGestureRecognizer *)tap
{
//        _isScrollToTop = YES;
//    [_bottomTableView setContentOffset:CGPointZero];
//    [_bottomTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    
    NSString *cityStr = [IKUSERDEFAULT objectForKey:@"selectedCity"];
    if (IKStringIsEmpty(cityStr)) {
        cityStr = @"全国";
    }
    [button setTitle:cityStr forState:UIControlStateNormal];
    
    UIImage *image =[UIImage imageByApplyingAlpha:0.8 image:[UIImage imageNamed:@"IK_Address"]];
    [button setImage:[UIImage imageNamed:@"IK_Address"] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    
    self.navigationView.leftButton = button;
    _leftBtn = button;
}

- (void)createLeftBarItem
{
    // 分类
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(showClaaifyVc) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 60, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(14, 10, 14,34);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -100, 0, 0);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [button setTitle:@"分类" forState:UIControlStateNormal];
    
    UIImage *image =[UIImage imageByApplyingAlpha:0.8 image:[UIImage imageNamed:@"IK_classify"]];
    [button setImage:[UIImage imageNamed:@"IK_classify"] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    
    self.navigationView.rightButton = button;
//    _rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
}


// 设置导航栏内容
- (void)setNavigationContent
{
    IKLog(@"self.navigationController = %@",self.navigationController);
    
    self.navigationItem.rightBarButtonItem = _rightBarBtn;
    
    // 导航栏中间logo
    self.navigationItem.titleView = _navLogoView;
}


// 底部 tableView

- (void)initBottomTableView
{
    _bottomTableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, IKSCREENH_HEIGHT -64 - 49) style:UITableViewStylePlain];
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
    
    IKTableView *tableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, CGRectGetHeight(_bottomScrollView.frame)) style:UITableViewStylePlain];
    tableView.tag = 1000;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = YES;
    tableView.delegate = self;
    tableView.bounces = YES;
    tableView.dataSource = self;
    tableView.backgroundColor = IKGeneralLightGray;
    [_bottomScrollView addSubview:tableView];
//    [_infoTableViewArray addObject:tableView];
    self.jobTableView = tableView;
    self.jobTableView.showsVerticalScrollIndicator = NO;

    [self initHotJobTableView];
    
    _bottomScrollView.contentSize = CGSizeMake(IKSCREEN_WIDTH * 2, IKSCREENH_HEIGHT- 64 - 80);
}


- (void)initHotJobTableView
{
    IKTableView *tableView = [[IKTableView alloc] initWithFrame:CGRectMake(IKSCREEN_WIDTH, 0, IKSCREEN_WIDTH, CGRectGetHeight(_bottomScrollView.frame)) style:UITableViewStylePlain];
    tableView.tag = 1000;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = YES;
    tableView.delegate = self;
    tableView.bounces = YES;
    tableView.dataSource = self;
    tableView.backgroundColor = IKGeneralLightGray;
    [_bottomScrollView addSubview:tableView];
    self.hotJobTableView = tableView;
    self.hotJobTableView.showsVerticalScrollIndicator = NO;
    
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
            return IKSCREENH_HEIGHT- 64 - 68;
        }
    }
    else{
        return (IKSCREEN_WIDTH * 0.2933);
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
        if (tableView == _hotJobTableView) {
            return  self.hotDataArray.count;
        }
        else{
            return self.dataArray.count;
        }
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
        cell.backgroundColor = [UIColor whiteColor];
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
                    make.bottom.equalTo(cell.contentView).offset(-1);
                }];
                
                //                UIView *line = [[UIView alloc] init];
                //                line.backgroundColor = IKLineColor;
                //                [cell.contentView addSubview:line];
                //                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                //                    make.bottom.equalTo(cell.contentView.mas_bottom);
                //                    make.left.and.right.equalTo(cell.contentView);
                //                    make.height.mas_equalTo(2);
                //                }];
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
        
        if (tableView == _jobTableView && (indexPath.row < self.dataArray.count)) {
            [cell addCellData:self.dataArray[indexPath.row]];
        }
        else if (tableView == _hotJobTableView && (indexPath.row < self.hotDataArray.count)){
            [cell addCellData:self.hotDataArray[indexPath.row]];
        }
        
        return cell;
    }
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _bottomTableView) {
        _jobTypeView = [[IKJobTypeView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 44)];
        _jobTypeView.backgroundColor = [UIColor whiteColor];
        _jobTypeView.lineWidth = 52;
        _jobTypeView.titleArray = @[@"最新职位",@"热门职位"];
        _jobTypeView.delegate = self;
        
        return _jobTypeView;
    }
    
    return nil;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ((tableView != _bottomTableView) && (self.dataArray.count > 0 || self.hotDataArray.count > 0)) {
        
        if (_tableFooterView == nil) {
            _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 30)];
            _tableFooterView.backgroundColor = [UIColor clearColor];
            
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(_tableFooterView.center.x - 40, _tableFooterView.center.y - 7.5, 15, 15)];
            imageV.image = [UIImage imageNamed:@"IK_loading"];
            [_tableFooterView addSubview:imageV];
            
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_tableFooterView.center.x - 20, _tableFooterView.center.y - 10, 100, 20)];
            label.text = @"玩命加载中...";
            label.textColor = IKSubHeadTitleColor;
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:12.0f];
            [_tableFooterView addSubview:label];
            self.loadMoreView = imageV;
            self.tableFooterView = _tableFooterView;
        }
        
        return _tableFooterView;
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView != _bottomTableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        IKJobInfoModel *model = [self.dataArray objectAtIndex:indexPath.row];
        self.jobDetailVc.jobModel = model;
        [self.navigationController pushViewController:self.jobDetailVc animated:YES];
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
    NSLog(@"offsetY = %.0f",offsetY);
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
            if (offsetY >= (self.lpHeight + IKJobTypeHeaderHeight - 1)) {
                // 这里不能用 self.lpHeight.很奇怪... 只能用数字
                _bottomTableView.contentOffset = CGPointMake(0, (lph + IKJobTypeHeaderHeight - 1));
                if (_tableType == 0) {
                    self.jobTableView.showsVerticalScrollIndicator = YES;
                }
                else{
                    self.hotJobTableView.showsVerticalScrollIndicator = YES;
                }
                _bottomTableView.showsVerticalScrollIndicator = NO;
                isScrollToTop = YES;
            }
            else{
                isScrollToTop = NO;
                if (_tableType == 0) {
                    [self.jobTableView setContentOffset:CGPointZero];
                }
                else{
                    [self.hotJobTableView setContentOffset:CGPointZero];
                }
            }
        }
    }
    
    if (_tableType == 0) {
        if (isScrollToTop && _jobTableView.contentOffset.y > 0) {
            [_bottomTableView setContentOffset:CGPointMake(0,(lph + IKJobTypeHeaderHeight - 1))];
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
    else{
        if (isScrollToTop && _hotJobTableView.contentOffset.y > 0) {
            [_bottomTableView setContentOffset:CGPointMake(0,(lph + IKJobTypeHeaderHeight - 1))];
            self.hotJobTableView.showsVerticalScrollIndicator = YES;
        }
        else{
            isScrollToTop = NO;
            _bottomTableView.showsVerticalScrollIndicator = YES;
            self.hotJobTableView.showsVerticalScrollIndicator = NO;
        }
        
        // 显示加载更多.
        CGFloat offset = offsetY + _hotJobTableView.frame.size.height;
        if (offset >= _hotJobTableView.contentSize.height) {
            CGFloat x = offsetY - (_hotJobTableView.contentSize.height-_hotJobTableView.frame.size.height);
            self.loadMoreView.transform = CGAffineTransformMakeRotation(M_PI*(x/26));
        }
        
        // 拉倒了最上面就不拉了.
        if (scrollView == _hotJobTableView) {
            
            if (offsetY < 0) {
                [_hotJobTableView setContentOffset:CGPointZero];
            }
        }
    }
}


// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    NSLog(@"scrollViewWillBeginDragging");
    //    self.tableFooterView.hidden = NO;
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
                [self startLoadingMoreAnimation];
            }
        }
        else{
            if (!_isLoading) {
                self.jobTableView.contentInset = UIEdgeInsetsZero;
            }
        }
    }
    
    if (scrollView == _hotJobTableView) {
        CGFloat offset = scrollView.contentOffset.y + _hotJobTableView.frame.size.height;
        if (offset >= (_hotJobTableView.contentSize.height + 26)) {
            if (!_isLoading) {
                _isLoading = YES;
                self.hotJobTableView.contentInset = UIEdgeInsetsMake(0, 0, 26, 0);
                [self startLoadingMoreAnimation];
            }
        }
        else{
            if (!_isLoading) {
                self.hotJobTableView.contentInset = UIEdgeInsetsZero;
            }
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
    NSLog(@"index = %.0f",index);
    if (scrollView == _bottomScrollView ) {
        
        [_jobTypeView adjustBottomLine:index];
        self.selectedTableView = index;
        _tableType = index;
        
        [self tableViewChange];
    }
}

- (void)tableViewChange
{
    if (_tableType == 0) {
        if (self.dataArray.count == 0) {
            [self getJobInfoTableViewDataUseCache:NO];
        }
        [self.jobTableView reloadData];
    }
    else{
        if (self.hotDataArray.count == 0) {
            [self getJobInfoTableViewDataUseCache:NO];
        }
        [self.hotJobTableView reloadData];
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
    
    [self refeshHomePageData];
}


- (void)startLoadingMoreAnimation
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
    
    // 调用接口获取更多数据
    [self loadMoreJobJinfo];
}


- (void)stopRefrshAnimation
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshView.layer removeAnimationForKey:loadingAnimationKey];
        _isLoading = NO;
        if (_tableType == 0) {
            self.jobTableView.contentInset = UIEdgeInsetsZero;
        }
        else{
            self.hotJobTableView.contentInset = UIEdgeInsetsZero;
        }
        _bottomTableView.contentInset = UIEdgeInsetsZero;
    });
}


- (void)stopLoadingMoreAnimation
{
    [self.loadMoreView.layer removeAnimationForKey:loadingAnimationKey];
    _isLoading = NO;
    if (_tableType == 0) {
        self.jobTableView.contentInset = UIEdgeInsetsZero;
    }
    else{
        self.hotJobTableView.contentInset = UIEdgeInsetsZero;
    }
    _bottomTableView.contentInset = UIEdgeInsetsZero;
}

- (void)refeshHomePageData
{
    [self getLoopPlayViewDataUseCache:NO];
    
    [self getJobInfoTableViewDataUseCache:NO];
}



#pragma mark - IKJobTypeViewDelegate
-(void)jobTypeViewButtonClick:(UIButton *)button
{
    IKLog(@"button = %@",button);
    
    self.selectedTableView = button.tag-100;
    _tableType = self.selectedTableView - 1;
    [_bottomScrollView setContentOffset:CGPointMake((self.selectedTableView-1)*IKSCREEN_WIDTH, 0) animated:YES];
    
    [self tableViewChange];
}

- (void)searchViewCellStartSearch
{
    dispatch_async(dispatch_get_main_queue(), ^{
        IKSearchVC *searchvc = [IKSearchVC alloc];
        searchvc.delegate = self;
        searchvc.baseProvinceData = self.provinceCityData;
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
    
}


#pragma mark - IKChooseCityViewControllerDelegate

- (void)locationVcDismissChangeNavButtonTitle:(NSString *)title
{
    [IKNotificationCenter postNotificationName:IKCityChangeNeedRefrshDataKey object:nil];
    [_leftBtn setTitle:title forState:UIControlStateNormal];
    _navRightBtnHadClick = NO;
    
    [self getJobInfoTableViewDataUseCache:YES];
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



- (void)requestHomePageAllData
{
    
    [self getLoopPlayViewDataUseCache:YES];
    
    [self getJobInfoTableViewDataUseCache:YES];
    
    
    // 获取热门城市
    [[IKNetworkManager shareInstance] getHomePageHotCityDataWithBackData:^(NSArray *dataArray, BOOL success) {
        if (success) {
            self.hotCity = dataArray;
        }
    }];
    
    // 获取省市信息.
    [[IKNetworkManager shareInstance] getHomePageProvinceCityDataWithBackData:^(NSArray *dataArray, BOOL success) {
        if (success) {
            self.provinceCityData = dataArray;
        }
        else{
            [LRToastView showTosatWithText:dataArray.firstObject inView:self.view dismissAfterDelay:1];
        }
    }];
    
    
    // 获取工作类型.
    [[IKNetworkManager shareInstance] getHomePageWorkListDataWithBackData:^(NSArray *dataArray, BOOL success) {
        
        if (success) {
            self.jobTypeData = dataArray;
        }
        else{
            [LRToastView showTosatWithText:dataArray.firstObject inView:self.view dismissAfterDelay:1];
        }
    }];
}


- (void)getLoopPlayViewDataUseCache:(BOOL)useCache
{
    if (useCache) {
        // 轮播图
        [[IKNetworkManager shareInstance] getHomePageLoopPlayImageData:^(NSDictionary *dict, BOOL success) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _lpView.imagesArray = [dict objectForKey:@"imageUrlArray"];
                    NSLog(@"_lpView.imagesArray = %@",_lpView.imagesArray);
                    [_lpView reloadImageData];
                });
            }
        }];
    }
    else{
        [[IKNetworkManager shareInstance] getHomePageLoopPlayImageDataWithoutCache:^(NSDictionary *dict, BOOL success) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    _lpView.imagesArray = [dict objectForKey:@"imageUrlArray"];
                    [_lpView reloadImageData];
                    NSLog(@"getHomePageLoopPlayImageDataWithoutCache");
                    if (_isRefreshEnd) {
                        [self stopRefrshAnimation];
                    }
                    else{
                        _isRefreshEnd = YES;
                    }
                    
                });
            }
        }];
    }
}


- (void)getJobInfoTableViewDataUseCache:(BOOL)useCache
{
    NSString *cityId = [self getCurrentCityIdFromUserDefault];
    
    // 获取列表信息.
    NSDictionary *jobParam = @{@"cityId":cityId,@"pageSize":@"40",@"type":[NSString stringWithFormat:@"%ld",(long)_tableType]};
    
    if (!useCache) {
        [[IKNetworkManager shareInstance] getHomePageJobInfoDataWithoutCacheParam:jobParam backData:^(NSArray *dataArray, BOOL success) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (_tableType == 1) {
                        self.hotDataArray = [dataArray copy];
                        [self.hotJobTableView reloadData];
                    }
                    else{
                        self.dataArray = [dataArray copy];
                        [self.jobTableView reloadData];
                    }
                    NSLog(@"getHomePageJobInfoDataWithParam");
                    if (_isRefreshEnd) {
                        [self stopRefrshAnimation];
                    }
                    else{
                        _isRefreshEnd = YES;
                    }
                });
            }
            else{
                [self stopRefrshAnimation];
            }
        }];
    }
    else{
        [[IKNetworkManager shareInstance] getHomePageJobInfoDataWithParam:jobParam backData:^(NSArray *dataArray, BOOL success) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.dataArray = nil;
                    self.dataArray = [dataArray copy];
                    [self.jobTableView reloadData];
                    
                });
            }
        }];
    }
}


- (void)loadMoreJobJinfo
{
    NSString *cityId = [self getCurrentCityIdFromUserDefault];
    // 获取列表信息.
    NSDictionary *jobParam = @{@"cityId":cityId,@"pageSize":@"16",@"type":[NSString stringWithFormat:@"%ld",_tableType],@"page":[NSString stringWithFormat:@"%ld",++_dataPage] };
    
    [[IKNetworkManager shareInstance] getHomePageMoreJobInfoDataWithParam:jobParam backData:^(NSArray *dataArray, BOOL success) {
        
        NSLog(@"self.dataArray.count = %ld,dataArray.count = %ld",self.dataArray.count,dataArray.count);
        if (dataArray.count > 0 && success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self stopLoadingMoreAnimation];
                
                if (_tableType == 0) {
                    self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:dataArray];
                    [self.jobTableView reloadData];
                }
                else{
                    self.hotDataArray = [self.hotDataArray arrayByAddingObjectsFromArray:dataArray];
                    [self.hotJobTableView reloadData];
                }
                
            });
        }
        
    }];
}


- (NSString *)getCurrentCityIdFromUserDefault
{
    if (IKStringIsEmpty(currentSelectedCityId)) {
        NSString *selectedCityId = [IKUSERDEFAULT objectForKey:@"selectedCityId"];
        if (IKStringIsEmpty(selectedCityId)) {
            selectedCityId = @"0";
        }
        currentSelectedCityId = selectedCityId;
    }
    return currentSelectedCityId;
    
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
