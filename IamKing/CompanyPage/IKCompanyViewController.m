//
//  IKCompanyViewController.m
//  IamKing
//
//  Created by Luris on 2017/7/29.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyViewController.h"
#import "IKCompanyAdTableViewCell.h"
#import "IKSearchVC.h"
#import "IKNetworkManager.h"
#import "IKCompanyInfoModel.h"
#import "IKCompanyTableViewCell.h"
#import "IKCompanyClassifyView.h"
#import "IKRecommandCompanyVC.h"
#import "IKCompanyDetailVC.h"


@interface IKCompanyViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,IKCompanyClassifyViewDelegate>//,IKSearchViewControllerDelegate>
{
    BOOL        _scrollViewIsDragging;
    BOOL        _hadAddHeaderView;
    CGFloat     _tableViewInsetH;
}
@property(nonatomic,strong)IKTableView      *bgTableView;
@property(nonatomic,strong)IKCompanyClassifyView      *classifyView;
@property(nonatomic,strong)IKRecommandCompanyVC      *recomandVc;
@property(nonatomic,strong)IKCompanyDetailVC      *companyDetailVc;
@property(nonatomic,strong)IKCompanyAdTableViewCell      *adView;

@property(nonatomic,strong)UIButton         *chooseBtn;
@property(nonatomic,strong)UIView           *headerView;
@property(nonatomic,strong)UIImageView      *refreshView;

@property(nonatomic,assign)NSInteger         dataPage;
@property(nonatomic,copy)NSArray            *dataArray;
@property(nonatomic,assign)NSInteger         showChooseType;
@property(nonatomic,strong)NSIndexPath       *chooseClassifyIP;
@property(nonatomic,copy)NSArray            *recommendArray;

@end

@implementation IKCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableViewInsetH = ceilf(IKSCREENH_HEIGHT * 0.3523)+8 + 44;;
    _hadAddHeaderView = NO;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 1)];
    lineView.backgroundColor = IKLineColor;
    [self.view addSubview:lineView];
    
    [IKNotificationCenter addObserver:self selector:@selector(adViewClick:) name:@"IKAdViewClick" object:nil];
    self.dataPage = 1;
    self.showChooseType = 0;
    self.chooseClassifyIP = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self initNavigationContent];
    [self getCompanyInfo];

    [self.view addSubview:self.bgTableView];
    
    [self addNotification];
    // Do any additional setup after loading the view.
}

- (void)addNotification
{
    [IKNotificationCenter addObserver:self selector:@selector(cityChangeNeedRefreshData:) name:IKCityChangeNeedRefrshDataKey object:nil];
}


- (void)cityChangeNeedRefreshData:(NSNotification *)notification
{
    NSLog(@"cityChangeNeedRefreshData");
    [self getCompanyInfo];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_adView AllStartScrollPage];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_adView AllStopScrollPage];
}



- (void)adViewClick:(NSNotification *)noti
{
    NSLog(@"noti = %@",noti.userInfo);
    NSInteger index = [[noti.userInfo objectForKey:@"index"] integerValue];
    IKCompanyInfoModel *model = self.recommendArray[index];
    [self goCompanyDeatilViewControllerWithIndex:model];
}

#pragma mark - InitView

- (void)initNavigationContent
{
    [self createRightBarItem];
    [self createLeftBarItem];
    [self setNavigationTitle];
    
}

- (void)createRightBarItem
{
    // 搜索
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(10, 20, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(14, 0, 14, 54);
    
    UIImage *image =[UIImage imageByApplyingAlpha:0.8 image:[UIImage imageNamed:@"IK_search"]];
    [button setImage:[UIImage imageNamed:@"IK_search"] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)createLeftBarItem
{
    // 推荐公司
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(recommendCompanyButtonCkick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(14, 54, 14, 0);
    
    UIImage *image =[UIImage imageByApplyingAlpha:0.8 image:[UIImage imageNamed:@"IK_arrow_right"]];
    [button setImage:[UIImage imageNamed:@"IK_arrow_right"] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}


// 设置导航栏内容
- (void)setNavigationTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"推荐公司";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    self.navigationItem.titleView = title;
}



- (IKTableView *)bgTableView
{
    if (_bgTableView == nil) {
        _bgTableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 1, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 49-64) style:UITableViewStylePlain];
        _bgTableView.backgroundColor = IKGeneralLightGray;
        _bgTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bgTableView.showsVerticalScrollIndicator = YES;
        _bgTableView.showsHorizontalScrollIndicator = NO;
        _bgTableView.delegate = self;
        _bgTableView.dataSource = self;
        _bgTableView.bounces = YES;
        
        _bgTableView.contentInset = UIEdgeInsetsMake(_tableViewInsetH, 0, 0, 0);
        
        IKCompanyAdTableViewCell *cell = [[IKCompanyAdTableViewCell alloc] initWithFrame:CGRectMake(0, -_tableViewInsetH, IKSCREEN_WIDTH, _tableViewInsetH-8-44)];
        cell.backgroundColor = [UIColor whiteColor];
        [_bgTableView addSubview:cell];
        _adView = cell;
    
        [_bgTableView addSubview:self.headerView];
        _hadAddHeaderView = YES;
        
        UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(IKSCREEN_WIDTH * 0.5 - 13, -38, 26, 26)];
        imageV1.image = [UIImage imageNamed:@"IK_logo_grey"];
        [_bgTableView addSubview:imageV1];
        
        UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(IKSCREEN_WIDTH * 0.5 - 15, -40, 30, 30)];
        imageV2.image = [UIImage imageNamed:@"IK_cycle"];
        [_bgTableView addSubview:imageV2];
        
        self.refreshView = imageV2;
    }
    
    return _bgTableView;
}


