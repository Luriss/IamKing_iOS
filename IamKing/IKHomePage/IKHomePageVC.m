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
#import "IKInfoTableView.h"
#import "IKChooseCityVC.h"
#import "IKLocationManager.h"
#import "IKMoreTypeVC.h"
#import "IKSearchVC.h"
#import "IKSearchView.h"
#import "IKJobTypeView.h"


@interface IKHomePageVC ()<UIScrollViewDelegate,IKInfoTableViewDelegate,IKChooseCityViewControllerDelegate>
{
    BOOL  _navRightBtnHadClick;
}


@property(nonatomic,strong)IKNavIconView *navLogoView;
@property(nonatomic,strong)UIBarButtonItem *rightBarBtn;
@property(nonatomic,strong)UIBarButtonItem *leftBarBtn;
@property(nonatomic,strong)IKScrollView *bottomScrollView;
@property(nonatomic,strong)IKView *containerView;
@property(nonatomic,strong)IKLoopPlayView *lpView;
@property(nonatomic,strong)IKSearchView *searchView;
@property(nonatomic,strong)IKJobTypeView *jobTypeView;


@end

@implementation IKHomePageVC


#pragma mark - System Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _navRightBtnHadClick = NO;
    self.tabBarController.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    // 初始化导航栏内容
    [self initNavigationContent];
    
    // 初始化底部的scrollview
    [self initBotttmScrollView];
    
    // 初始化搜索
    [self initSearchView];
    
    //初始化轮播视图
    [self initLoopPlayView];
    
    //
    [self initJobTypeView];
    
    // 职位列表
    [self initInfoTableView];
    
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
    
    [self setNavigationContent];
    
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // 视图消失,停止轮播
    [self stopLoopPlayView];
}


#pragma mark - InitView

- (void)initNavigationContent
{
    // logo
    _navLogoView = [[IKNavIconView alloc]initWithFrame:CGRectMake(0, 00, 100, 44)];
    
    [self createRightBarItem];
    
    [self createLeftBarItem];
}

- (void)createRightBarItem
{
    // 定位
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(navRightBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 70, 44);
    [button setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    [button setTitle:@"乌鲁木齐" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"IK_Address"] forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(14, 0, 14, 54);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -45, 0, 0);
    
    
    _rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)createLeftBarItem
{
    // 分类
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(showClaaifyVc) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 60, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(14, 0, 14, 44);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
    [button setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [button setTitle:@"分类" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"IK_classify"] forState:UIControlStateNormal];
    _leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)initBotttmScrollView
{
    IKScrollView *scrollView = [[IKScrollView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 44)];
    scrollView.backgroundColor = IKColorFromRGB(0xf2f2f5);
    // 是否支持滑动最顶端
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    // 设置内容大小
    //    scrollView.contentSize = CGSizeMake(320, 460*10);
    // 是否反弹
    //    scrollView.bounces = NO;
    // 是否分页
    //    scrollView.pagingEnabled = YES;
    //     是否滚动
    scrollView.scrollEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    // 提示用户,Indicators flash
    [scrollView flashScrollIndicators];
    // 是否同时运动,lock
    scrollView.directionalLockEnabled = YES;
    [self.view addSubview:scrollView];
    
    _bottomScrollView = scrollView;
    
    
    IKView *containerView = [[IKView alloc]init];
    containerView.backgroundColor = [UIColor clearColor];
    [_bottomScrollView addSubview:containerView];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.right.equalTo(scrollView).with.insets(UIEdgeInsetsZero);
        make.width.equalTo(scrollView);
    }];
    _containerView = containerView;
}


- (void)initSearchView
{
    _searchView = [[IKSearchView alloc] init];
//    searchView.delegate = self;
    _searchView.hiddenColse = YES;
    [_containerView addSubview:_searchView];
    
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView).offset(2);
        make.left.and.right.equalTo(_containerView);
        make.height.mas_equalTo(44);
    }];
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
    _lpView.pageControlHidden = NO;
    //    _lpView.isAutoScroll = YES;
    [_containerView addSubview:_lpView];
    
    [_lpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_containerView);
        make.top.equalTo(_searchView.mas_bottom).offset(2);
        make.height.mas_equalTo(175);
    }];
}

- (void)initJobTypeView
{
    _jobTypeView = [[IKJobTypeView alloc] init];
    _jobTypeView.backgroundColor = [UIColor whiteColor];
    
    [_containerView addSubview:_jobTypeView];
    
    [_jobTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lpView.mas_bottom).offset(4);
        make.left.and.right.equalTo(_containerView);
        make.height.mas_equalTo(44);
    }];
}




- (void)initInfoTableView
{
    IKInfoTableView *infoTableView = [[IKInfoTableView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 1200+100)];
    infoTableView.delegate = self;
    [_containerView addSubview:infoTableView];
    
    infoTableView.leftHeaderButtonTitle = @"最新职位";
    infoTableView. rightHeaderButtonTitle = @"最热职位";
    
    
    [infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_jobTypeView.mas_bottom).offset(5);
        make.left.and.right.equalTo(_containerView);
        make.height.mas_equalTo(1200+100);
    }];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(infoTableView);
    }];
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

#pragma mark - SetView

// 设置导航栏内容
- (void)setNavigationContent
{
    [self setNavigationMiddleLogo];
    [self setNavigationBarItem];
}


