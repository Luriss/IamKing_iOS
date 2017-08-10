//
//  IKCompanyDetailVC.m
//  IamKing
//
//  Created by Luris on 2017/7/30.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyDetailVC.h"
#import "IKComDetailTopTableViewCell.h"
#import "IKComDetailTypeTableViewCell.h"
#import "IKComDetailLoopTableViewCell.h"
#import "IKComInformationTableViewCell.h"
#import "IKCompanyDetailTitleTableViewCell.h"
#import "IKCompanyProgressTableViewCell.h"
#import "IKCompanyProgressVC.h"
#import "IKWorkAddressTableViewCell.h"
#import "IKManagerTeamLeftTableViewCell.h"
#import "IKManagerTeamRightTableViewCell.h"
#import "IKCompanyManagerTeamModel.h"
#import "IKCompanyNeedJobTableViewCell.h"
#import "IKCompanyShopTableViewCell.h"
#import "IKCompanyShopNumModel.h"
#import "IKAppraiseView.h"
#import "IKJobDetailVC.h"
#import "IKJobTypeView.h"
#import "IKInfoTableViewCell.h"
#import "IKLoopImageViewController.h"
#import "IKTeamDeatilView.h"
#import "IKShopDetailView.h"
#import "IKShopListViewController.h"


@interface IKCompanyDetailVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,IKComInformationTableViewCellDelegate,IKAppraiseViewDelegate,IKJobTypeViewDelegate,IKShopDetailViewDelegate>
{
    CGFloat _imageH;
    CGFloat _infoCellH;
    
    BOOL hadAddTypeView;
}

@property(nonatomic,strong)IKTableView      *bottomTableView;
@property(nonatomic,strong)IKScrollView      *navScrollVIew;
@property(nonatomic,strong)IKCompanyDetailHeadModel      *headModel;
@property(nonatomic,strong)IKCompanyAboutUsModel      *aboutUsModel;
@property(nonatomic,strong)IKJobTypeView    *jobTypeView;
@property(nonatomic,strong)IKJobTypeView           *topTypeView;

@property(nonatomic,assign)IKCompanyDetailVCType       type;
@property(nonatomic,strong)IKButton         *attentionBtn;

@property(nonatomic,strong)UILabel          *topNameLabel;
@property(nonatomic,strong)UIImageView      *headImageView;
@property(nonatomic,strong)UIImageView      *navImageView;
@property(nonatomic,strong)UIImageView      *logoImageView;
@property(nonatomic,strong)UIImage          *bulrImage;
@property(nonatomic,strong)UILabel          *attentionNum;
@property(nonatomic,strong)UILabel          *attentionNum1;
@property(nonatomic,strong)UILabel          *attentionNum2; // 折中方法模拟翻页效果
@property(nonatomic,strong)IKScrollView     *attentionView;

@property(nonatomic,strong)UIView           *appraiseView;

@property(nonatomic,strong)NSArray          *managerTeamArray;
@property(nonatomic,strong)NSArray          *needJobArray;
@property(nonatomic,strong)NSArray          *shopTypeArray;
@property(nonatomic,assign)NSInteger         selectType;

@property(nonatomic,assign)BOOL             needShowMoreBtn;
@property(nonatomic,assign)BOOL             showMore;
@property(nonatomic,assign)BOOL             firstComeIn;


@end

@implementation IKCompanyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    _imageViewH = ceilf(IKSCREENH_HEIGHT *0.255);
    
    self.type = IKCompanyDetailVCTypeAboutUs;
    _showMore = NO;
    hadAddTypeView = NO;
    
    
    [self.view addSubview:self.bottomTableView];
    [self initNavScrollView];
    [self initLeftBackItem];
    
    
    [self addNotification];

    _imageH = ceilf(IKSCREENH_HEIGHT *0.255);
    // Do any additional setup after loading the view.
}


- (void)addNotification
{
    [IKNotificationCenter addObserver:self selector:@selector(loopImageSelected:) name:IKCompanyLoopImageSelectedKey object:nil];
}


- (void)loopImageSelected:(NSNotification *)notifiation
{
    NSLog(@"uuuuuu = %@ ,%@",[notifiation.userInfo objectForKey:@"index"],[notifiation.userInfo objectForKey:@"allImage"]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        IKLoopImageViewController *loop = [[IKLoopImageViewController alloc] init];
        
        loop.imageArray = [notifiation.userInfo objectForKey:@"allImage"];
        loop.selectedIndex = [notifiation.userInfo objectForKey:@"index"];
        [self.navigationController pushViewController:loop animated:NO];
    });
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [self.navigationController setNavigationBarHidden:NO animated:NO];

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES animated:NO];

}


