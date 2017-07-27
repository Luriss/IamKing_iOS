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


@interface IKJobDetailVC ()<UITableViewDelegate,UITableViewDataSource>
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
        
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 1)];
    view.backgroundColor = IKLineColor;
    [self.view addSubview:view];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // no data bg view.
    NSLog(@"_bgTableView = %@",_bgTableView);
    if (_bgTableView == nil) {
        [self.view addSubview:self.noDataBgView];
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
            
            _jobDetailModel = detailModel;
            
            // 如果有技能标签,则需要增加 section.
            if (_jobDetailModel.tagsList.count > 0) {
                needShowSkillSection = YES;
            }
            else{
                needShowSkillSection = NO;
            }
            
            [self.noDataBgView removeFromSuperview];
            self.noDataBgView = nil;
            
            NSLog(@"1111  =%@",_bgTableView);
            if (_bgTableView == nil) {
                [self.view addSubview:self.bgTableView];
            }
        }];
    }
}

- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"职位详情";
    title.textColor = IKMainTitleColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    self.navigationItem.titleView = title;
    
}


- (void)initLeftBackItem
{
    // 返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 00, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 50);
    [button setImage:[UIImage imageNamed:@"IK_back"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_back"] forState:UIControlStateHighlighted];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
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
        _bgTableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 1, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64 - 50) style:UITableViewStyleGrouped];
        _bgTableView.backgroundColor = IKGeneralLightGray;
//        _bgTableView.sectionFooterHeight = 1.0;
        _bgTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bgTableView.showsVerticalScrollIndicator = NO;
        _bgTableView.showsHorizontalScrollIndicator = NO;
        _bgTableView.delegate = self;
        _bgTableView.dataSource = self;
    }
    
    return _bgTableView;
}





#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  _jobDetailModel.numberOfSection;
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
            else if (indexPath.row == 1){
                if (_jobDetailModel.feedback.count > 0) {
                    return 100;
                }
                else{
                    return 60;
                }
            }
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
                if (_jobDetailModel.feedback.count > 0) {
                    return 100;
                }
                else{
                    return 60;
                }
            }
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
    if (needShowSkillSection && section == 4) {
        return 6;
    }
    else if (!needShowSkillSection && section == 3){
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
            return 2; //评论
        }
        else{
            return 0;
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
            return 2; // 评论
        }
        else{
            return 0;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.shopName = _jobDetailModel.shopName;
                cell.shopAddress = _jobDetailModel.workAddress;
                return cell;
            }
            else{
                // 地点
                static  NSString *cellId=@"IKFeedbackTableViewCellId";
                IKFeedbackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                
                if(cell == nil){
                    cell = [[IKFeedbackTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId noData:YES];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
    }
    else if (indexPath.section == 4){
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
            // 地点
            static  NSString *cellId=@"IKFeedbackTableViewCellId";
            IKFeedbackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if(cell == nil){
                cell = [[IKFeedbackTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId noData:YES];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        UIViewController *v = [[UIViewController alloc] init];
        v.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:v animated:YES];
    }
    
}


- (CGSize )getResponsibilityAndRequireCellHeight:(NSString *)string
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5.0;
    CGSize szie = [NSString getSizeWithString:string size:CGSizeMake(IKSCREEN_WIDTH - 40, MAXFLOAT) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:12.0f],NSParagraphStyleAttributeName:style}];
    return szie;
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
