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


@interface IKCompanyDetailVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,IKComDetailTypeTableViewCellDelegate,IKComInformationTableViewCellDelegate>
{
    CGFloat _imageH;
    CGFloat _infoCellH;
}

@property(nonatomic,strong)IKTableView      *bottomTableView;
@property(nonatomic,strong)IKScrollView      *navScrollVIew;
@property(nonatomic,strong)IKCompanyDetailHeadModel      *headModel;
@property(nonatomic,strong)IKCompanyAboutUsModel      *aboutUsModel;

@property(nonatomic,assign)IKCompanyDetailVCType       type;

@property(nonatomic,strong)UILabel      *titleLabel;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIImageView *navImageView;
@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)UIImage      *bulrImage;
@property(nonatomic,strong)UIButton      *attentionBtn;

@property(nonatomic,strong)NSArray      *managerTeamArray;
@property(nonatomic,strong)NSArray      *needJobArray;
@property(nonatomic,strong)NSArray      *shopTypeArray;

@property(nonatomic,assign)BOOL       needShowMoreBtn;
@property(nonatomic,assign)BOOL       showMore;
@property(nonatomic,assign)BOOL       firstComeIn;


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
    
    [self.view addSubview:self.bottomTableView];
    
    [self initNavScrollView];
    [self initLeftBackItem];
    [self initTitleLabel];
    _imageH = ceilf(IKSCREENH_HEIGHT *0.255);
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.bottomTableView.contentOffset = CGPointMake(0, -ceilf(IKSCREENH_HEIGHT *0.255));
    _showMore = NO;
    _needShowMoreBtn = NO;
    self.type = IKCompanyDetailVCTypeAboutUs;
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




- (IKTableView *)bottomTableView
{
    if (_bottomTableView == nil) {
        _bottomTableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT) style:UITableViewStylePlain];
        _bottomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bottomTableView.backgroundColor = IKGeneralLightGray;
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        _bottomTableView.bounces = YES;
        
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

- (UIImageView *)headImageView
{
    if (_headImageView == nil) {
        CGFloat height = ceilf(IKSCREENH_HEIGHT *0.255);
        
        _headImageView = [[UIImageView alloc] init];
        _headImageView.frame = CGRectMake(0, -height, CGRectGetWidth(self.view.bounds), height);
        
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
        _headImageView.userInteractionEnabled = YES;
        
        self.bottomTableView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
        [self.bottomTableView addSubview:_headImageView];
        
//        UIView *view = [[UIView alloc] initWithFrame:_headImageView.frame];
//        view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
//        [self.bottomTableView insertSubview:view aboveSubview:_headImageView];
        
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
            _headModel = detailModel;
            _titleLabel.text = _headModel.nickName;

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
            
            
            
        }];
        
        
    }
}

- (void)setTopHeaderData:(IKCompanyDetailHeadModel *)model
{
    
}




- (void)initTitleLabel
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 50, 20, 100, 44)];
    _titleLabel.backgroundColor = [UIColor redColor];
            _titleLabel.text = @"鼎盛健身";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    //        _titleLabel.transform = CGAffineTransformMakeTranslation(0, 44);
//    _titleLabel.hidden = NO;
    
    [self.view insertSubview:_titleLabel aboveSubview:_navScrollVIew];
    
    NSLog(@"subviews = %@",self.view.subviews);
}