//- (void)addTypeView
//{
//    
//    IKJobTypeView *newJ = [self.jobTypeView copy];
//    newJ.frame = CGRectMake(0, 64, IKSCREEN_WIDTH, 44);
//
//    [self.view insertSubview:newJ aboveSubview:_bottomTableView];
//}

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
    
    [self.view insertSubview:button aboveSubview:_navScrollVIew];
}

- (void)initNavScrollView
{
    IKScrollView *scrollView = [[IKScrollView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 64)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.scrollEnabled = NO;
    scrollView.bounces = NO;
    //    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view insertSubview:scrollView aboveSubview:self.bottomTableView];
    //    _navScrollVIew.contentSize = CGSizeMake(IKSCREEN_WIDTH, _imageViewH);
    
    UIImageView *imageview = [[UIImageView alloc] init];
    
    imageview.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), ceilf(IKSCREENH_HEIGHT *0.255));
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    imageview.userInteractionEnabled = YES;
    _navImageView = imageview;
    _navScrollVIew = scrollView;
    

}


- (IKButton *)attentionBtn
{
    if (_attentionBtn == nil) {
        _attentionBtn = [IKButton buttonWithType:UIButtonTypeCustom];
        [_attentionBtn addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _attentionBtn.frame = CGRectMake(20, -64, 66, 22);
        //    button.backgroundColor = [UIColor redColor];
        [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _attentionBtn.layer.cornerRadius = 11;
        _attentionBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _attentionBtn.layer.borderWidth = 1;
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, -37, 40, 20)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:13.0f];
        label.text = @"人关注";
//        label.backgroundColor = [UIColor yellowColor];
        [self.bottomTableView  insertSubview:label aboveSubview:self.headImageView];
        [self.bottomTableView insertSubview:self.attentionView aboveSubview:self.headImageView];
        
        [_attentionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bottomTableView.mas_top).offset(-37);
            make.left.equalTo(_bottomTableView.mas_left).offset(20);
            make.height.mas_equalTo(20);
//            make.width.mas_equalTo(10);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_attentionView);
            make.left.equalTo(_attentionView.mas_right);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(20);
        }];
        
    }
    return _attentionBtn;
}

- (IKScrollView *)attentionView
{
    if (_attentionView == nil) {
        _attentionView = [[IKScrollView alloc] initWithFrame:CGRectMake(0,0, 10, 20)];
//        _attentionView.backgroundColor = [UIColor redColor];
        _attentionView.scrollEnabled = NO;
        _attentionView.bounces = NO;
        _attentionView.pagingEnabled = YES;
        //    scrollView.delegate = self;
        _attentionView.showsVerticalScrollIndicator = NO;
        _attentionView.contentSize = CGSizeMake(0, 60);

        [_attentionView addSubview:self.attentionNum2];
        [_attentionView addSubview:self.attentionNum1];
        [_attentionView addSubview:self.attentionNum];
        
        [_attentionView setContentOffset:CGPointMake(0, 20) animated:NO];
    }
        return _attentionView;
}


- (UILabel *)attentionNum2
{
    if (_attentionNum2 == nil) {
        _attentionNum2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 20, 20)];
        _attentionNum2.textColor = [UIColor whiteColor];
        _attentionNum2.textAlignment = NSTextAlignmentLeft;
        _attentionNum2.font = [UIFont systemFontOfSize:13.0f];
//        _attentionNum2.backgroundColor = [UIColor purpleColor];
//        _attentionNum2.text = @"3";
    }
    return _attentionNum2;
}

- (UILabel *)attentionNum1
{
    if (_attentionNum1 == nil) {
        _attentionNum1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 20, 20)];
        _attentionNum1.textColor = [UIColor whiteColor];
        _attentionNum1.textAlignment = NSTextAlignmentLeft;
        _attentionNum1.font = [UIFont systemFontOfSize:13.0f];
//        _attentionNum1.backgroundColor = [UIColor cyanColor];
//        _attentionNum1.text = @"2";
    }
    return _attentionNum1;
}


- (UILabel *)attentionNum
{
    if (_attentionNum == nil) {
        _attentionNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _attentionNum.textColor = [UIColor whiteColor];
        _attentionNum.textAlignment = NSTextAlignmentLeft;
        _attentionNum.font = [UIFont systemFontOfSize:13.0f];
//        _attentionNum.text = @"1";
//        _attentionNum.backgroundColor = [UIColor redColor];
//        _attentionNum.hidden = YES;
    }
    return _attentionNum;
}



