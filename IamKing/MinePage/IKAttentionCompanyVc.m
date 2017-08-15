//
//  IKAttentionCompanyVc.m
//  IamKing
//
//  Created by Luris on 2017/8/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKAttentionCompanyVc.h"
#import "IKAttentionListTableViewCell.h"
#import "IKCompanyDetailVC.h"


extern NSString * loginUserId;

@interface IKAttentionCompanyVc ()<UITableViewDelegate,UITableViewDataSource,IKAttentionListTableViewCellDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray     *dataArray;

@end

@implementation IKAttentionCompanyVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavTitle];
    [self initLeftBackItem];
    
    // Do any additional setup after loading the view.
    
    [[IKNetworkManager shareInstance] getAttentionCompanyListDataWithParam:@{@"page":@"1",@"pageSize":@"16",@"userId":loginUserId} backData:^(NSArray *dataArray, BOOL success) {
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
    title.text = @"关注公司";
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
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.backgroundColor = IKGeneralLightGray;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
    }
    return _tableView;
}



#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId = @"IKAttentionListTableViewCellId";
    IKAttentionListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[IKAttentionListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
    
    if (indexPath.row < self.dataArray.count) {
        [cell addAttentionListCellData:[self.dataArray objectAtIndex:indexPath.row]];
    }
    
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IKAttentionCompanyModel *model = (IKAttentionCompanyModel *)[self.dataArray objectAtIndex:indexPath.row];
    
    IKCompanyDetailVC *companyDetail = [[IKCompanyDetailVC alloc] init];
    
    IKCompanyInfoModel *companyInfoModel = [[IKCompanyInfoModel alloc] init];
    companyInfoModel.companyID = model.Id;

    companyDetail.companyInfoModel = companyInfoModel;
    [self.navigationController pushViewController:companyDetail animated:YES];
    
}


- (void)cancelAttentionButtonClickWithCell:(IKAttentionListTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"indexPath = %@",indexPath);
    
    IKAttentionCompanyModel *model = (IKAttentionCompanyModel *)[self.dataArray objectAtIndex:indexPath.row];
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [[IKNetworkManager shareInstance] postCancelAttentionListDataToServer:@{@"userId":loginUserId,@"objectId":model.Id,@"type":@"1",@"status":@"0"} callback:^(BOOL success, NSString *errorMessage) {
        
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
