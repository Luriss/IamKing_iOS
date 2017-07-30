//
//  IKCompanyViewController.m
//  IamKing
//
//  Created by Luris on 2017/7/29.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyViewController.h"
#import "IKCompanyAdTableViewCell.h"
#import "IKTableView.h"
#import "IKSearchVC.h"
#import "IKNetworkManager.h"
#import "IKCompanyInfoModel.h"
#import "IKCompanyTableViewCell.h"
#import "IKCompanyClassifyView.h"
#import "IKRecommandCompanyVC.h"
#import "IKCompanyDetailVC.h"


@interface IKCompanyViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,IKCompanyClassifyViewDelegate>//,IKSearchViewControllerDelegate>

@property(nonatomic,strong)IKTableView      *bgTableView;
@property(nonatomic,strong)IKCompanyClassifyView      *classifyView;
@property(nonatomic,strong)IKNavigationController      *recomandVc;
@property(nonatomic,strong)IKCompanyDetailVC      *companyDetailVc;

@property(nonatomic,assign)NSInteger         dataPage;
@property(nonatomic,strong)UIView           *headerView;
@property(nonatomic,copy)NSArray            *dataArray;
@property(nonatomic,assign)NSInteger         showChooseType;
@property(nonatomic,strong)UIButton         *chooseBtn;
@property(nonatomic,strong)NSIndexPath       *chooseClassifyIP;

@end

@implementation IKCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 1)];
    lineView.backgroundColor = IKLineColor;
    [self.view addSubview:lineView];
    
    self.dataPage = 1;
    self.showChooseType = 0;
    self.chooseClassifyIP = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self initNavigationContent];
    
    
//    [IKNotificationCenter addObserver:self selector:@selector(getCompanyInfo) name:kIKGetCompanyPageVcData object:nil];
    
    [self.view addSubview:self.bgTableView];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getCompanyInfo];
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
    title.textColor = IKMainTitleColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    self.navigationItem.titleView = title;
}



- (IKTableView *)bgTableView
{
    if (_bgTableView == nil) {
        _bgTableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 1, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 49) style:UITableViewStylePlain];
        _bgTableView.backgroundColor = IKGeneralLightGray;
        _bgTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bgTableView.showsVerticalScrollIndicator = YES;
        _bgTableView.showsHorizontalScrollIndicator = NO;
        _bgTableView.delegate = self;
        _bgTableView.dataSource = self;
        _bgTableView.bounces = NO;
    }
    
    return _bgTableView;
}


- (IKCompanyClassifyView *)classifyView
{
    if (_classifyView == nil) {
        _classifyView = [[IKCompanyClassifyView alloc] initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64)];
        _classifyView.delegate = self;
        _classifyView.selectedIndexPath = self.chooseClassifyIP;
        _classifyView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(_classifyView.frame));
        [self.view insertSubview:_classifyView aboveSubview:_bgTableView];
    }
    return _classifyView;
}

- (IKNavigationController *)recomandVc
{
    if (_recomandVc == nil) {
        IKRecommandCompanyVC *vc = [[IKRecommandCompanyVC alloc] init];
        _recomandVc = [[IKNavigationController alloc] initWithRootViewController:vc];
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
        NSDictionary *jobParam = @{@"cityId":selectedCityId,@"pageSize":@"8",@"page":[NSString stringWithFormat:@"%ld",self.dataPage]};
    
    [[IKNetworkManager shareInstance] getCompanyPageCompanyInfoWithParam:jobParam backData:^(NSArray *dataArray, BOOL success) {
        
        if (dataArray.count > 0) {
            self.dataArray = [NSArray arrayWithArray:dataArray];
            [self reloadTableViewSection:1];
        }
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
    
    [self presentViewController:self.recomandVc animated:YES completion:^{
        
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
    return  2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return ceilf(IKSCREENH_HEIGHT * 0.3523);
    }
    
    return ceilf(IKSCREENH_HEIGHT * 0.165);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 44;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 0.1;
    }
    return 8;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else{
        return self.dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static  NSString *cellId=@"IKCompanyAdTableViewCellId";
        IKCompanyAdTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKCompanyAdTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
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
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *view1 = [[UIView alloc] init];
        view1.backgroundColor = IKMainTitleColor;
        view1.layer.cornerRadius = 2.5;
        
        [view addSubview:view1];

        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(15);
            make.left.equalTo(view.mas_left).offset(15);
            make.bottom.equalTo(view.mas_bottom).offset(-15);
            make.width.mas_equalTo(5);
        }];
        
        
        UILabel *label = [[UILabel alloc] init];
        label.tag = 10101;
        label.text = @"海量健身公司,等你开撩!";
        label.textColor = IKMainTitleColor;
        label.font = [UIFont systemFontOfSize:IKSubTitleFont];
        label.textAlignment = NSTextAlignmentLeft;
        [view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(14);
            make.left.equalTo(view1.mas_right).offset(8);
            make.bottom.equalTo(view.mas_bottom).offset(-14);
            make.width.equalTo(view.mas_width).multipliedBy(0.5);
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
        button.userInteractionEnabled = NO;
        [view addSubview:button];
        
        self.chooseBtn = button;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top);
            make.bottom.equalTo(view.mas_bottom);
            make.right.equalTo(view.mas_right).offset(-15);
            make.width.mas_equalTo(80);
        }];
        
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = IKLineColor;
        [view addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view.mas_bottom);
            make.left.and.right.equalTo(view);
            make.height.mas_equalTo(1);
        }];
        
        _headerView = view;

        return view;
        
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        IKCompanyInfoModel *model = self.dataArray[indexPath.row];
        
        NSLog(@"description = %@",model.description);
        self.companyDetailVc.companyInfoModel = model;
        [self.navigationController pushViewController:self.companyDetailVc animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 240) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [_bgTableView setFrame:CGRectMake(0, 20, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 20 -49)];
        self.chooseBtn.userInteractionEnabled = YES;
    }
    else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [_bgTableView setFrame:CGRectMake(0, 1, IKSCREEN_WIDTH, IKSCREENH_HEIGHT -49)];
        self.chooseBtn.userInteractionEnabled = NO;
    }
    
    
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
