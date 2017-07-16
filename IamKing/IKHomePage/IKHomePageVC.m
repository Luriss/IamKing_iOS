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
#import "IKJobInfoScrollView.h"


@interface IKHomePageVC ()<UIScrollViewDelegate,IKInfoTableViewDelegate,IKChooseCityViewControllerDelegate,IKJobInfoScrollViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate>
{
    BOOL  _navRightBtnHadClick;
    //用于判断上滑下滑
    CGPoint beginPoint;
    
    BOOL _hadAddViewInSelf;
}


@property(nonatomic,strong)IKNavIconView *navLogoView;
@property(nonatomic,strong)UIBarButtonItem *leftBarBtn;
@property(nonatomic,strong)UIBarButtonItem *rightBarBtn;
@property(nonatomic,strong)IKScrollView *bottomScrollView;
@property(nonatomic,strong)IKView *containerView;
@property(nonatomic,strong)IKLoopPlayView *lpView;
@property(nonatomic,strong)IKSearchView *searchView;
@property(nonatomic,strong)IKJobTypeView *jobTypeView;
@property(nonatomic,strong)IKInfoTableView *infoTableView;
@property(nonatomic,strong)IKJobInfoScrollView *jobInfoScrollView;
@property(nonatomic,strong)IKScrollView *infoScrollView;
@property (nonatomic, strong) UICollectionView *jobCollectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *jobFlowLayout;

@end

@implementation IKHomePageVC


#pragma mark - System Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _navRightBtnHadClick = NO;
    _hadAddViewInSelf = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    beginPoint = CGPointZero;
    
    // 初始化导航栏内容
    [self initNavigationContent];
    
    // 初始化底部的scrollview
    [self initBotttmScrollView];
    
    // 初始化搜索
    [self initSearchView];
    
    //初始化轮播视图
    [self initLoopPlayView];
    
//    [self initJobInfoScrollView];
    // 职位类型
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
    
    [self setNavigationContent];
}

- (void)createRightBarItem
{
    // 定位
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(showLocationVc:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(14, 0, 14, 54);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -110, 0, 0);
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [button setTitle:@"乌鲁木齐" forState:UIControlStateNormal];

    [button setImage:[UIImage imageNamed:@"IK_Address"] forState:UIControlStateNormal];
    
    _leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)createLeftBarItem
{
    // 分类
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(showClaaifyVc) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 60, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(14, 0, 14, 44);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -115, 0, 0);
    [button setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [button setTitle:@"分类" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"IK_classify"] forState:UIControlStateNormal];
    _rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
}


// 设置导航栏内容
- (void)setNavigationContent
{
    self.tabBarController.navigationItem.rightBarButtonItem = _rightBarBtn;
    self.tabBarController.navigationItem.leftBarButtonItem = _leftBarBtn;
    
    // 导航栏中间logo
    self.tabBarController.navigationItem.titleView = _navLogoView;
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
    [_containerView addSubview:_lpView];
    
    [_lpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_containerView);
        make.top.equalTo(_searchView.mas_bottom).offset(2);
        make.height.mas_equalTo(175);
    }];
    
//    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(_lpView).offset(1000);
//    }];
}


- (void)initJobInfoScrollView
{
     _jobInfoScrollView = [[IKJobInfoScrollView alloc] initWithFrame:CGRectMake(0, 225, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64)];
    _jobInfoScrollView.backgroundColor = [UIColor blueColor];
    _jobInfoScrollView.delegate = self;
    _jobInfoScrollView.infoScrollView.scrollEnabled = NO;
    [_containerView addSubview:_jobInfoScrollView];
    
//    [_jobInfoScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_lpView.mas_bottom);
//        make.left.and.right.equalTo(_containerView);
//        make.height.mas_equalTo(IKSCREENH_HEIGHT - 64);
//    }];
//    

    
}



