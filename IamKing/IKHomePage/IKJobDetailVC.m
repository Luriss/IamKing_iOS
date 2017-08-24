//
//  IKJobDetailVC.m
//  IamKing
//
//  Created by Luris on 2017/7/25.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobDetailVC.h"
#import "IKNoDataBgView.h"
#import "IKTableView.h"
#import "IKJobDetailModel.h"
#import "IKJobDetailTopTableViewCell.h"
#import "IKJobDetailCompanyTableViewCell.h"
#import "IKDetailTitleTableViewCell.h"
#import "IKRespRequireTableViewCell.h"
#import "IKWorkAddressTableViewCell.h"
#import "IKSkillTableViewCell.h"
#import "IKFeedbackTableViewCell.h"
#import "IKAlertView.h"
#import "IKCompanyDetailVC.h"


@interface IKJobDetailVC ()<UITableViewDelegate,UITableViewDataSource,IKAlertViewDelegate>
{
    BOOL needShowSkillSection;
}
@property(nonatomic,strong)IKNoDataBgView   *noDataBgView;
@property(nonatomic,strong)IKTableView      *bgTableView;
@property(nonatomic,strong)IKJobDetailModel *jobDetailModel;


@end

@implementation IKJobDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLeftBackItem];
    [self initNavTitle];
    
    [self initBottomView];
    

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // no data bg view.
    NSLog(@"viewWillAppear = %@",_bgTableView);
    _bgTableView.scrollEnabled = YES;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSLog(@"viewWillDisappear = ");
    
    _bgTableView.scrollEnabled = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)dealloc
{
    [self removeBgTableView];
}

- (void)removeBgTableView
{
    if (self.bgTableView) {
        [self.bgTableView removeFromSuperview];
        self.bgTableView = nil;
    }
}

- (void)setJobModel:(IKJobInfoModel *)jobModel
{
    if (jobModel != nil) {
        _jobModel = jobModel;
        [self removeBgTableView];

        // 获取职位详情信息
        [[IKNetworkManager shareInstance] getHomePageJobInfoDetailWithParam:@{@"inviteWorkId":jobModel.jobID} backData:^(IKJobDetailModel *detailModel, BOOL success) {
            NSLog(@"detailModel = %@",detailModel.description);

            [self.noDataBgView removeFromSuperview];
            self.noDataBgView = nil;
//
            if (success) {
                if (detailModel) {
                    _jobDetailModel = detailModel;
                    
                    // 如果有技能标签,则需要增加 section.
                    if (_jobDetailModel.tagsList.count > 0) {
                        needShowSkillSection = YES;
                    }
                    else{
                        needShowSkillSection = NO;
                    }
                    
                    NSLog(@"1111  =%@",_bgTableView);
                    if (_bgTableView == nil) {
                        [self.view insertSubview:self.bgTableView atIndex:0];
                    }
                }
            }
            else{

                NSString *str = [NSString stringWithFormat:@"%@,即将退出",detailModel.errorMsg];
                [LRToastView showTosatWithText:str inView:self.view];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self backButtonClick:nil];
                });
            }
            
        }];
    }
}

- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"职位详情";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    self.navigationView.titleView = title;
    
}