- (void)attentionButtonClick:(IKButton *)button
{
    NSLog(@"attentionButtonClick = %d",button.isClick);
    
    CGFloat y = _attentionView.contentOffset.y;
    if (!button.isClick) {
        button.isClick = YES;
        [button setTitle:@"取消关注" forState:UIControlStateNormal];
        y += 20;
    }
    else{
        button.isClick = NO;
        [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        y -= 20;
    }
    [_attentionView setContentOffset:CGPointMake(0, y) animated:YES];

}


- (UIView *)appraiseView
{
    if (_appraiseView == nil) {
        _appraiseView = [[UIView alloc] initWithFrame:CGRectMake(IKSCREEN_WIDTH - 110, -78, 90, 60)];
//        _appraiseView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *appraiseImageV = [[UIImageView alloc] initWithFrame:CGRectMake(66, 0, 24, 24)];
        [appraiseImageV setImage:[UIImage imageNamed:@"IK_appraise_white"]];
//        appraiseImageV.backgroundColor = [UIColor redColor];
        [_appraiseView addSubview:appraiseImageV];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 90, 20)];
        label.text = @"公司评价";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:13.0f];
//        label.backgroundColor = [UIColor redColor];
        [_appraiseView addSubview:label];
        
        UITapGestureRecognizer *appraiseTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(appraiseViewTap:)];
        [_appraiseView addGestureRecognizer:appraiseTap];
    }
    
    return _appraiseView;
}


- (void)appraiseViewTap:(UITapGestureRecognizer *)gesture
{
    NSLog(@"appraiseViewTap");
    
    IKAppraiseView *appraiseView = [[IKAppraiseView alloc] init];
    [appraiseView show];
    appraiseView.delegate = self;
}

- (void)appraiseViewSelectedData:(NSArray *)array
{
    NSLog(@"array = %@",array);
}

- (IKTableView *)bottomTableView
{
    if (_bottomTableView == nil) {
        _bottomTableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT) style:UITableViewStyleGrouped];
        _bottomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bottomTableView.backgroundColor = IKGeneralLightGray;
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        _bottomTableView.bounces = YES;
        _bottomTableView.contentInset = UIEdgeInsetsMake(ceilf(IKSCREENH_HEIGHT *0.255), 0, 0, 0);
    }
    return _bottomTableView;
}


- (UIImageView *)logoImageView
{
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bottomTableView.center.x - 50, -80, 100, 100)];
        _logoImageView.layer.borderWidth = 1;
        _logoImageView.layer.borderColor = IKLineColor.CGColor;
        _logoImageView.layer.cornerRadius = 5;
        _logoImageView.layer.masksToBounds = YES;
        [self.bottomTableView insertSubview:_logoImageView aboveSubview:self.headImageView];
        
    }
    return _logoImageView;
}

- (IKJobTypeView *)jobTypeView
{
    if (_jobTypeView == nil) {
        _jobTypeView = [[IKJobTypeView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 44)];
        _jobTypeView.backgroundColor = [UIColor whiteColor];
        _jobTypeView.delegate = self;
        _jobTypeView.buttonFont = [UIFont boldSystemFontOfSize:15.0f];
        NSString *str = nil;
        _jobTypeView.lineWidth = 64;
        
        NSLog(@"_headModel.companyType = %@",_headModel.companyType);
        switch ([_headModel.companyType integerValue]) {
            case 1:
                str = @"连锁门店";
                break;
            case 2:
                str = @"产品服务";
                break;
            case 3:
                str = @"全国校区";
                break;
                
            default:
                str = @"连锁门店";
                break;
        }
        
        _jobTypeView.titleArray = @[@"关于我们",@"管理团队",str,@"在招职位"];
    }
    return _jobTypeView;
}

- (IKJobTypeView *)topTypeView
{
    if (_topTypeView == nil) {
        _topTypeView = [[IKJobTypeView alloc] initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, 44)];
        _topTypeView.backgroundColor = [UIColor whiteColor];
        _topTypeView.delegate = self;
        _topTypeView.buttonFont = [UIFont boldSystemFontOfSize:15.0f];
        NSString *str = nil;
        _topTypeView.lineWidth = 64;
        _topTypeView.hidden = YES;
        switch ([_headModel.companyType integerValue]) {
            case 1:
                str = @"连锁门店";
                break;
            case 2:
                str = @"产品服务";
                break;
            case 3:
                str = @"全国校区";
                break;
                
            default:
                str = @"连锁门店";
                break;
        }
        
        _topTypeView.titleArray = @[@"关于我们",@"管理团队",str,@"在招职位"];
    }
    return _topTypeView;
}