- (void)initJobTypeView
{
    _jobTypeView = [[IKJobTypeView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 44)];
    _jobTypeView.backgroundColor = [UIColor whiteColor];
    _jobTypeView.titleArray = @[@"最新职位",@"最热职位",@"推荐职位"];
    [_containerView addSubview:_jobTypeView];
    
    [_jobTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lpView.mas_bottom).offset(4);
        make.left.and.right.equalTo(_containerView);
        make.height.mas_equalTo(44);
    }];
}

- (void)initInfoTableView
{
//    IKInfoTableView *infoTableView = [[IKInfoTableView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 700)];
//    infoTableView.delegate = self;
//    infoTableView.canScrollTableView = NO;
//    [_containerView addSubview:infoTableView];
//    
//    infoTableView.leftHeaderButtonTitle = @"最新职位";
//    infoTableView. rightHeaderButtonTitle = @"最热职位";
//    
//    self.infoTableView = infoTableView;
//    
//    [infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_jobTypeView.mas_bottom).offset(5);
//        make.left.and.right.equalTo(_containerView);
//        make.height.mas_equalTo(700);
//    }];
    
    
    
//    _infoScrollView = [[IKScrollView alloc] init];
//    _infoScrollView.tag = 10001;
//    _infoScrollView.backgroundColor = [UIColor cyanColor];
//    _infoScrollView.delegate = self;
//    // 设置内容大小
//    _infoScrollView.contentSize = CGSizeMake(IKSCREEN_WIDTH * 3, IKSCREENH_HEIGHT- 64 - 60);
//    // 是否反弹
//    //    scrollView.bounces = NO;
//    // 是否分页
//    //    scrollView.pagingEnabled = YES;
//    //     是否滚动
//    _infoScrollView.scrollEnabled = YES;
//    _infoScrollView.showsHorizontalScrollIndicator = YES;
//    [_containerView addSubview:_infoScrollView];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(IKSCREEN_WIDTH, IKSCREENH_HEIGHT- 64 - 60);
    
    _jobFlowLayout = flowLayout;
    
    _jobCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_jobFlowLayout];
    _jobCollectionView.pagingEnabled = YES;
    _jobCollectionView.scrollsToTop = NO;
    _jobCollectionView.showsHorizontalScrollIndicator = NO;
    _jobCollectionView.showsVerticalScrollIndicator = NO;
    _jobInfoScrollView.backgroundColor = [UIColor whiteColor];
    [_jobCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"jobCollectionView"];
    [_jobCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerReuseIdentifier"];
    
    _jobCollectionView.dataSource = self;
    _jobCollectionView.delegate = self;

    [_containerView addSubview:_jobCollectionView];
    
    [_jobCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_jobTypeView.mas_bottom).offset(4);
        make.left.and.right.equalTo(_containerView);
        make.height.mas_equalTo(IKSCREENH_HEIGHT- 64 - 60);
    }];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_jobCollectionView.mas_bottom);
    }];
    
//    _jobCollectionView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);

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

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"jobCollectionView" forIndexPath:indexPath];
    cell.contentMode = UIViewContentModeScaleToFill;
    
    if (indexPath.row == 0) {
        [cell setBackgroundColor:[UIColor redColor]];
    }
    else{
        cell.backgroundColor = [UIColor blueColor];
    }
//    if (self.imagesArray.count) {
//        NSInteger index = indexPath.row % self.imagesArray.count;
//        id object = [self.imagesArray objectAtIndex:index];
//        if ([object isKindOfClass:[NSString class]]) {
//            if ([(NSString*)object hasPrefix:@"http"]) {
//                [cell setupWithUrlString:(NSString*)object placeholderImage:self.placeholderImage];
//            }
//            else {
//                [cell setupWithImageName:(NSString*)object placeholderImage:self.placeholderImage];
//            }
//        }
//        else if ([object isKindOfClass:[UIImage class]]) {
//            [cell setupWithImage:(UIImage*)object placeholderImage:self.placeholderImage];
//        }
//    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    if ([self.delegate respondsToSelector:@selector(infiniteScrollView:didSelectItemAtIndex:)]) {
    //        [self.delegate infiniteScrollView:self didSelectItemAtIndex:self.currentPageIndex];
    //    }
    //
    //    if (self.scrollViewDidSelectBlock) {
    //        self.scrollViewDidSelectBlock(self,self.currentPageIndex);
    //    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    if (!_firstShow) {
    //        [self scrollToMiddlePosition];
    //        _firstShow = YES;
    //    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
    NSLog(@"_jobTypeView = %@ scrollViewDidScroll = %.0f",[NSValue valueWithCGRect:_jobTypeView.frame],scrollView.contentOffset.y);
    
