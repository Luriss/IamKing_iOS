//
//  IKBlackListViewController.m
//  IamKing
//
//  Created by Luris on 2017/8/14.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKBlackListViewController.h"
#import "IKBlackListModel.h"
#import "IKBlackListTableViewCell.h"
#import "IKButton.h"


extern NSString * loginUserId;

@interface IKBlackListViewController ()<UITableViewDelegate,UITableViewDataSource,IKBlackListTableViewCellDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray     *dataArray;
@property(nonatomic, strong)NSMutableArray     *selectedArray;
@property(nonatomic, strong)UIButton           *deleteButton;
@property(nonatomic, strong)UIView             *bottomView;
@property(nonatomic, strong)IKButton           *batchButton;

@end

@implementation IKBlackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavTitle];
    [self initLeftBackItem];
    [self initRightBackItem];
    
    NSLog(@"loginUserId = %@",loginUserId);
    [[IKNetworkManager shareInstance] getBlackListDataWithParam:@{@"pageSize":@"16",@"userId":loginUserId} backData:^(NSArray *dataArray, BOOL success) {
        if (success && dataArray.count > 0) {
            self.dataArray = [NSMutableArray arrayWithArray:dataArray];
            [self.view addSubview:self.tableView];
        }
        
    }];
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"黑名单";
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

- (void)initRightBackItem
{
    //
    IKButton *button = [IKButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(batchDelete:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 40, 44);
//    button.backgroundColor = [UIColor redColor];
    button.imageEdgeInsets = UIEdgeInsetsMake(10, 8, 10, 8);
    
    UIImage *image =[UIImage imageByApplyingAlpha:0.8 image:[UIImage imageNamed:@"IK_batchDelete_white"]];
    [button setImage:[UIImage imageNamed:@"IK_batchDelete_white"] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    
    self.batchButton = button;
    self.navigationView.rightButton = button;
}

- (void)backButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)batchDelete:(IKButton *)button
{
    if (!button.isClick) {
        [button setTitle:@"取消" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [button setImage:nil forState:UIControlStateNormal];
        [button setImage:nil forState:UIControlStateHighlighted];
        
        [IKNotificationCenter postNotificationName:@"IKEditingHideDeleteButton" object:nil];
        
        [self.tableView setEditing:YES animated:YES];
        button.isClick = YES;
        
        if (_bottomView == nil) {
            [self.view addSubview:self.bottomView];
            [self.view bringSubviewToFront:self.bottomView];
        }
        else{
            self.bottomView.hidden = NO;
        }
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    }
    else{
        [button setTitle:@"" forState:UIControlStateNormal];
        UIImage *image =[UIImage imageByApplyingAlpha:0.8 image:[UIImage imageNamed:@"IK_batchDelete_white"]];
        [button setImage:[UIImage imageNamed:@"IK_batchDelete_white"] forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateHighlighted];
        [IKNotificationCenter postNotificationName:@"IKEditingShowDeleteButton" object:nil];

        [self.tableView setEditing:NO animated:YES];
        button.isClick = NO;
        self.bottomView.hidden = YES;
        self.tableView.contentInset = UIEdgeInsetsZero;
    }
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.backgroundColor = IKGeneralLightGray;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
    }
    return _tableView;
}


- (NSMutableArray *)selectedArray
{
    if (_selectedArray == nil) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}


- (UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, IKSCREENH_HEIGHT - 50, IKSCREEN_WIDTH, 50)];
        _bottomView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95f];
//        [self.view addSubview:_bottomView];
//        [self.view bringSubviewToFront:_bottomView];
        [_bottomView addSubview:self.deleteButton];
    }
    return _bottomView;
}



- (UIButton *)deleteButton
{
    if (_deleteButton == nil) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.backgroundColor = IKGeneralBlue;
        _deleteButton.frame = CGRectMake(IKSCREEN_WIDTH*0.5 - 100, 5, 200, 40);
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [_deleteButton setBackgroundImage:IKButtonBlueBgImgae forState:UIControlStateNormal];
        [_deleteButton setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
        _deleteButton.layer.cornerRadius = 6;
        _deleteButton.layer.masksToBounds = YES;
        [_deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (void)deleteButtonClick:(UIButton *)button
{
    NSLog(@"selectedArray = %@",self.selectedArray);
    
    NSMutableString *idStr = [[NSMutableString alloc] init];
    
    for (IKBlackListModel *model in self.selectedArray) {
        [idStr appendFormat:@"%@,",model.Id];
        [self.dataArray removeObject:model];
    }
    NSLog(@"idStr = %@",idStr);
    [[IKNetworkManager shareInstance] postDeleteBlackListDataToServer:@{@"userId":loginUserId,@"objectId":idStr} callback:^(BOOL success, NSString *errorMessage) {
        if (success) {
            self.batchButton.isClick = YES;
            [self batchDelete:self.batchButton];
            [self.tableView reloadData];
        }
    }];
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
    static  NSString *cellId = @"IKBlackListTableViewCellId";
    IKBlackListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[IKBlackListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }

    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];

    cell.delegate = self;
    cell.tintColor = IKGeneralBlue;
    [cell blackListCellAddData:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中数据
    [self.selectedArray addObject:self.dataArray[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //从选中中取消
    if (self.selectedArray.count > 0) {
        [self.selectedArray removeObject:self.dataArray[indexPath.row]];
    }
    
}


- (void)deleteButtonClickWithCell:(IKBlackListTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"indexPath = %@",indexPath);
    
    IKBlackListModel *model = (IKBlackListModel *)[self.dataArray objectAtIndex:indexPath.row];

    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    [[IKNetworkManager shareInstance] postDeleteBlackListDataToServer:@{@"userId":loginUserId,@"objectId":model.Id} callback:^(BOOL success, NSString *errorMessage) {
        
    }];
}

- (void)postNewDataToSever:(NSString *)objectId
{
    
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