- (void)initLeftBackItem
{
    // 返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 00, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 50);
    [button setImage:[UIImage imageNamed:@"IK_back_white"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_back_white"] forState:UIControlStateHighlighted];
    
    self.navigationView.leftButton = button;
    
    // 收藏
    UIButton *favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [favBtn addTarget:self action:@selector(favButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    favBtn.frame = CGRectMake(0, 00, 44, 44);
    favBtn.imageEdgeInsets = UIEdgeInsetsMake(11, 10, 11, 12);
    [favBtn setImage:[UIImage imageNamed:@"IK_star_hollow_White"] forState:UIControlStateNormal];
    [favBtn setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_star_hollow_White"] forState:UIControlStateHighlighted];
    
    self.navigationView.rightButton = favBtn;
    
    
    // 分享
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.frame = CGRectMake(0, 00, 44, 44);
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 22, 10, 0);
    [shareBtn setImage:[UIImage imageNamed:@"IK_share_white"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_share"] forState:UIControlStateHighlighted];
    
    self.navigationView.right2Button = shareBtn;
    
    
}

- (void)shareButtonClick:(UIButton *)button
{
    NSLog(@"shareButtonClick");
    
    [LRToastView showTosatWithText:@"敬请期待" inView:self.view];
}


- (void)favButtonClick:(UIButton *)button
{
    NSLog(@"favButtonClick");
    [LRToastView showTosatWithText:@"敬请期待" inView:self.view];

}


- (void)initBottomView
{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95f];
    [self.view addSubview:bottomView];
    [self.view bringSubviewToFront:bottomView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 1)];
    line.backgroundColor = IKLineColor;
    [bottomView addSubview:line];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setTitle:@"投递简历" forState:UIControlStateNormal];
    [sendButton setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
    [sendButton setTitleColor:IKColorFromRGB(0x00aaee) forState:UIControlStateHighlighted];
    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    sendButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    sendButton.layer.cornerRadius = 6;
    sendButton.layer.borderColor = IKGeneralBlue.CGColor;
    sendButton.layer.borderWidth = 1.0;
    [sendButton addTarget:self action:@selector(sendResumeClickDown:) forControlEvents:UIControlEventTouchDown];

    [sendButton addTarget:self action:@selector(sendResumeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sendButton];
    
    
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(10);
        make.left.equalTo(bottomView.mas_left).offset(20);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-10);
        make.width.equalTo(bottomView).multipliedBy(0.293);
    }];
    
    UIButton *chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chatButton setTitle:@"聊一聊" forState:UIControlStateNormal];
    [chatButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    chatButton.titleLabel.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    chatButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    chatButton.layer.cornerRadius = 6;
    chatButton.layer.masksToBounds = YES;
    chatButton.backgroundColor = IKGeneralBlue;
    [chatButton setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
    [chatButton addTarget:self action:@selector(chatButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [bottomView addSubview:chatButton];
    
    
    [chatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sendButton.mas_top);
        make.left.equalTo(sendButton.mas_right).offset(15);
        make.bottom.equalTo(sendButton.mas_bottom);
        make.right.equalTo(bottomView.mas_right).offset(-15);
    }];
}

- (void)sendResumeClickDown:(UIButton *)button
{
    button.layer.borderColor = IKColorFromRGB(0x00aaee).CGColor;
}

- (void)chatButtonClickDown:(UIButton *)button
{
    button.backgroundColor = IKColorFromRGB(0x00aaee);
}
- (void)sendResumeButtonClick:(UIButton *)button
{
    NSLog(@"sendButtonClick:");
    
    button.layer.borderColor = IKGeneralBlue.CGColor;
    
    IKAlertView *alert = [[IKAlertView alloc] initWithTitle:@"测试" message:@"这是测试信息这是测试信息这是测试信息这是测试信息这是测试信息这是测试信息这是测试信息这是测试信息这是测试信息这是测试信息这是测试信息这是测试信息这是测试信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(IKAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buuuu = %ld",buttonIndex);
}


- (void)chatButtonClick:(UIButton *)button
{
    NSLog(@"chatButtonClick:");
    button.backgroundColor = IKGeneralBlue;
}

- (IKNoDataBgView *)noDataBgView
{
    if (_noDataBgView == nil) {
        _noDataBgView = [[IKNoDataBgView alloc] initWithFrame:self.view.bounds];
    }
    return _noDataBgView;
}

- (IKTableView *)bgTableView
{
    if (_bgTableView == nil) {
        _bgTableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64 - 50) style:UITableViewStyleGrouped];
        _bgTableView.backgroundColor = IKGeneralLightGray;
//        _bgTableView.sectionFooterHeight = 1.0;
        _bgTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bgTableView.showsVerticalScrollIndicator = NO;
        _bgTableView.showsHorizontalScrollIndicator = NO;
        _bgTableView.delegate = self;
        _bgTableView.dataSource = self;
        _bgTableView.bounces = NO;
    }
    
    return _bgTableView;
}





#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  _jobDetailModel.numberOfSection + 1; // 多返回一个 空白 section,用于投递简历按钮
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (needShowSkillSection) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                CGSize szie = [NSString getSizeWithString:_jobDetailModel.temptation size:CGSizeMake(IKSCREEN_WIDTH *0.87, MAXFLOAT) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:14.0f]}];
                return 124 + szie.height;
            }
            else if (indexPath.row == 1){
                return 116;
            }
            else{
                return 0;
            }
        }
        else if (indexPath.section == 1){
            if (indexPath.row == 0) {
                return 41;
            }
            else if (indexPath.row == 1){ // 技能认证
                
                
                return 68 + _jobDetailModel.tagsList.count * 30; // 技能
            }
            else{
                return 0;
            }
        }
        else if (indexPath.section == 2){ // 职位详情
            if (indexPath.row == 0) {
                return 41; // 标题
            }
            else{
                // 职位要求
                if (indexPath.row == 1) {
                    CGSize size = [self getResponsibilityAndRequireCellHeight:_jobDetailModel.responsibility];
                    return size.height + 40;
                }
                else if (indexPath.row == 2){
                    CGSize size = [self getResponsibilityAndRequireCellHeight:_jobDetailModel.require];
                    return size.height + 40;
                }
                else{
                    return 0;
                }
            }
        }
        else if (indexPath.section == 3){ // 地点
            if (indexPath.row == 0) {
                return 41; // 标题
            }
            else{
                // 地点
                CGSize size = [NSString getSizeWithString:_jobDetailModel.workAddress size:CGSizeMake(IKSCREEN_WIDTH*0.67, MAXFLOAT) attribute:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}];
                CGFloat h = size.height<18?18:size.height;
                return h + 50;
            }
        }
        else if (indexPath.section == 4){ // 评价
            if (indexPath.row == 0) {
                return 41;
            }
            else{
                return [self getFeedbackCellHeight:indexPath];
            }
        }
        else{
            return 10;
        }
    }
    else{
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                CGSize szie = [NSString getSizeWithString:_jobDetailModel.temptation size:CGSizeMake(IKSCREEN_WIDTH *0.87, MAXFLOAT) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:14.0f]}];
                return 124 + szie.height;
            }
            else if (indexPath.row == 1){
                return 116;
            }
            else{
                return 0;
            }
        }
        else if (indexPath.section == 1){ // 职位详情
            if (indexPath.row == 0) {
                return 41;
            }
            else if (indexPath.row == 1){
                CGSize size = [self getResponsibilityAndRequireCellHeight:_jobDetailModel.responsibility];
                return size.height + 40; //职责
            }
            else{
                CGSize size = [self getResponsibilityAndRequireCellHeight:_jobDetailModel.require];
                return size.height + 40; //要求
            }
        }
        else if (indexPath.section == 2){ // 地点
            if (indexPath.row == 0) {
                return 41; // 标题
            }
            else{
                CGSize size = [NSString getSizeWithString:_jobDetailModel.workAddress size:CGSizeMake(IKSCREEN_WIDTH*0.67, MAXFLOAT) attribute:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}];
                CGFloat h = size.height<18?18:size.height;
                return h + 50;
            }
        }
        else if (indexPath.section == 3){ // 评价
            if (indexPath.row == 0) {
                return 41;
            }
            else if (indexPath.row == 1){
                return [self getFeedbackCellHeight:indexPath];
            }
        }
        else{
            return 10;
        }
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }

    return 4.9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (needShowSkillSection && section == 5) {
        return 6;
    }
    else if (!needShowSkillSection && section == 4){
        return 6;
    }
    else{
        return 1;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (needShowSkillSection) {
        if (section == 0) {
            return 2; // 公司
        }
        else if (section == 1){
            return 2; // 技能
        }
        else if (section == 2){
            return 3; // 职位
        }
        else if (section == 3){
            return 2; // 地点
        }
        else if (section == 4){
            NSInteger count = _jobDetailModel.feedback.count;
            return  count>0?(count+1):2; //评论 1 是标题  2.标题加无内容
        }
        else{
            return 1; // 空白row
        }
    }
    else{
        if (section == 0) {
            return 2; // 公司
        }
        else if (section == 1){
            return 3; // 职位
        }
        else if (section == 2){
            return 2; // 地点
        }
        else if (section == 3){
            NSInteger count = _jobDetailModel.feedback.count;
            return  count>0?(count+1):2; //评论 1 是标题  2.标题加无内容
        }
        else{
            return 1; // 空白 row
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static  NSString *cellId=@"IKJobDetailTopTableViewCellId";
            IKJobDetailTopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            
            if(cell == nil){
                cell = [[IKJobDetailTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell addCellData:_jobDetailModel];
            return cell;
        }
        else{
            static  NSString *cellId=@"IKJobDetailCompanyTableViewCellId";
            IKJobDetailCompanyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            
            if(cell == nil){
                cell = [[IKJobDetailCompanyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
            [cell addCompanyCellData:_jobDetailModel.companyInfo];
            return cell;
        }
    }
    else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            static  NSString *cellId=@"IKDetailTitleTableViewCellId";
            IKDetailTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if(cell == nil){
                cell = [[IKDetailTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (needShowSkillSection) {
                cell.titleType = IKDetailTitleTypeSkill;
            }
            else{
                cell.titleType = IKDetailTitleTypeResumeDetail;
            }
            return cell;
        }
        else{
            // 技能
            if (needShowSkillSection && indexPath.row == 1) {
                // 技能
                static  NSString *cellId=@"IKSkillTableViewCellId";
                IKSkillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                
                if(cell == nil){
                    cell = [[IKSkillTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell addSkillCellData:_jobDetailModel.tagsList];
                return cell;
            }
            else{
                // 职位要求
                static  NSString *cellId=@"IKRespRequireTableViewCellId";
                IKRespRequireTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                
                if(cell == nil){
                    cell = [[IKRespRequireTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (indexPath.row == 1){
                    cell.type = IKRespRequireTypeResp;
                    cell.content = _jobDetailModel.responsibility;
                }
                else{
                    cell.type = IKRespRequireTypeRequire;
                    cell.content = _jobDetailModel.require;
                }
                return cell;
            }
        }
    }
    else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            static  NSString *cellId=@"IKDetailTitleTableViewCellId";
            IKDetailTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if(cell == nil){
                cell = [[IKDetailTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (needShowSkillSection) {
                cell.titleType = IKDetailTitleTypeResumeDetail;
            }
            else{
                cell.titleType = IKDetailTitleTypeWorkAddress;
            }
            return cell;
        }
        else {
            // 职位要求
            if (needShowSkillSection) {
                static  NSString *cellId=@"IKRespRequireTableViewCellId";
                IKRespRequireTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                
                if(cell == nil){
                    cell = [[IKRespRequireTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (indexPath.row == 1){
                    cell.type = IKRespRequireTypeResp;
                    cell.content = _jobDetailModel.responsibility;
                }
                else{
                    cell.type = IKRespRequireTypeRequire;
                    cell.content = _jobDetailModel.require;
                }
                return cell;
            }
            else{
                // 地点
                static  NSString *cellId=@"IKWorkAddressTableViewCellId";
                IKWorkAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                
                if(cell == nil){
                    cell = [[IKWorkAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
                cell.shopName = _jobDetailModel.shopName;
                cell.shopAddress = _jobDetailModel.workAddress;
                return cell;
            }
        }
    }
    else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            static  NSString *cellId=@"IKDetailTitleTableViewCellId";
            IKDetailTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if(cell == nil){
                cell = [[IKDetailTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (needShowSkillSection) {
                cell.titleType = IKDetailTitleTypeWorkAddress;
            }
            else{
                cell.titleType = IKDetailTitleTypeInterViewAssessment;
            }
            return cell;
        }
        else{
            if (needShowSkillSection) {
                // 地点
                static  NSString *cellId=@"IKWorkAddressTableViewCellId";
                IKWorkAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                
                if(cell == nil){
                    cell = [[IKWorkAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
                cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
                cell.shopName = _jobDetailModel.shopName;
                cell.shopAddress = _jobDetailModel.workAddress;
                return cell;
            }
            else{
                // 评价
                static  NSString *cellId=@"IKFeedbackTableViewCellId";
                IKFeedbackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                BOOL noData = _jobDetailModel.feedback.count>0?NO:YES;

                if(cell == nil){
                    cell = [[IKFeedbackTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId noData: noData];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (!noData) {
                    [cell addFeedbackCellData:[_jobDetailModel.feedback objectAtIndex:indexPath.row - 1]];  // -1 是减去标题 row.
                }
                
                if (indexPath.row == _jobDetailModel.feedback.count) {
                    cell.showBottomLine = NO;
                }
                else{
                    cell.showBottomLine = YES;
                }
                
                return cell;
            }
        }
    }
    else if (indexPath.section == 4 && needShowSkillSection){
        if (indexPath.row == 0) {
            static  NSString *cellId=@"IKDetailTitleTableViewCellId";
            IKDetailTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if(cell == nil){
                cell = [[IKDetailTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleType = IKDetailTitleTypeInterViewAssessment;
            return cell;
        }
        else{
            // 评价
            static  NSString *cellId=@"IKFeedbackTableViewCellId";
            IKFeedbackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            BOOL noData = _jobDetailModel.feedback.count>0?NO:YES;
            if(cell == nil){
                cell = [[IKFeedbackTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId noData:noData];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (!noData) {
                [cell addFeedbackCellData:[_jobDetailModel.feedback objectAtIndex:indexPath.row - 1]];  // -1 是减去标题 row.
            }
            
            if (indexPath.row == _jobDetailModel.feedback.count) {
                cell.showBottomLine = NO;
            }
            else{
                cell.showBottomLine = YES;
            }
            
            return cell;
        }
    }
    else{
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0 && indexPath.row == 1) {

//        IKCompanyInfoModel *model = self.dataArray[indexPath.row];
        
        NSLog(@"description = %@",_jobDetailModel.description);
        IKCompanyDetailVC *companyDetail = [[IKCompanyDetailVC alloc] init];
        
        IKCompanyInfoModel *companyInfoModel = [[IKCompanyInfoModel alloc] init];
        companyInfoModel.companyID = [_jobDetailModel.companyInfo objectForKey:@"id"];
        companyDetail.companyInfoModel = companyInfoModel;
        [self.navigationController pushViewController:companyDetail animated:YES];
    }
    else if (indexPath.section == 2 && indexPath.row == 1 && !needShowSkillSection){
        NSLog(@"hahahahah");
    }
    else if (indexPath.section == 3 && indexPath.row == 1 && needShowSkillSection){
        NSLog(@"hahahahah");

    }
    
}


- (CGSize )getResponsibilityAndRequireCellHeight:(NSString *)string
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5.0;
    CGSize szie = [NSString getSizeWithString:string size:CGSizeMake(IKSCREEN_WIDTH - 40, MAXFLOAT) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:12.0f],NSParagraphStyleAttributeName:style}];
    return szie;
}

- (CGFloat)getFeedbackCellHeight:(NSIndexPath *)indexPath
{
    if (_jobDetailModel.feedback.count > 0) {
        CGFloat h = 110;
        NSDictionary *dict = (NSDictionary *)[_jobDetailModel.feedback objectAtIndex:(indexPath.row -1)];
        if (IKStringIsNotEmpty([dict objectForKey:@"tag_str"])) {
            h += 25;
        }
        
        NSString *content = [dict objectForKey:@"content"];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 3.0;
        
        CGSize size = [NSString getSizeWithString:content size:CGSizeMake(IKSCREEN_WIDTH * 0.76, MAXFLOAT) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:13.0f],NSParagraphStyleAttributeName:style}];
        
        NSLog(@"hhhhhhhhhh = %.0f",h + size.height);
        return h + size.height;
    }
    else{
        return 60;
    }
}

- (void)backButtonClick:(UIButton *)back
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
