//
//  IKCompanyDetailVC.m
//  IamKing
//
//  Created by Luris on 2017/7/30.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyDetailVC.h"

@interface IKCompanyDetailVC ()<UIScrollViewDelegate>


@property(nonatomic,strong)IKScrollView     *bottomScrollView;
@property(nonatomic,strong)UIImageView      *navImageView;
@property(nonatomic,assign)CGRect            oldHeadImageFrame;

@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIImage      *bulrImage;

@end

@implementation IKCompanyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationController.navigationBar.translucent = YES;
    [self initCompanyDetailBottomScrollView];
    [self initNavImageView];
    [self initLeftBackItem];

    
    
    [self initTopView];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)initNavImageView
{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 64)];
    imageV.backgroundColor = [UIColor clearColor];
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    imageV.userInteractionEnabled = YES;
    [self.view insertSubview:imageV aboveSubview:_bottomScrollView];
    self.navImageView = imageV;
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
    
    [self.view insertSubview:button aboveSubview:self.navImageView];
}


- (void)initCompanyDetailBottomScrollView
{
    IKScrollView *scrollView = [[IKScrollView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.bounces = YES;
    scrollView.delegate = self;
    [scrollView setContentInset:UIEdgeInsetsMake(200, 0, 0, 0)];
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(IKSCREEN_WIDTH, IKSCREENH_HEIGHT * 2);
    _bottomScrollView = scrollView;

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



- (void)initTopView
{
    UIImageView *imageview = [[UIImageView alloc] init];
//    imageview.backgroundColor = [UIColor redColor];
    imageview.frame = CGRectMake(0, -200, CGRectGetWidth(self.view.bounds), 200);
    
    [imageview sd_setImageWithURL:[NSURL URLWithString:@"https://pic.iamking.com.cn/Public/User/headerImage/1501403379_608_325.jpg" ] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.bulrImage = [UIImage boxblurImage:image withBlurNumber:1];
            imageview.image = self.bulrImage;
            _navImageView.image = self.bulrImage;
            _navImageView.alpha = 0.0001;
        });
    }];
    
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    imageview.userInteractionEnabled = YES;
    
    [_bottomScrollView addSubview:imageview];
    
    _headImageView = imageview;
    
    self.oldHeadImageFrame = imageview.frame;

}

//- (void)initNavTitle
//{
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
//    //    title.backgroundColor = [UIColor redColor];
//    title.text = @"";
//    title.textColor = IKMainTitleColor;
//    title.textAlignment = NSTextAlignmentCenter;
//    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
//    self.navigationItem.titleView = title;
//    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 1)];
//    lineView.backgroundColor = IKLineColor;
//    [self.view addSubview:lineView];
//}



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
