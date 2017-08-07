//
//  IKMessageViewController.m
//  IamKing
//
//  Created by Luris on 2017/7/29.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKMessageViewController.h"
#import "IKMessageNoticeTableViewCell.h"

@interface IKMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)IKTableView      *bgTableView;


@end

@implementation IKMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMessageNavigationContent];
    [self.view addSubview:self.bgTableView];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)initMessageNavigationContent
{
    [self createRightBarItem];
    [self setNavigationTitle];
}


- (void)createRightBarItem
{
    // 删除
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(messageBatchDeleteButtonCkick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(10, 46, 10, 0);
    
    UIImage *image =[UIImage imageByApplyingAlpha:0.8 image:[UIImage imageNamed:@"IK_batchDelete_white"]];
    [button setImage:[UIImage imageNamed:@"IK_batchDelete_white"] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)messageBatchDeleteButtonCkick:(UIButton *)button
{
    
}

// 设置导航栏内容
- (void)setNavigationTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"聊天消息";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    self.navigationItem.titleView = title;
}


- (IKTableView *)bgTableView
{
    if (_bgTableView == nil) {
        _bgTableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 1, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 49-64) style:UITableViewStylePlain];
        _bgTableView.backgroundColor = IKGeneralLightGray;
        _bgTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bgTableView.showsVerticalScrollIndicator = YES;
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
    return  3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ceilf(IKSCREENH_HEIGHT * 0.1125);
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 2) {
        return 10;
    }
    else if (section == 1){
        return 5;
    }
    else{
        return 0.01;
    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 1;
    }
    else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId=@"IKMessageNoticeTableViewCellId";
    IKMessageNoticeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[IKMessageNoticeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
    
    if (indexPath.section == 0) {
        cell.cellType = IKMessageNoticeTableViewCellTypeNotice;
    }
    else if (indexPath.section == 1){
        cell.cellType = IKMessageNoticeTableViewCellTypeInterested;
    }
    else{
        cell.cellType = IKMessageNoticeTableViewCellTypeMessage;
    }
    
    [cell messageNoticeCellAddData];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