- (UIImageView *)headImageView
{
    if (_headImageView == nil) {
        CGFloat height = ceilf(IKSCREENH_HEIGHT *0.255);
        
        _headImageView = [[UIImageView alloc] init];
        _headImageView.frame = CGRectMake(0, -height, CGRectGetWidth(self.view.bounds), height);
        
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
        _headImageView.userInteractionEnabled = YES;
        _headImageView.backgroundColor = IKGeneralLightGray;
        [self.bottomTableView addSubview:_headImageView];
        
        [self.bottomTableView insertSubview:self.attentionBtn aboveSubview:_headImageView];
        
        [self.bottomTableView insertSubview:self.appraiseView aboveSubview:_headImageView];
    }
    return _headImageView;
}


- (void)setCompanyInfoModel:(IKCompanyInfoModel *)companyInfoModel
{
    if (companyInfoModel) {
        _companyInfoModel = companyInfoModel;
        _firstComeIn = YES;
        NSDictionary *dict = @{@"userCompanyId":companyInfoModel.companyID};
        
        [[IKNetworkManager shareInstance]getCompanyPageCompanyInfoDetailWithParam:dict backData:^(IKCompanyDetailHeadModel *detailModel, BOOL success) {
            NSLog(@"description = %@",detailModel.description);
            if (success) {
                _headModel = detailModel;
                [self.view addSubview:self.topTypeView];
                
                [self.view insertSubview:self.topNameLabel aboveSubview:_navScrollVIew];
                _topNameLabel.text = _headModel.nickName;
                _topNameLabel.hidden = YES;
                
                self.headImageView.image = nil;
                self.navImageView.image = nil;
                
                [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.logoImageUrl ] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        self.logoImageView.image = image;
                        self.bulrImage = [UIImage boxblurImage:image withBlurNumber:1.0];
                        UIImage *okImage = [self.bulrImage rt_tintedImageWithColor:[UIColor blackColor] level:0.2];
                        self.headImageView.image = okImage;
                        self.navImageView.image = okImage;
                        
                        [_navScrollVIew addSubview:_navImageView];
                        
                        _navImageView.hidden = YES;
                        [self.bottomTableView reloadData];
                        
                    });
                }];
                
                CGSize size = [NSString getSizeWithString:_headModel.numberOfAttention size:CGSizeMake(100, 20) attribute:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]}];
                
                [self.attentionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_bottomTableView.mas_top).offset(-37);
                    make.left.equalTo(_bottomTableView.mas_left).offset(20);
                    make.height.mas_equalTo(20);
                    make.width.mas_equalTo(size.width-3);
                }];
                _attentionNum.frame = CGRectMake(0, 0, size.width-5, 20);
                _attentionNum1.frame = CGRectMake(0, 20, size.width-5, 20);
                _attentionNum2.frame = CGRectMake(0, 40, size.width-2, 20);
                
                _attentionNum1.text = _headModel.numberOfAttention;
                _attentionNum2.text = [NSString stringWithFormat:@"%ld",[_headModel.numberOfAttention integerValue]+1];
                _attentionNum.text = [NSString stringWithFormat:@"%ld",[_headModel.numberOfAttention integerValue]-1];
                
                if (_headModel.isOperate) {
                    _attentionBtn.isClick = YES;
                    [_attentionBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                    
                }
                else{
                    _attentionBtn.isClick = NO;
                    [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
                    
                }
                
                [self addStarToAppraiseView:[_headModel.numberOfAppraise integerValue]];
            }
            else{
                NSString *str = @"很抱歉,获取公司信息失败,即将退出";
                [LRToastView showTosatWithText:str inView:self.view dismissAfterDelay:1];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self companyDetailVcDismissSelf];
                });
            }
        }];
        
        [[IKNetworkManager shareInstance] getCompanyPageAboutUsInfoWithParam:dict backData:^(IKCompanyAboutUsModel *model, BOOL success) {
            NSLog(@"model.description = %@",model.description);
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _aboutUsModel = model;
                    
                    [UIView performWithoutAnimation:^{
                        [self.bottomTableView reloadData];
                    }];
                });
            }
            else{
                [LRToastView showTosatWithText:model.errorMsg inView:self.view dismissAfterDelay:1];
            }
        }];
    }
}

- (void)setTopHeaderData:(IKCompanyDetailHeadModel *)model
{
    
}




- (UILabel *)topNameLabel
{
    if (_topNameLabel == nil) {
        CGFloat w = IKSCREEN_WIDTH * 0.7;
        _topNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - w*0.5, 20, w, 44)];
        //    _topNameLabel.backgroundColor = [UIColor redColor];
        //            _topNameLabel.text = @"鼎盛健身";
        _topNameLabel.textColor = [UIColor whiteColor];
        _topNameLabel.textAlignment = NSTextAlignmentCenter;
        _topNameLabel.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
        _topNameLabel.transform = CGAffineTransformMakeTranslation(0, 44);
    }
    return _topNameLabel;
}