//    CGFloat offsetY = scrollView.contentOffset.y;
//    
//    CGFloat jobY = _jobTypeView.frame.origin.y;
//    if (jobY > 0) {
//        CGPoint point = [scrollView.panGestureRecognizer translationInView:scrollView];
//        
//        CGFloat jx = jobY - 32 - 36 - offsetY;
//        
//        NSLog(@"x = %.0f,y = %.0f jx = %.0f",point.x,point.y,jx);
//        if (scrollView == _bottomScrollView && jx <= 0) {
//            NSLog(@"1 _hadAddViewInSelf = %d",_hadAddViewInSelf);
//            if (!_hadAddViewInSelf) {
//                
//                beginPoint = scrollView.contentOffset;
//                [self.view addSubview:_jobTypeView];
//
//                [_jobTypeView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                    make.top.equalTo(self.view).offset(64);
//                    make.left.and.right.equalTo(self.view);
//                    make.height.mas_equalTo(44);
//                }];
////                _infoScrollView.scrollEnabled = YES;
////                _bottomScrollView.scrollEnabled = NO;
//                [self.view addSubview:_infoScrollView];
//                
//                [_infoScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                    make.top.equalTo(_jobTypeView.mas_bottom);
//                    make.left.and.right.equalTo(_containerView);
//                    make.bottom.equalTo(self.view);
//                }];
//                
//                _hadAddViewInSelf = YES;
//            }
//        }
//        else if (scrollView == _infoScrollView && offsetY < 0){
//            NSLog(@"_infoScrollView = %.0f",scrollView.contentOffset.y);
////
//            if (_hadAddViewInSelf) {
//                
////                _infoScrollView.scrollEnabled = NO;
////                _bottomScrollView.scrollEnabled = YES;
//
////                [_bottomScrollView setContentOffset:beginPoint];
//                [_containerView addSubview:_jobTypeView];
//                
//                [_jobTypeView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                    make.top.equalTo(_lpView.mas_bottom);
//                    make.left.and.right.equalTo(self.view);
//                    make.height.mas_equalTo(44);
//                }];
//                
//                [_containerView addSubview:_infoScrollView];
//                
//                [_infoScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                    make.top.equalTo(_jobTypeView.mas_bottom).offset(5);
//                    make.left.and.right.equalTo(_containerView);
//                    make.height.mas_equalTo(IKSCREENH_HEIGHT- 64 - 60);
//                }];
//                
//                [_containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                    make.bottom.equalTo(_infoScrollView);
//                }];
//                
//                _hadAddViewInSelf = NO;
//            }
//        }
//    }
    
}

// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
}

// scrollView 结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSLog(@"scrollViewDidEndDragging");
}

// scrollView 开始减速（以下两个方法注意与以上两个方法加以区别）
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDecelerating");
}

// scrollview 减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
}

- (void)jobInfoScrollViewVerticalScroll
{
    [_jobInfoScrollView removeFromSuperview];
    [_containerView addSubview:_jobInfoScrollView];
    
    _bottomScrollView.scrollEnabled = YES;
    
    [_jobInfoScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lpView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(IKSCREENH_HEIGHT - 64);
    }];
}



#pragma mark - IKInfoTableViewDelegate

- (void)infoTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
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
    moreVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    moreVC.view.backgroundColor = [UIColor whiteColor];
    
    [self presentViewController:moreVC animated:YES completion:^{
        
    }];
}


- (void)showLocationVc:(UIButton *)btn
{
    UIViewController *vc = [self getPresentedViewController];

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
