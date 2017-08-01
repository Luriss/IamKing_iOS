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

@interface IKCompanyDetailVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,IKComDetailTypeTableViewCellDelegate,IKComInformationTableViewCellDelegate>
{
    CGFloat _imageH;
}

@property(nonatomic,strong)IKTableView      *bottomTableView;
@property(nonatomic,strong)IKScrollView      *navScrollVIew;

@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIImageView *navImageView;
@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)UIImage      *bulrImage;
@property(nonatomic,strong)UILabel      *titleLabel;
@property(nonatomic,strong)IKCompanyDetailHeadModel      *headModel;
@property(nonatomic,strong)IKCompanyAboutUsModel      *aboutUsModel;
@property(nonatomic,assign)IKCompanyDetailVCType       type;
@property(nonatomic,assign)BOOL       needShowMoreBtn;
@property(nonatomic,assign)BOOL       showMore;


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
    
    _imageH = ceilf(IKSCREENH_HEIGHT *0.255);
    [self initNavTitle];
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
    self.headImageView.image = nil;
    self.navImageView.image = nil;
    _showMore = NO;
    _needShowMoreBtn = NO;
}

- (void)initLeftBackItem
{
    // 返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(companyDetailVcDismissSelf) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(15, 20, 44, 44);
//    button.backgroundColor = [UIColor redColor];
    button.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 24);
    [button setImage:[UIImage imageNamed:@"IK_back"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_back"] forState:UIControlStateHighlighted];
    
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
        [self.bottomTableView addSubview:self.headImageView];

    }
    return _headImageView;
}


- (void)setCompanyInfoModel:(IKCompanyInfoModel *)companyInfoModel
{
    if (companyInfoModel) {
        _companyInfoModel = companyInfoModel;
        
        NSDictionary *dict = @{@"userCompanyId":companyInfoModel.companyID};
        
        [[IKNetworkManager shareInstance]getCompanyPageCompanyInfoDetailWithParam:dict backData:^(IKCompanyDetailHeadModel *detailModel, BOOL success) {
            NSLog(@"description = %@",detailModel.description);
            _headModel = detailModel;
            
            [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.logoImageUrl ] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.logoImageView.image = image;
                    self.bulrImage = [UIImage boxblurImage:image withBlurNumber:1.2];
                    self.headImageView.image = self.bulrImage;
                    self.navImageView.image = self.bulrImage;
                    
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
                        [self.bottomTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
                    }];
                });
            }
            
            
            
        }];
        
        
    }
}

- (void)setTopHeaderData:(IKCompanyDetailHeadModel *)model
{
    
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 50, 250, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"鼎盛健身";
    title.textColor = IKMainTitleColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
//    self.navigationItem.titleView = title;
    
    _titleLabel = title;
}

- (void)typeButtonClick:(UIButton *)button
{
    NSLog(@"tag = %ld",button.tag);
    switch (button.tag - 1000) {
        case 1:
            self.type = IKCompanyDetailVCTypeAboutUs;
            break;
        case 2:
            self.type = IKCompanyDetailVCTypeManagerTeam;
            break;
        case 3:
            self.type = IKCompanyDetailVCTypeMultipleShop;
            break;
        case 4:
            self.type = IKCompanyDetailVCTypeNeedJob;
            break;
            
        default:
            break;
    }
    
    [self.bottomTableView reloadData];
}

- (void)showMoreButtonClick:(UIButton *)button
{
    _showMore = YES;
    
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
    else if (indexPath.section == 2){
        
        switch (self.type) {
            case IKCompanyDetailVCTypeAboutUs:
            {
                if (indexPath.row == 0) {
                    return ceilf(IKSCREENH_HEIGHT * 0.2699);
                }
                else{
                    CGSize szie = [NSString getSizeWithString:_aboutUsModel.informationDetail size:CGSizeMake(IKSCREEN_WIDTH *0.893, MAXFLOAT) attribute:@{NSFontAttributeName : [UIFont systemFontOfSize:13.0f]}];
                    
                    CGFloat titleH = ceilf(IKSCREENH_HEIGHT *0.06);
                    
                    if (szie.height < 50) {
                        return 50 + titleH;
                        _needShowMoreBtn = NO;
                    }
                    else if(szie.height > 120){
                        
                        if (_showMore) {
                            _needShowMoreBtn = NO;
                            return titleH + szie.height + 60;
                        }
                        else{
                            _needShowMoreBtn = YES;
                            return 120 + titleH;
                        }
                    }
                    else{
                        _needShowMoreBtn = NO;
                        return titleH + szie.height + 20;
                    }
            }
                break;
                
            case IKCompanyDetailVCTypeManagerTeam:
                {
                    return 40;
                }
                break;
                
            case IKCompanyDetailVCTypeNeedJob:{
                return 40;
            }
                break;
            case IKCompanyDetailVCTypeMultipleShop:{
                return 40;
            }
            default:
                break;
        }
        }
    }
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 1;
    }
    else if (section == 2){
        
        return 2;
    }
    else{
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
        
        [cell cellAddData:_headModel];
        return cell;
    }
    else if (indexPath.section == 1){
        
        static  NSString *cellId=@"IKComDetailTypeTableViewCellId";
        IKComDetailTypeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKComDetailTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    else{
        switch (self.type) {
            case IKCompanyDetailVCTypeAboutUs:
            {
                if (indexPath.section == 2 ){
                    if (indexPath.row == 0) {
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
                        if (_needShowMoreBtn) {
                            cell.needShowMoreBtn = YES;
                        }
                        else{
                            cell.needShowMoreBtn = NO;
                        }
                        
                        
                        cell.content = _aboutUsModel.informationDetail;
                        return cell;
                    }
                }                
            }
                break;
            case IKCompanyDetailVCTypeManagerTeam:
            {
                UITableViewCell *cell = [[UITableViewCell alloc] init];
                return cell;
            }
                break;
            case IKCompanyDetailVCTypeMultipleShop:
            {
                UITableViewCell *cell = [[UITableViewCell alloc] init];
                return cell;
            }
                break;
                
            case IKCompanyDetailVCTypeNeedJob:
            {
                UITableViewCell *cell = [[UITableViewCell alloc] init];
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
////    if (section == 1) {
////        return 4;
////    }
//    return 0.01;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    }
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _bottomTableView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        
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
