//
//  IKJobProcessVc.m
//  IamKing
//
//  Created by Luris on 2017/8/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobProcessVc.h"
#import "IKJobProcessHeaderTableViewCell.h"
#import "IKJobDetailCompanyTableViewCell.h"
#import "IKJobProcessModel.h"
#import "IKJobProcessButtonTableViewCell.h"
#import "IKCompanyDetailVC.h"
#import "IKChatViewController.h"
#import "IKInterviewInfoView.h"
#import "IKEditInterviewAppraiseVc.h"


extern NSString * loginUserId;

@interface IKJobProcessVc ()<UITableViewDelegate,UITableViewDataSource,IKJobProcessButtonCellDelegate,IKInterviewInfoViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray     *dataArray;

@end

@implementation IKJobProcessVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavTitle];
    [self initLeftBackItem];
    
    // Do any additional setup after loading the view.
    
    [[IKNetworkManager shareInstance] getJobProcessDataWithParam:@{@"page":@"1",@"pageSize":@"16",@"userId":loginUserId} backData:^(NSArray *dataArray, BOOL success) {
        if (success && dataArray.count > 0) {
            self.dataArray = [NSMutableArray arrayWithArray:dataArray];
            NSLog(@"dataArray = %@",self.dataArray);
            [self.view addSubview:self.tableView];
        }
    }];
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"求职进度";
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
}

- (void)backButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.rowHeight = 160;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.backgroundColor = IKGeneralLightGray;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
    }
    return _tableView;
}



#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 90;
    }
    else if (indexPath.row == 1){
        return 116;
    }
    else{
        return 70;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    IKJobProcessModel *model = (IKJobProcessModel *)[self.dataArray objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0) {
        static  NSString *cellId = @"IKJobProcessHeaderTableViewCellId";
        IKJobProcessHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKJobProcessHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell addProcessHeaderCellTopTime:model.sendTime inviteStatus:model.inviteStatus deliverJob:model.workName companyStatus:model.companyStatus userStatus:model.userStatus];
        return cell;
    }
    else if (indexPath.row == 1){
        static  NSString *cellId=@"IKJobDetailCompanyTableViewCellId";
        IKJobDetailCompanyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKJobDetailCompanyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
        
        IKJobProcessModel *model = (IKJobProcessModel *)[self.dataArray objectAtIndex:indexPath.section];
        [cell addCompanyCellData:model.companyInfoDict];
        return cell;
    }
    else{
        static  NSString *cellId = @"IKJobProcessButtonTableViewCellId";
        IKJobProcessButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKJobProcessButtonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell addProcessButtonTitleWithCompanyStatus:model.companyStatus userStatus:model.userStatus feedback:model.hasFeedback inviteStatus:model.inviteStatus];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        IKCompanyDetailVC *companyDetail = [[IKCompanyDetailVC alloc] init];
        IKCompanyInfoModel *companyInfoModel = [[IKCompanyInfoModel alloc] init];
        
        IKJobProcessModel *model = (IKJobProcessModel *)[self.dataArray objectAtIndex:indexPath.section];
        companyInfoModel.companyID = model.companyId;
        companyDetail.companyInfoModel = companyInfoModel;
        
        [self.navigationController pushViewController:companyDetail animated:YES];
    }
}


- (void)jobProcessButtonClickWithType:(IKJobProcessButtonType)type cell:(IKJobProcessButtonTableViewCell *)cell
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        IKJobProcessModel *model = (IKJobProcessModel *)[self.dataArray objectAtIndex:indexPath.section];
        
        switch (type) {
            case IKJobProcessButtonTypeChat:
            {
                NSLog(@"聊一聊");
                IKChatViewController *chat = [[IKChatViewController alloc] init];
                chat.title = model.nickName;
                [self.navigationController pushViewController:chat animated:YES];
                
                break;
            }
            case IKJobProcessButtonTypeCheckInterview:
            {
                NSLog(@"查看面试邀请");
                IKInterviewInfoView *interview = [[IKInterviewInfoView alloc] initWithTime:@"2017.04.22  15:00" address:@"杭州江干区互联网产业大厦B座17层 智新泽地" contact:@"奥巴马" phoneNumber:@"1505849092" delegate:self];
                [interview show];
                break;
            }
            case IKJobProcessButtonTypeInterViewEndToAppraise:
            {
                NSLog(@"面试结束并进行评价");
                IKEditInterviewAppraiseVc *editAppraise = [[IKEditInterviewAppraiseVc alloc] init];
                [self.navigationController pushViewController:editAppraise animated:YES];

                break;
            }
            case IKJobProcessButtonTypeGoingAppraise:
            {
                NSLog(@"进行面试评价");
                
                break;
            }
            case IKJobProcessButtonTypeCheckAppraise:
            {
                NSLog(@"查看评价");
                break;
            }
                
            default:
                break;
        }
    });
}



- (void)interviewInfoViewClickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            break;

        }
        case 1:
        {
            break;
            
        }
        default:
            break;
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
