//
//  IKHomePageVC.m
//  IamKing
//
//  Created by Luris on 2017/7/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKNavIconView.h"
#import "IKHomePageVC.h"
#import "IKSlideView.h"
#import "IKLoopPlayView.h"
#import "IKButtonView.h"
#import "IKInfoTableView.h"
#import "IKChooseCityVC.h"
#import "IKLocationManager.h"



@interface IKHomePageVC ()<UIScrollViewDelegate,IKSlideViewDelegate,IKInfoTableViewDelegate,IKButtonVieDelegate>
{
    BOOL  _navRightBtnHadClick;
}


@property(nonatomic,strong)IKNavIconView *navView;
@property(nonatomic,strong)UIBarButtonItem *rightBarBtn;
@property(nonatomic,strong)IKScrollView *bottomScrollView;
@property(nonatomic,strong)IKView *containerView;
@property(nonatomic,strong)IKSlideView *slideView;
@property(nonatomic,strong)IKLoopPlayView *lpView;
@property(nonatomic,strong)IKLoopPlayView *slpView;
@property(nonatomic,strong)IKLoopPlayView *tlpView;
@property(nonatomic,strong)UILabel *kingReLabel;




@end

@implementation IKHomePageVC


#pragma mark - System Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _navRightBtnHadClick = NO;

    // 初始化导航栏内容
    [self initNavigationContent];
    
    // 初始化底部的scrollview
    [self initBotttmScrollView];
    
    // 初始化选择slideView
    [self inintSlideView];
    
    //初始化轮播视图
    [self initLoopPlayView];
    
    // 国王推荐
    [self initKingRecommendView];
    
    //
    [self initTwoSmallLoopPlayView];
    
    //
    [self initExchangeButton];
    
    //
    [self initInfoTableView];
    return;

    
    
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(100, 200, 50, 40);
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
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
    NSLog(@"qqq%@",self.navigationController);
    
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
    _navView = [[IKNavIconView alloc]initWithFrame:CGRectMake(0, 20, 144, 44)];
//    _navView.backgroundColor = [UIColor redColor];
    NSLog(@"111 %@",self.navigationController.childViewControllers);
    
    // 定位
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(navRightBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 50, 44);
//    button.backgroundColor = [UIColor redColor];
    button.imageEdgeInsets = UIEdgeInsetsMake(12, -4, 12, 34);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -34, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    [button setTitle:@"杭州" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"IK_Address"] forState:UIControlStateNormal];
    _rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
}


- (void)initBotttmScrollView
{
    IKScrollView *scrollView = [[IKScrollView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 44)];
    scrollView.backgroundColor = IKColorFromRGB(0xf2f2f5);
    // 是否支持滑动最顶端
    //    scrollView.scrollsToTop = NO;
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
    // 设置indicator风格
    //    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    // 设置内容的边缘和Indicators边缘
    //    scrollView.contentInset = UIEdgeInsetsMake(0, 50, 50, 0);
    //    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 50, 0, 0);
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


- (void)inintSlideView
{
    IKSlideView *slideView = [[IKSlideView alloc] init];
    slideView.backgroundColor = IKColorFromRGB(0xf2f2f5);
    slideView.data = @[@"健身教练",@"会籍销售",@"运营管理",@"市场品牌",@"培训导师",@"预售项目"];
    slideView.delegate = self;
    [_containerView addSubview:slideView];
    
    _slideView = slideView;
    
    [slideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.and.left.equalTo(_containerView);
        make.height.mas_equalTo(30);
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
        make.top.mas_equalTo(_slideView.mas_bottom).offset(4);
        make.left.and.right.equalTo(_containerView);
        make.height.mas_equalTo(160);
    }];

}

- (void)initKingRecommendView
{
    CGFloat labelW = 4;
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = IKRGBColor(47.0, 181.0, 255.0);
    label.layer.cornerRadius = labelW*0.5;
    label.clipsToBounds = YES;
    [_containerView addSubview: label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lpView.mas_bottom).offset(13);
        make.left.equalTo(_containerView).offset(10);
        make.width.mas_equalTo(labelW);
        make.height.mas_equalTo(18);
    }];
    
    _kingReLabel = [[UILabel alloc] init];
    _kingReLabel.text = @"国王推荐";
    _kingReLabel.textColor = IKRGBColor(154.0, 154.0, 154.0);
    _kingReLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
    _kingReLabel.backgroundColor = [UIColor clearColor];
    [_containerView addSubview:_kingReLabel];
    
    [_kingReLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label).offset(2);
        make.left.equalTo(label.mas_right).offset(5);
        make.bottom.equalTo(label.mas_bottom).offset(-2);
        make.right.equalTo(_containerView);
    }];
    
}