- (void)setNavigationBarItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;
    self.tabBarController.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,_leftBarBtn, nil];
    
    self.tabBarController.navigationItem.leftBarButtonItem = _rightBarBtn;
    
}

// 导航栏中间logo
- (void)setNavigationMiddleLogo
{
    self.tabBarController.navigationItem.titleView = _navLogoView;
    
    [_navLogoView ajustFrame];
}


#pragma mark - IKSlideViewDelegate

- (void)slideViewSearchButtonClick:(UIButton *)button
{
    //    return;
    IKSearchVC *searchVC = [[IKSearchVC alloc] init];
    //设置该属性可以使 presentView 在导航栏之下不覆盖原先的 VC
    searchVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    searchVC.view.backgroundColor = [UIColor whiteColor];
    
    [self presentViewController:searchVC animated:YES completion:^{
        
    }];
    
    
}

- (void)slideViewMoreButtonClick:(UIButton *)button
{
    //    return;
    
}

- (void)showClaaifyVc
{
    IKMoreTypeVC *moreVC = [[IKMoreTypeVC alloc] init];
    //设置该属性可以使 presentView 在导航栏之下不覆盖原先的 VC
    moreVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    moreVC.view.backgroundColor = [UIColor whiteColor];
    
    [self presentViewController:moreVC animated:YES completion:^{
        
    }];
}

#pragma mark - UIScrollViewDelegate
/*
 // 返回一个放大或者缩小的视图
 - (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
 {
 
 }
 // 开始放大或者缩小
 - (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:
 (UIView *)view
 {
 
 }
 
 // 缩放结束时
 - (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
 {
 
 }
 
 // 视图已经放大或缩小
 - (void)scrollViewDidZoom:(UIScrollView *)scrollView
 {
 NSLog(@"scrollViewDidScrollToTop");
 }
 */

// 是否支持滑动至顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}

// 滑动到顶部时调用该方法
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
//    NSLog(@"scrollViewDidScrollToTop");
}

// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"scrollViewDidScroll");
}

// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"scrollViewWillBeginDragging");
}

// scrollView 结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSLog(@"scrollViewDidEndDragging");
}

// scrollView 开始减速（以下两个方法注意与以上两个方法加以区别）
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"scrollViewWillBeginDecelerating");
}

// scrollview 减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"scrollViewDidEndDecelerating");
}




#pragma mark - IKInfoTableViewDelegate

- (void)tableViewHeaderLeftButtonClick:(UIButton *)button
{
    
}


- (void)tableViewHeaderRightButtonClick:(UIButton *)button
{
    
}


- (void)infoTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - IKButtonVieDelegate

- (void)buttonViewButtonClick:(UIButton *)button
{
//    [_slpView scrollToNextPage];
//    [_tlpView scrollToNextPage];
}

- (void)locationVcDismissChangeNavButtonTitle:(NSString *)title
{
    IKView *view = (IKView *)_rightBarBtn.customView;
    UIButton *btn = (UIButton *)view.subviews.firstObject;
    CGRect oldFrame = btn.frame;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:11.0f]};
    CGSize strSize = [NSString getSizeWithString:title size:CGSizeMake(70, 44) attribute:attribute];
    btn.frame = CGRectMake(CGRectGetWidth(view.frame)-strSize.width-20,oldFrame.origin.y, strSize.width + 20, 44);
    btn = [self setNavRightButtonImageTitleEdgeInsets:btn size:strSize];
    [btn setTitle:title forState:UIControlStateNormal];

    _navRightBtnHadClick = NO;
}

- (UIButton *)setNavRightButtonImageTitleEdgeInsets:(UIButton *)button size:(CGSize )size
{
    IKLog(@"%@",[NSValue valueWithCGSize:size]);
    // 两个字 30.
    CGFloat x = (size.width - 30)/5;
    button.imageEdgeInsets = UIEdgeInsetsMake(14, 0, 14, size.width);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -(size.width - (5 *x)), 0, 0);

    return button;
    
}

#pragma mark - ButtonAction



- (void)navRightBarBtnClick:(UIButton *)btn
{
    
    UIViewController *vc = [self getPresentedViewController];
    NSLog(@"navRightBarBtnClick = %@",vc);

    if (_navRightBtnHadClick) {
        if ([vc isKindOfClass:[IKChooseCityVC class]]) {
            // 取出 present 的 VC, 然后调用自身的 dismiss.
            IKChooseCityVC *choose = (IKChooseCityVC *)vc;
            [choose dismissSelf:^(NSString *location) {
                _navRightBtnHadClick = NO;
                [btn setTitle:location forState:UIControlStateNormal];
            }];
        }
        else{
            // 取出 present 的 VC, 然后调用自身的 dismiss.
            IKChooseCityVC *choose = (IKChooseCityVC *)vc.presentedViewController;
            [choose dismissSelf:^(NSString *location) {
                _navRightBtnHadClick = NO;
                [btn setTitle:location forState:UIControlStateNormal];
            }];
        }
        
        return;
    }
    
    _navRightBtnHadClick  = YES;
    
    IKChooseCityVC *cityVC = [[IKChooseCityVC alloc] init];
    //设置该属性可以使 presentView 在导航栏之下不覆盖原先的 VC
    cityVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    cityVC.delegate = self;
    //
    
    [vc presentViewController:cityVC animated:NO completion:^{
        
    }];
}


- (UIViewController *)getPresentedViewController
{
    UIViewController *topVC = self;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
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
