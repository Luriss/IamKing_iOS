//
//  IKCompanyDetailVC.m
//  IamKing
//
//  Created by Luris on 2017/7/30.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyDetailVC.h"
#import "IKTableView.h"
#import "IKComDetailTopTableViewCell.h"

@interface IKCompanyDetailVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)IKTableView      *bottomTableView;

@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIImage      *bulrImage;
@property(nonatomic,strong)UILabel      *titleLabel;

@end

@implementation IKCompanyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.bottomTableView];
    [self initLeftBackItem];
    
    [self initNavTitle];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
}

- (void)initLeftBackItem
{
    // 返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(companyDetailVcDismissSelf) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(15, 20, 44, 44);
//    button.backgroundColor = [UIColor redColor];
    button.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 24);
    [button setImage:[UIImage imageNamed:@"IK_back_white"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_back_white"] forState:UIControlStateHighlighted];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (IKTableView *)bottomTableView
{
    if (_bottomTableView == nil) {
        _bottomTableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT) style:UITableViewStylePlain];
        _bottomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bottomTableView.backgroundColor = IKGeneralLightGray;
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        _bottomTableView.bounces = YES;
        
        [self initTableViewHeaderView];
    }
    return _bottomTableView;
}

- (void)initTableViewHeaderView
{
    CGFloat height = ceilf(IKSCREENH_HEIGHT *0.255);
    UIImageView *imageview = [[UIImageView alloc] init];

    imageview.frame = CGRectMake(0, -height, CGRectGetWidth(self.view.bounds), height);
    [imageview sd_setImageWithURL:[NSURL URLWithString:@"https://pic.iamking.com.cn/Public/User/headerImage/1501403379_608_325.jpg" ] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.bulrImage = [UIImage boxblurImage:image withBlurNumber:1];
            imageview.image = self.bulrImage;
            
            [self.navigationController.navigationBar setBackgroundImage:[UIImage ct_imageFromImage:self.bulrImage inRect:CGRectMake(0, 0, IKSCREEN_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
        });
    }];
    
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    imageview.userInteractionEnabled = YES;
    _headImageView = imageview;
    [self.bottomTableView addSubview:imageview];
    
    
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(self.bottomTableView.center.x - 50, -80, 100, 100)];
    topBgView.backgroundColor = [UIColor redColor];
    
    [self.bottomTableView addSubview:topBgView];
    
    self.bottomTableView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
}


- (void)setCompanyInfoModel:(IKCompanyInfoModel *)companyInfoModel
{
    if (companyInfoModel) {
        _companyInfoModel = companyInfoModel;
        
        [[IKNetworkManager shareInstance]getCompanyPageCompanyInfoDetailWithParam:@{@"userCompanyId":companyInfoModel.companyID} backData:^(IKCompanyDetailHeadModel *detailModel, BOOL success) {
            NSLog(@"description = %@",detailModel.description);
        }];
    }
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 50, 250, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"威尔士健身";
    title.textColor = IKMainTitleColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
//    self.navigationItem.titleView = title;
    
    _titleLabel = title;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH*0.5, 44)];
    lineView.backgroundColor = [UIColor redColor];;
    self.navigationItem.titleView  = lineView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static  NSString *cellId=@"IKComDetailTopTableViewCellId";
        IKComDetailTopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKComDetailTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 250;
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//
//        return imageview;
//    }
//    return nil;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"offsetY = %.0f",offsetY);

     // top Image 放大效果
    if(offsetY < -200) {
        CGRect currentFrame = _headImageView.frame;
        currentFrame.origin.y = offsetY;
        currentFrame.size.height = -1*offsetY;
        _headImageView.frame = currentFrame;
    }
    else{
        
    }
    
    
//    if (offsetY > -200) {
//        [self.navigationController.navigationBar setBackgroundImage:self.bulrImage forBarMetrics:UIBarMetricsDefault];
//    }
//    else{
//        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    }
    
    if (offsetY > 210) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.navigationItem.titleView = _titleLabel;
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        self.navigationItem.titleView = nil;
    }
}



- (void)companyDetailVcDismissSelf
{
    [self.navigationController popViewControllerAnimated:YES];
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