- (void)typeButtonClick:(UIButton *)button
{
    NSLog(@"tag = %ld",button.tag);
    NSDictionary *dict = @{@"userCompanyId":_companyInfoModel.companyID,@"companyType":_headModel.companyType};

    switch (button.tag - 1000) {
        case 1:
            self.type = IKCompanyDetailVCTypeAboutUs;
            break;
        case 2:
        {
            self.type = IKCompanyDetailVCTypeManagerTeam;

            if (IKArrayIsEmpty(self.managerTeamArray)) {
                [[IKNetworkManager shareInstance] getCompanyPageManagerTeamInfoWithParam:dict backData:^(NSArray *dataArray, BOOL success) {
                    self.managerTeamArray = [NSArray arrayWithArray:dataArray];
                    [self.bottomTableView reloadData];
                }];
            }
        }
            break;
        case 3:
        {
            self.type = IKCompanyDetailVCTypeMultipleShop;
            if (IKArrayIsEmpty(self.shopTypeArray)) {
                [[IKNetworkManager shareInstance] getCompanyPageShopNumberInfoWithParam:dict backData:^(NSArray *dataArray, BOOL success) {
                    self.shopTypeArray = [NSArray arrayWithArray:dataArray];
                    [self.bottomTableView reloadData];
                }];
            }
        }
            break;
        case 4:
        {
            self.type = IKCompanyDetailVCTypeNeedJob;
            if (IKArrayIsEmpty(self.needJobArray)) {
                [[IKNetworkManager shareInstance] getCompanyPageNeedJobInfoWithParam:dict backData:^(NSArray *dataArray, BOOL success) {
                    self.needJobArray = [NSArray arrayWithArray:dataArray];
                    [self.bottomTableView reloadData];
                }];
            }
            
        }
            break;
            
        default:
            break;
    }
    
    [self.bottomTableView reloadData];
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
            return 5;
            break;
            
        case  IKCompanyDetailVCTypeManagerTeam:
        case  IKCompanyDetailVCTypeMultipleShop:
        case  IKCompanyDetailVCTypeNeedJob:
            return 3;
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGSize szie = [NSString getSizeWithString:_headModel.companyDescription size:CGSizeMake(IKSCREEN_WIDTH *0.893, MAXFLOAT) attribute:@{NSFontAttributeName : [UIFont systemFontOfSize:13.0f]}];
        NSLog(@"size.height = %.0f",szie.height);
        if (szie.height < 44) {
            return 175;
        }
        return 130 + szie.height + 10;  //  多加10 好看
    }
    else if (indexPath.section == 1){
        return 46;
    }
    else{
        switch (self.type) {
            case IKCompanyDetailVCTypeAboutUs:
            {
                if (indexPath.section == 2){
                    if (indexPath.row == 0) {
                        return ceilf(IKSCREENH_HEIGHT * 0.2699);
                    }
                    else{
                        CGSize szie = [NSString getSizeWithString:_aboutUsModel.informationDetail size:CGSizeMake(IKSCREEN_WIDTH *0.893, MAXFLOAT) attribute:@{NSFontAttributeName : [UIFont systemFontOfSize:13.0f]}];
                        
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
                else if (indexPath.section == 3){
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 1;
    }
    else{
        switch (self.type) {
            case IKCompanyDetailVCTypeAboutUs:
            {
                if (section == 2) {
                    return 2;
                }
                else if (section == 3){
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
    else if (section == 1){
        
        static  NSString *cellId=@"IKComDetailTypeTableViewCellId";
        IKComDetailTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKComDetailTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.companyType = _headModel.companyType;
        if (_firstComeIn) {
            cell.needResetSelectedButton = YES;
            _firstComeIn = NO;
        }
        return cell;
    }
    else{
        switch (self.type) {
            case IKCompanyDetailVCTypeAboutUs:
            {
                if (section == 2 ){
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
                else if (section == 3){
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
                        allButton.layer.cornerRadius = 5;
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
                            NSLog(@"indexPath.row = %ld",indexPath.row);
                            if (row < _aboutUsModel.progressList.count) {
                                if (row == 1) {
                                    [cell addProgressCellData:_aboutUsModel.progressList[1] showVerTopLine:NO showVerBottomLine:YES];
                                }
                                else if (row == 3){
                                    [cell addProgressCellData:_aboutUsModel.progressList[3] showVerTopLine:YES showVerBottomLine:NO];
                                }
                                else{
                                    [cell addProgressCellData:_aboutUsModel.progressList[2] showVerTopLine:YES showVerBottomLine:YES];
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
                static  NSString *cellId = @"IKCompanyNeedJobTableViewCellId";
                IKCompanyNeedJobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                
                if(cell == nil){
                    cell = [[IKCompanyNeedJobTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    
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
    else if (section == 2 && self.type != IKCompanyDetailVCTypeAboutUs){
        return 0.01;
    }
    else if (section == 3 && self.type == IKCompanyDetailVCTypeAboutUs){
        
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

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGFloat count = _aboutUsModel.progressList.count;

    if (section == 3 && self.type == IKCompanyDetailVCTypeAboutUs && count > 0 && count < 4) {
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
        
        if (offsetY > -20) {
            _titleLabel.hidden = NO;

            _titleLabel.transform = CGAffineTransformIdentity;
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
        
        if (offsetY > -15) {
            [_navScrollVIew insertSubview:_titleLabel aboveSubview:_navImageView];
        }
        
        if (offsetY < - 20) {
            [_titleLabel removeFromSuperview];
        }
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