- (UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -44, IKSCREEN_WIDTH, 44)];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        UIView *view1 = [[UIView alloc] init];
        view1.backgroundColor = IKMainTitleColor;
        view1.layer.cornerRadius = 2.5;
        
        [_headerView addSubview:view1];
        
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerView.mas_top).offset(15);
            make.left.equalTo(_headerView.mas_left).offset(15);
            make.bottom.equalTo(_headerView.mas_bottom).offset(-15);
            make.width.mas_equalTo(5);
        }];
        
        
        UILabel *label = [[UILabel alloc] init];
        label.tag = 10101;
        label.text = @"海量健身公司,等你开撩!";
        label.textColor = IKMainTitleColor;
        label.font = [UIFont systemFontOfSize:IKSubTitleFont];
        label.textAlignment = NSTextAlignmentLeft;
//        label.backgroundColor = [UIColor redColor];
        [_headerView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerView.mas_top).offset(14);
            make.left.equalTo(view1.mas_right).offset(8);
            make.bottom.equalTo(_headerView.mas_bottom).offset(-14);
            make.width.equalTo(_headerView.mas_width).multipliedBy(0.5);
        }];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(chooseCompanyClassify:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 80, 44);
        button.imageEdgeInsets = UIEdgeInsetsMake(14, 64, 14, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -72, 0, 0);
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        //        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [button setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        [button setTitleColor:[IKSubHeadTitleColor colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        button.titleLabel.lineBreakMode =  NSLineBreakByTruncatingTail;
        [button setTitle:@"全部公司" forState:UIControlStateNormal];
        
        UIImage *image =[UIImage imageByApplyingAlpha:0.8 image:[UIImage imageNamed:@"IK_showMore_grey"]];
        [button setImage:[UIImage imageNamed:@"IK_showMore_grey"] forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateHighlighted];
        //        button.userInteractionEnabled = NO;
        [_headerView addSubview:button];
        
        self.chooseBtn = button;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerView.mas_top);
            make.bottom.equalTo(_headerView.mas_bottom);
            make.right.equalTo(_headerView.mas_right).offset(-15);
            make.width.mas_equalTo(80);
        }];
        
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = IKLineColor;
        [_headerView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_headerView.mas_bottom);
            make.left.and.right.equalTo(_headerView);
            make.height.mas_equalTo(1);
        }];
        
        UIView *topLineView = [[UIView alloc] init];
        topLineView.backgroundColor = IKLineColor;
        [_headerView addSubview:topLineView];
        
        [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerView.mas_top);
            make.left.and.right.equalTo(_headerView);
            make.height.mas_equalTo(1);
        }];

    }
    return _headerView;
}

- (IKCompanyClassifyView *)classifyView
{
    if (_classifyView == nil) {
        _classifyView = [[IKCompanyClassifyView alloc] initWithFrame:CGRectMake(0, 44, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64)];
        _classifyView.delegate = self;
        _classifyView.selectedIndexPath = self.chooseClassifyIP;
        _classifyView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(_classifyView.frame));
        [self.view insertSubview:_classifyView aboveSubview:_bgTableView];
    }
    return _classifyView;
}

- (IKRecommandCompanyVC *)recomandVc
{
    if (_recomandVc == nil) {
        _recomandVc = [[IKRecommandCompanyVC alloc] init];
    }
    return _recomandVc;
}


- (IKCompanyDetailVC *)companyDetailVc
{
    if (_companyDetailVc == nil) {
        _companyDetailVc = [[IKCompanyDetailVC alloc] init];
    }
    
    return _companyDetailVc;
}

