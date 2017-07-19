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
#import "IKTableView.h"
#import "IKBottomTableViewCell.h"
#import "IKJobInfoModel.h"
#import "IKInfoTableViewCell.h"


@interface IKHomePageVC ()<UIScrollViewDelegate,IKChooseCityViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,IKJobTypeViewDelegate,IKSearchViewDelegate,IKSearchViewControllerDelegate,IKBottomTableViewCellDelegate,UIGestureRecognizerDelegate>
{
    BOOL  _navRightBtnHadClick;
    BOOL isScrollToTop;
    BOOL _hadAddViewInSelf;
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

@end

@implementation IKHomePageVC


#pragma mark - System Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _navRightBtnHadClick = NO;
    _hadAddViewInSelf = NO;
    isScrollToTop = NO;
 
    _infoTableViewArray = [[NSMutableArray alloc] init];
    
    _model = [[IKJobInfoModel alloc] init];
    _model.logoImageUrl = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646722_1456498424671_800x600.jpg";
    _model.title = @"高级营销总监";
    _model.salary = @"13~18k";
    _model.address = @"杭州";
    _model.experience = @"6~8年";
    _model.education = @"本科";
    _model.skill1 = @"销售能手好";
    _model.skill2 = @"NAFC";
    _model.skill3 = @"形象好";
    _model.introduce = @"时尚连锁健身俱乐部品牌,致力于提供超乎想象的健身运动体验.在江浙沪,拥有36家直营店铺.时尚连锁健身俱乐部品牌,致力于提供超乎想象的健身运动体验.在江浙沪,拥有36家直营店铺.";
    
    // 初始化导航栏内容
    [self initNavigationContent];
    
    [self initLoopPlayView];
    
    [self initBottomTableView];
    
    [self initBottomScrollView];
//    // 职位列表
    [self initInfoTableView];
    
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
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
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
    _bottomTableView.bounces = YES;
    [self.view addSubview:_bottomTableView];
    
    [_bottomTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}


- (void)initBottomScrollView
{
    IKScrollView *scrollView = [[IKScrollView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT- 64 - 50)];
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
    _lpView.pageControlHidden = NO;

}


- (void)initInfoTableView
{
    
    _bottomScrollView.contentSize = CGSizeMake(IKSCREEN_WIDTH * 3, IKSCREENH_HEIGHT- 64 - 80);
    
    for (int i = 0; i < 3; i ++) {
        
        IKTableView *tableView = [[IKTableView alloc] initWithFrame:CGRectMake(i *IKSCREEN_WIDTH, 0, IKSCREEN_WIDTH, CGRectGetHeight(_bottomScrollView.frame)) style:UITableViewStylePlain];
        tableView.tag = 1000 + i;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = YES;
        tableView.delegate = self;
        tableView.bounces = NO;
        tableView.dataSource = self;
        
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
                return 180;
            }
            else{
                return 0;
            }
        }
        else{
            return IKSCREENH_HEIGHT- 64 - 80;
        }
    }
    else{
        return 110;
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
        return 45;
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
        return 10;
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
                    make.height.mas_equalTo(175);
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
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        if (indexPath.row == 1) {
            _model.logoImageUrl = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646649_1456498410838_800x600.jpg";
        }
        [cell addCellData:_model];
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
    if (fabs(point.x)<fabs(point.y)) {
        NSLog(@"上滑");
        // 上下滑时,禁止 scrollview 滑动.
        _bottomScrollView.scrollEnabled = NO;
    }

    
    if (scrollView == _bottomTableView && !isScrollToTop) {
        if (scrollView.contentOffset.y >= 222) {
            [_bottomTableView setContentOffset:CGPointMake(0, 222)];
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
        [_bottomTableView setContentOffset:CGPointMake(0, 225)];
    }
    else{
        isScrollToTop = NO;
        _bottomTableView.showsVerticalScrollIndicator = YES;
        self.jobTableView.showsVerticalScrollIndicator = NO;
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
    _bottomScrollView.scrollEnabled = YES;
    
    // 更改选择项
    CGFloat index = (scrollView.contentOffset.x)/IKSCREEN_WIDTH;
    if (scrollView == _bottomScrollView ) {
        [_jobTypeView adjustBottomLine:index];
        self.selectedTableView = index;
        self.jobTableView = [_infoTableViewArray objectAtIndex:index];
    }
    
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
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:moreVC];
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