- (void)jobTypeViewButtonClick:(UIButton *)button
{
    NSLog(@"tag = %ld",button.tag);
    
    NSDictionary *dict = @{@"userCompanyId":_companyInfoModel.companyID,@"companyType":_headModel.companyType};
    self.selectType = button.tag - 101;
    
    switch (button.tag - 100) {
        case 1:
        {
            self.type = IKCompanyDetailVCTypeAboutUs;
            [self.bottomTableView reloadData];
        }
            break;
        case 2:
        {
            self.type = IKCompanyDetailVCTypeManagerTeam;

            if (IKArrayIsEmpty(self.managerTeamArray)) {
                [[IKNetworkManager shareInstance] getCompanyPageManagerTeamInfoWithParam:dict backData:^(NSArray *dataArray, BOOL success) {
                    if (success) {
                        self.managerTeamArray = [NSArray arrayWithArray:dataArray];
                        [self.bottomTableView reloadData];
                    }
                    else{
                        [LRToastView showTosatWithText:dataArray.firstObject inView:self.view dismissAfterDelay:1];
                    }
                }];
            }
            else{
                [self.bottomTableView reloadData];
            }
        }
            break;
        case 3:
        {
            self.type = IKCompanyDetailVCTypeMultipleShop;
            if (IKArrayIsEmpty(self.shopTypeArray)) {
                [[IKNetworkManager shareInstance] getCompanyPageShopNumberInfoWithParam:dict backData:^(NSArray *dataArray, BOOL success) {
                    if (success) {
                        self.shopTypeArray = [NSArray arrayWithArray:dataArray];
                        [self.bottomTableView reloadData];
                    }
                    else{
                        [LRToastView showTosatWithText:dataArray.firstObject inView:self.view dismissAfterDelay:1];
                    }
                }];
            }
            else{
                [self.bottomTableView reloadData];
            }
        }
            break;
        case 4:
        {
            self.type = IKCompanyDetailVCTypeNeedJob;
            if (IKArrayIsEmpty(self.needJobArray)) {
                [[IKNetworkManager shareInstance] getCompanyPageNeedJobInfoWithParam:dict backData:^(NSArray *dataArray, BOOL success) {
                    if (success) {
                        self.needJobArray = [NSArray arrayWithArray:dataArray];
                        [self.bottomTableView reloadData];
                    }
                    else{
                        [LRToastView showTosatWithText:dataArray.firstObject inView:self.view dismissAfterDelay:1];
                    }
                }];
            }
            else{
                [self.bottomTableView reloadData];
            }
            break;
        }
            
        default:
            break;
    }
    
    
    if (!self.topTypeView.hidden) {
        _bottomTableView.contentOffset = CGPointMake(0, 118);
    }
}