- (void)getCompanyInfo
{
    NSString *selectedCityId = [IKUSERDEFAULT objectForKey:@"selectedCityId"];
    
    if (IKStringIsEmpty(selectedCityId)) {
        selectedCityId = @"0";
    }
    NSDictionary *jobParam = @{@"cityId":selectedCityId,@"pageSize":@"30",@"page":[NSString stringWithFormat:@"%ld",self.dataPage]};
    
    [[IKNetworkManager shareInstance] getCompanyPageCompanyInfoWithParam:jobParam backData:^(NSArray *dataArray, BOOL success) {
        
        if (dataArray.count > 0) {
            self.dataArray = [NSArray arrayWithArray:dataArray];
            [self.bgTableView reloadData];

        }
    }];
    
    [[IKNetworkManager shareInstance] getCompanyPageRecommendCompanyListWithParam:jobParam backData:^(NSArray *dataArray, BOOL success) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.recommendArray = [NSArray arrayWithArray:dataArray];
            [_adView addCompanyAdCellData:dataArray];
        });
    }];
}



- (void)reloadTableViewSection:(NSInteger )section
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView performWithoutAnimation:^{
            [self.bgTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        }];
    });
    
}





- (void)searchButtonClick:(UIButton *)button
{
    dispatch_async(dispatch_get_main_queue(), ^{
        IKSearchVC *searchvc = [IKSearchVC alloc];
//        searchvc.delegate = self;
        searchvc.modalPresentationStyle = UIModalPresentationPopover;
        searchvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        IKNavigationController *nav = [[IKNavigationController alloc] initWithRootViewController:searchvc];
        [self presentViewController:nav animated:NO completion:^{
            
        }];
    });
}

- (void)recommendCompanyButtonCkick:(UIButton *)button
{
    
    self.recomandVc.dataArray = [self.recommendArray mutableCopy];
    IKNavigationController *nav = [[IKNavigationController alloc] initWithRootViewController:self.recomandVc];
    
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

- (void)chooseCompanyClassify:(UIButton *)button
{
    NSLog(@"chooseCompanyClassify = %@",button.titleLabel.text);
    
    UILabel *label = (UILabel *)[_headerView viewWithTag:10101];

    if (_showChooseType == 0) {
        [button setTitle:@"" forState:UIControlStateNormal];
        button.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        _showChooseType = 1;
        label.text = @"请选择公司类型";
        _bgTableView.contentOffset = CGPointMake(0, ceilf(IKSCREENH_HEIGHT * 0.3523)+8);

        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.classifyView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
        
        [self hideTabBar];
    }
    else{
        [self showTabBar];
        if (_showChooseType == 1) {
            [button setTitle:@"全部公司" forState:UIControlStateNormal];
        }
//        _bgTableView.contentOffset = CGPointMake(0, 0);
        button.imageView.transform = CGAffineTransformIdentity;
        label.text = @"海量健身公司,等你开撩!";
        [self.classifyView removeFromSuperview];
        self.classifyView = nil;
        
        _showChooseType = 0;
    }
}

- (void)selectViewDidSelectIndexPath:(NSIndexPath *)indexPath selectContent:(NSString *)select
{
    [_chooseBtn setTitle:select forState:UIControlStateNormal];
    self.chooseClassifyIP = indexPath;
   
    _showChooseType = 2;
    [self chooseCompanyClassify:_chooseBtn];
    [self.classifyView removeFromSuperview];
    self.classifyView = nil;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ceilf(IKSCREENH_HEIGHT * 0.165);
}


//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 44;
//    }
//    
//    return 0.01;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId=@"IKCompanyTableViewCellId";
    IKCompanyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil)
    {
        cell = [[IKCompanyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
    
    [cell addCellData:self.dataArray[indexPath.row]];
    return cell;
}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return self.headerView;
//    }
//    
//    return nil;
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IKCompanyInfoModel *model = self.dataArray[indexPath.row];

    [self goCompanyDeatilViewControllerWithIndex:model];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)goCompanyDeatilViewControllerWithIndex:(IKCompanyInfoModel *)model
{
    NSLog(@"description = %@",model.description);
    self.companyDetailVc.companyInfoModel = model;
    [self.navigationController pushViewController:self.companyDetailVc animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > -44) {
        [self.view addSubview:self.headerView];
        self.headerView.frame = CGRectMake(0, 0, IKSCREEN_WIDTH, 44);
        _hadAddHeaderView = NO;
    }
    else{
        
        if (!_hadAddHeaderView) {
            [_bgTableView addSubview:self.headerView];
            self.headerView.frame = CGRectMake(0, -44, IKSCREEN_WIDTH, 44);
            _hadAddHeaderView = YES;
        }
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    _scrollViewIsDragging = YES;
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _scrollViewIsDragging = NO;
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
