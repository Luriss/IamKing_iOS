//
//  IKCollectionJobVc.m
//  IamKing
//
//  Created by Luris on 2017/8/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCollectionJobVc.h"
#import "IKCollectionListTableViewCell.h"
#import "IKJobDetailVC.h"


extern NSString * loginUserId;


@interface IKCollectionJobVc ()<UITableViewDelegate,UITableViewDataSource,IKCollectionListTableViewCellDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray     *dataArray;
@end

@implementation IKCollectionJobVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavTitle];
    [self initLeftBackItem];
    
    // Do any additional setup after loading the view.
    
    [[IKNetworkManager shareInstance] getCollectionJobListDataWithParam:@{@"page":@"1",@"pageSize":@"16",@"userId":loginUserId} backData:^(NSArray *dataArray, BOOL success) {
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
    title.text = @"收藏职位";
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
        _tableView.rowHeight = 160;
        _tableView.sectionHeaderHeight = 10;
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId = @"IKCollectionListTableViewCellId";
    IKCollectionListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[IKCollectionListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
    
    if (indexPath.section < self.dataArray.count) {
        [cell addCollectionListCellData:[self.dataArray objectAtIndex:indexPath.section]];
    }
    
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IKJobInfoModel *model = [self.dataArray objectAtIndex:indexPath.section];
    
    IKJobDetailVC *jobDetailVc = [[IKJobDetailVC alloc] init];
    jobDetailVc.jobModel = model;
    
    [self.navigationController pushViewController:jobDetailVc animated:YES];
    
}


- (void)cancelCollectionButtonClickWithCell:(IKCollectionListTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"indexPath = %@",indexPath);
    
    IKJobInfoModel *model = (IKJobInfoModel *)[self.dataArray objectAtIndex:indexPath.section];
    
    [self.dataArray removeObjectAtIndex:indexPath.section];
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [[IKNetworkManager shareInstance] postCancelCollectionListDataToServer:@{@"userId":loginUserId,@"inviteWorkId":model.jobID,@"status":@"0"} callback:^(BOOL success, NSString *errorMessage) {
        
    }];
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