- (void)showMoreButtonClick:(BOOL)isClickShowMore
{
    _showMore = isClickShowMore;
    
    [self.bottomTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (self.type) {
        case  IKCompanyDetailVCTypeAboutUs:
            return 4;
            break;
            
        case  IKCompanyDetailVCTypeManagerTeam:
        case  IKCompanyDetailVCTypeMultipleShop:
        case  IKCompanyDetailVCTypeNeedJob:
            return 2;
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f],NSParagraphStyleAttributeName:paragraphStyle};
        CGSize szie = [NSString getSizeWithString:_headModel.companyDescription size:CGSizeMake(IKSCREEN_WIDTH *0.893, MAXFLOAT) attribute:attributes];
        NSLog(@"size.height = %.0f",szie.height);
        if (szie.height < 44) {
            return 205;
        }
    
        return 130 + szie.height + 40;  //  多加10 好看
    }
    else{
        switch (self.type) {
            case IKCompanyDetailVCTypeAboutUs:
            {
                if (indexPath.section == 1){
                    if (indexPath.row == 0) {
                        return ceilf(IKSCREENH_HEIGHT * 0.2699);
                    }
                    else{
                        
                        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                        [paragraphStyle setLineSpacing:3];
                        
                        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f],NSParagraphStyleAttributeName:paragraphStyle};
                        
                        CGSize szie = [NSString getSizeWithString:_aboutUsModel.informationDetail size:CGSizeMake(IKSCREEN_WIDTH *0.893, MAXFLOAT) attribute:attributes];
                        
                        CGFloat titleH = ceilf(IKSCREENH_HEIGHT *0.06);
                        
                        if (szie.height < 50) {
                            _needShowMoreBtn = NO;
                            _infoCellH = 50 + titleH;
                            return _infoCellH;
                        }
                        else if(szie.height > 120){
                            
                            if (_showMore) {
                                _needShowMoreBtn = NO;
                                _infoCellH = titleH + szie.height + 60;
                                return _infoCellH;
                            }
                            else{
                                _needShowMoreBtn = YES;
                                _infoCellH = 120 + titleH;
                                return _infoCellH;
                            }
                        }
                        else{
                            _needShowMoreBtn = NO;
                            _infoCellH = titleH + szie.height + 20;
                            return _infoCellH;
                        }
                    }
                }
                else if (indexPath.section == 2){
                    if (indexPath.row == 0) {
                        return ceilf(IKSCREENH_HEIGHT *0.06);
                    }
                    else{
                        if (_aboutUsModel.progressList.count > 0) {
                            return ceilf(IKSCREENH_HEIGHT * 0.12);
                        }
                        else{
                            return 50;
                        }
                    }
                }
                else{
                    if (indexPath.row == 0) {
                        return ceilf(IKSCREENH_HEIGHT *0.06);
                    }
                    
                    // 地点
                    CGSize size = [NSString getSizeWithString:_aboutUsModel.workAddress size:CGSizeMake(IKSCREEN_WIDTH*0.67, MAXFLOAT) attribute:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}];
                    CGFloat h = size.height<18?18:size.height;
                    
                    return h + 50;
                }
            }
                break;
                
            case IKCompanyDetailVCTypeManagerTeam:
            {
                return ceilf(IKSCREENH_HEIGHT *0.345);
            }
                break;
                
            case IKCompanyDetailVCTypeNeedJob:{
                return (IKSCREEN_WIDTH * 0.2933);
            }
                break;
            case IKCompanyDetailVCTypeMultipleShop:{
                return (IKSCREENH_HEIGHT * 0.18);
            }
            default:
                break;
        }
        
    }
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 44;
    }
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else{
        switch (self.type) {
            case IKCompanyDetailVCTypeAboutUs:
            {
                if (section == 1) {
                    return 2;
                }
                else if (section == 2){
                    NSInteger count = _aboutUsModel.progressList.count;
                    
                    if (count>0 && count<4) {
                        return (count + 1); // 标题
                    }
                    else if (count >=4){
                        return 5; // 3 + 1 + 1  (标题 + 全部按钮)
                    }
                    else{
                        return 2;
                    }
                }
                else{
                    return 2;
                }
            }
                break;
                
            case IKCompanyDetailVCTypeManagerTeam:
            {
                return self.managerTeamArray.count;
            }
                break;
                
            case IKCompanyDetailVCTypeNeedJob:
            {
                return self.needJobArray.count;
            }
                break;
            case IKCompanyDetailVCTypeMultipleShop:
            {
                return self.shopTypeArray.count;
            }
            default:
                break;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        static  NSString *cellId=@"IKComDetailTopTableViewCellId";
        IKComDetailTopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKComDetailTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell cellAddData:_headModel];
        return cell;
    }
    else{
        switch (self.type) {
            case IKCompanyDetailVCTypeAboutUs:
            {
                if (section == 1 ){
                    if (row == 0) {
                        static  NSString *cellId=@"IKComDetailLoopTableViewCellId";
                        IKComDetailLoopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
                        
                        if(cell == nil){
                            cell = [[IKComDetailLoopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                        }
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.imageArray = _aboutUsModel.imageArray;
                        return cell;
                    }
                    else{
                        static  NSString *cellId=@"IKComInformationTableViewCellId";
                        IKComInformationTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
                        
                        if(cell == nil){
                            cell = [[IKComInformationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                        }
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.delegate = self;

                        if (_showMore) {
                            _needShowMoreBtn = NO;
                        }
                        [cell createSubViews:_aboutUsModel.informationDetail needShowMore:_needShowMoreBtn needClose:_showMore cellHeight:_infoCellH];

                        return cell;
                    }
                }
                else if (section == 2){
                    if (row == 0) {
                        static  NSString *cellId=@"IKCompanyDetailTitleTableViewCellId";
                        IKCompanyDetailTitleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
                        
                        if(cell == nil){
                            cell = [[IKCompanyDetailTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                        }
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.titleType = IKCompanyDetailTitleTypeProgress;
                        return cell;
                    }
                    else if (row == 4){
                        UITableViewCell *cell = [[UITableViewCell alloc] init];
                        
                        UIButton * allButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        [allButton setTitle:@"全部历程" forState:UIControlStateNormal];
                        [allButton setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
                        allButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
                        allButton.layer.cornerRadius = 6;
                        allButton.layer.borderColor = IKGeneralBlue.CGColor;
                        allButton.layer.borderWidth = 1;
                        [allButton addTarget:self action:@selector(allButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:allButton];
                        
                        [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.center.equalTo(cell.contentView);
                            make.width.mas_equalTo(80);
                            make.height.mas_equalTo(30);
                        }];
                        return cell;
                    }
                    else{
                        if (_aboutUsModel.progressList.count > 0) {
                            static  NSString *cellId=@"IKCompanyProgressTableViewCellId";
                            IKCompanyProgressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
                            
                            if(cell == nil){
                                cell = [[IKCompanyProgressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                            }
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            if (row < _aboutUsModel.progressList.count) {
                                if (row == 1) {
                                    [cell addProgressCellData:_aboutUsModel.progressList[0] showVerTopLine:NO showVerBottomLine:YES];
                                }
                                else if (row == 3){
                                    [cell addProgressCellData:_aboutUsModel.progressList[2] showVerTopLine:YES showVerBottomLine:NO];
                                }
                                else{
                                    [cell addProgressCellData:_aboutUsModel.progressList[1] showVerTopLine:YES showVerBottomLine:YES];
                                }
                            }
                            return cell;
                        }
                        else{
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            UILabel *title = [[UILabel alloc] init];
                            title.font = [UIFont systemFontOfSize:IKSubTitleFont];
                            title.textColor = IKSubHeadTitleColor;
                            title.textAlignment = NSTextAlignmentCenter;
                            title.text = @"暂无发展历程";
                            [cell.contentView addSubview:title];
                            
                            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.edges.equalTo(cell.contentView);
                                make.width.and.height.equalTo(cell.contentView);
                            }];
                            return cell;
                        }
                    }
                }
                else{
                    if (row == 0) {
                        static  NSString *cellId=@"IKCompanyDetailTitleTableViewCellId";
                        IKCompanyDetailTitleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
                        
                        if(cell == nil){
                            cell = [[IKCompanyDetailTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                        }
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.titleType = IKCompanyDetailTitleTypeLocation;
                        return cell;
                    }
                    else{
                        // 地点
                        static  NSString *cellId=@"IKWorkAddressTableViewCellId";
                        IKWorkAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                        
                        if(cell == nil){
                            cell = [[IKWorkAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                        }
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.shopName = _aboutUsModel.cityName;
                        cell.shopAddress = _aboutUsModel.workAddress;
                        return cell;
                    }
                }
            }
                break;
            case IKCompanyDetailVCTypeManagerTeam:
            {
                if (row%2 == 0) {
                    static  NSString *cellId=@"IKManagerTeamLeftTableViewCellId";
                    IKManagerTeamLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                    
                    if(cell == nil){
                        cell = [[IKManagerTeamLeftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell managerTeamCellAddData:[self.managerTeamArray objectAtIndex:row]];
                    return cell;
                }
                else{
                    static  NSString *cellId=@"IKManagerTeamRightTableViewCellId";
                    IKManagerTeamRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                    
                    if(cell == nil){
                        cell = [[IKManagerTeamRightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell managerTeamCellAddData:[self.managerTeamArray objectAtIndex:row]];

                    return cell;
                }
            }
                break;
            case IKCompanyDetailVCTypeMultipleShop:
            {
                static  NSString *cellId=@"IKCompanyShopTableViewCellId";
                IKCompanyShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                
                if(cell == nil){
                    cell = [[IKCompanyShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (row < self.shopTypeArray.count) {
                    [cell addCompanyShopCellData:self.shopTypeArray[row]];
                }
                
                return cell;
                
            }
                break;
                
            case IKCompanyDetailVCTypeNeedJob:
            {
                static  NSString *cellId = @"IKInfoTableViewCellId";
                IKInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                
                if(cell == nil){
                    cell = [[IKInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    
                }
                cell.backgroundColor = [UIColor whiteColor];
                cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
                
                if (indexPath.row < self.needJobArray.count) {
                    [cell addCellData:self.needJobArray[indexPath.row]];
                }
                return cell;
            }
                break;
                
            default:
                break;
        }
        
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 4) {
//        return 8;
//    }
//    return 0.01;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    }
    else if (section == 1 && self.type == IKCompanyDetailVCTypeAboutUs){
        return 8;
    }
    else if (section == 2 && self.type == IKCompanyDetailVCTypeAboutUs){
        
        CGFloat count = _aboutUsModel.progressList.count;
        
        if (  count > 0 && count <4) {
            return 28;
        }
        else{
            return 8;
        }
    }
    
    return 0.01;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        return self.jobTypeView;
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGFloat count = _aboutUsModel.progressList.count;

    if (section == 2 && self.type == IKCompanyDetailVCTypeAboutUs && count > 0 && count < 4) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *wView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 20)];
        wView.backgroundColor = [UIColor whiteColor];
        [view addSubview:wView];
        
        UIView *gView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, IKSCREEN_WIDTH, 8)];
        gView.backgroundColor = IKGeneralLightGray;
        [view addSubview:gView];
        
        return view;
    }
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 1) {
        
        switch (self.type) {
            case IKCompanyDetailVCTypeNeedJob:
            {
                IKJobInfoModel *model = [self.needJobArray objectAtIndex:indexPath.row];
                IKJobDetailVC *vc = [[IKJobDetailVC alloc] init];
                vc.jobModel = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case IKCompanyDetailVCTypeAboutUs:
            {
            
            }
                break;
            case IKCompanyDetailVCTypeManagerTeam:
            {
                IKCompanyManagerTeamModel *model = [self.managerTeamArray objectAtIndex:indexPath.row];
                NSLog(@"hhhahahahahaha");
                
                IKTeamDeatilView *deatil = [[IKTeamDeatilView alloc] initWithName:model.name message:model.describe position:model.workPosition];
                [deatil show];
            }
                break;
            case IKCompanyDetailVCTypeMultipleShop:
            {
                
                switch ([_headModel.companyType integerValue]) {
                    case 1:
                    {
                        IKShopDetailView *detail = [[IKShopDetailView alloc] initWithShopDetailModel:[self.shopTypeArray objectAtIndex:indexPath.row]];
                        detail.delegate = self;
                        [detail show];
                        break;
                    }
                    case 2:

                        break;
                    case 3:

                        break;
                        
                    default:
                        break;
                }
            }
                break;
            default:
                break;
        }
    }
}

- (void)showShopListWithShopID:(NSString *)shopId companyID:(NSString *)companyID
{
    NSLog(@"shopId = %@",shopId);
    
    IKShopListViewController *shopList = [[IKShopListViewController alloc] init];
    
    shopList.dataDict = @{@"shopId":shopId,@"companyId":companyID};
    
    [self.navigationController pushViewController:shopList animated:YES];
}


- (void)allButtonClick:(UIButton *)button
{
    NSLog(@"allButtonClick:");
    
    IKCompanyProgressVC *progress = [[IKCompanyProgressVC alloc] init];
    progress.progressArray = _aboutUsModel.progressList;
    [self.navigationController pushViewController:progress animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _bottomTableView) {
        
        CGFloat offsetY = scrollView.contentOffset.y;
        NSLog(@"offsetY = %.0f",offsetY);

        if (offsetY > -24) {
            _topNameLabel.hidden = NO;
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _topNameLabel.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
            
            }];
        }
        else{
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _topNameLabel.transform = CGAffineTransformMakeTranslation(0, 44);
            } completion:^(BOOL finished) {
                _topNameLabel.hidden = YES;
            }];
        }
        
        // - 144 = 64(nav) + 80 (logo)
        if (offsetY > -144) {
            _navImageView.hidden = NO;
        }
        else{
            _navImageView.hidden = YES;
        }
        
        if (offsetY > -64) {
            _navScrollVIew.contentOffset = CGPointMake(0, _imageH - 64);
        }
        else if (offsetY <= -64 && offsetY >= -_imageH){
            _navScrollVIew.contentOffset = CGPointMake(0, _imageH + offsetY);
        }
        else{
            CGRect navImageFrame = _navImageView.frame;
            navImageFrame.size.height = -1*offsetY;
            _navImageView.frame = navImageFrame;
        }
        
        // top Image 放大效果
        if(offsetY < -_imageH) {
            CGRect currentFrame = _headImageView.frame;
            currentFrame.origin.y = offsetY;
            currentFrame.size.height = -1*offsetY;
            _headImageView.frame = currentFrame;
        }
        
        
        if (offsetY > 118) {
            [self.topTypeView adjustBottomLine:_selectType];
            self.topTypeView.hidden = NO;
        }
        else{
            self.topTypeView.hidden = YES;
            [self.jobTypeView adjustBottomLine:self.selectType];
        }
    }
    


    
}

- (void)addStarToAppraiseView:(NSInteger )evaluate
{
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(8 + (14 + 3) * i, 44, 14, 14)];

        if (i < evaluate) {
            [image setImage:[UIImage imageNamed:@"IK_star_solid_red"]];
        }
        else{
            [image setImage:[UIImage imageNamed:@"IK_star_hollow_red"]];
        }
        [_appraiseView addSubview:image];
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