- (void)initTwoSmallLoopPlayView
{
    _slpView = [[IKLoopPlayView alloc]init];
    _slpView.imagesArray = @[
                            @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646722_1456498424671_800x600.jpg",
                            @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646649_1456498410838_800x600.jpg",
                            @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646706_1456498430419_800x600.jpg",
                            @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646723_1456498427059_800x600.jpg",
                            @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646705_1456498422529_800x600.jpg"
                            ];
    _slpView.scrollDirection = IKLPVScrollDirectionVertical;
    _slpView.reverseDirection = YES;
    _slpView.scrollTimeInterval = 2;
    [_containerView addSubview:_slpView];
    
    [_slpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_kingReLabel.mas_bottom).offset(10);
        make.left.equalTo(_containerView).offset(10);
        make.width.mas_equalTo((IKSCREEN_WIDTH- 30)*0.5);
        make.height.mas_equalTo(100);
    }];
    
    
    _tlpView = [[IKLoopPlayView alloc]init];
    _tlpView.imagesArray = @[
                             @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646722_1456498424671_800x600.jpg",
                             @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646649_1456498410838_800x600.jpg",
                             @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646706_1456498430419_800x600.jpg",
                             @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646723_1456498427059_800x600.jpg",
                             @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646705_1456498422529_800x600.jpg"
                             ];
    _tlpView.scrollDirection = IKLPVScrollDirectionVertical;
    _tlpView.reverseDirection = YES;
    _tlpView.scrollTimeInterval = 3;
    [_containerView addSubview:_tlpView];
    
    [_tlpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_slpView).offset(0);
        make.left.equalTo(_slpView.mas_right).offset(10);
        make.width.and.height.equalTo(_slpView);
    }];
}


- (void)initExchangeButton
{
    IKButtonView *btnView = [[IKButtonView alloc] init];
    btnView.title = @"换二换";
    btnView.delegate = self;
    [_containerView addSubview:btnView];
    
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_containerView);
        make.top.equalTo(_slpView.mas_bottom).offset(20);
        make.width.mas_equalTo(IKSCREEN_WIDTH*0.5);
        make.height.mas_equalTo(40);
    }];
}

- (void)initInfoTableView
{
    IKInfoTableView *infoTableView = [[IKInfoTableView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 1200+100)];
//    infoTableView.backgroundColor = [UIColor redColor];
    infoTableView.delegate = self;
    [_containerView addSubview:infoTableView];
    
    infoTableView.leftHeaderButtonTitle = @"最新职位";
    infoTableView. rightHeaderButtonTitle = @"最热职位";

    
    [infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_slpView.mas_bottom).offset(90);
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
    [_slpView startAutoScrollPage];
    [_tlpView startAutoScrollPage];
}


- (void)stopLoopPlayView
{
    [_lpView stopAutoScrollPage];
    [_slpView stopAutoScrollPage];
    [_tlpView stopAutoScrollPage];
}

#pragma mark - SetView

// 设置导航栏内容
- (void)setNavigationContent
{
    [self setNavigationMiddleLogo];
    [self setNavigationRightBarBtn];
}

// 右边定位按钮
- (void)setNavigationRightBarBtn
{
    self.tabBarController.navigationItem.rightBarButtonItem = _rightBarBtn;
    
}

// 导航栏中间logo
- (void)setNavigationMiddleLogo
{
    self.tabBarController.navigationItem.titleView = _navView;
        
    [_navView ajustFrame];
    [_navView startAnimation];
}


#pragma mark - IKSlideViewDelegate

- (void)slideView:(IKSlideView *)slideView didSelectItemAtIndex:(NSUInteger)selectedIndex
{
    IKLog(@"%@--- %ld",slideView,selectedIndex);
}

- (void)slideViewSearchButtonClick:(UIButton *)button
{
//    return;
    IKViewController *searchVC = [[IKViewController alloc] init];
    //设置该属性可以使 presentView 在导航栏之下不覆盖原先的 VC
    searchVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    searchVC.view.backgroundColor = [UIColor whiteColor];
    
    [self presentViewController:searchVC animated:YES completion:^{
        
    }];
    
    
}

- (void)slideViewMoreButtonClick:(UIButton *)button
{
//    return;
    IKViewController *moreVC = [[IKViewController alloc] init];
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
    NSLog(@"scrollViewDidScrollToTop");
}

// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll");
}

// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
}

// scrollView 结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
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
    [_slpView scrollToNextPage];
    [_tlpView scrollToNextPage];
}


#pragma mark - ButtonAction



- (void)navRightBarBtnClick:(UIButton *)btn
{
    NSLog(@"navRightBarBtnClick");
    
    if (_navRightBtnHadClick) {
        
        if ([self.presentedViewController isKindOfClass:[IKChooseCityVC class]]) {
            // 取出 present 的 VC, 然后调用自身的 dismiss.
            IKChooseCityVC *choose = (IKChooseCityVC *)self.presentedViewController;
            [choose dismissSelf];
            
            _navRightBtnHadClick = NO;
        }
        return;
    }
    
    _navRightBtnHadClick  = YES;
    
    IKChooseCityVC *cityVC = [[IKChooseCityVC alloc] init];
    //设置该属性可以使 presentView 在导航栏之下不覆盖原先的 VC
    cityVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    cityVC.locationBlock = ^(NSString *location) {
        IKLog(@"location = %@",location);
    };
    
    

//    
    [self presentViewController:cityVC animated:NO completion:^{
        
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
