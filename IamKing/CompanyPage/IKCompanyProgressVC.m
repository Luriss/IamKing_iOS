//
//  IKCompanyProgressVC.m
//  IamKing
//
//  Created by Luris on 2017/8/1.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyProgressVC.h"
#import "IKCompanyProgressTableViewCell.h"
#import "IKTableView.h"


@interface IKCompanyProgressVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation IKCompanyProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLeftBackItem];
    [self initNavTitle];
    
    [self initTableView];
    // Do any additional setup after loading the view.
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
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 1)];
    line.backgroundColor = IKLineColor;
    
    [self.view addSubview:line];
}

- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"发展历程";
    title.textColor = IKMainTitleColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    self.navigationItem.titleView = title;
    
}

- (void)initTableView
{
    IKTableView *tableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 1, IKSCREEN_WIDTH,IKSCREENH_HEIGHT - 64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = YES;
    tableView.delegate = self;
    tableView.bounces = NO;
    tableView.dataSource = self;
    tableView.rowHeight = ceilf(IKSCREENH_HEIGHT * 0.12);
    tableView.backgroundColor = IKGeneralLightGray;
    [self.view addSubview:tableView];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.progressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId=@"IKCompanyProgressTableViewCellId";
    IKCompanyProgressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell==nil){
        cell=[[IKCompanyProgressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == 0) {
        [cell addProgressCellData:_progressArray.firstObject showVerTopLine:NO showVerBottomLine:YES];
    }
    else if (indexPath.row == (_progressArray.count-1)){
        [cell addProgressCellData:_progressArray.lastObject showVerTopLine:YES showVerBottomLine:NO];
    }
    else{
        [cell addProgressCellData:_progressArray[indexPath.row] showVerTopLine:YES showVerBottomLine:YES];
    }
    
    return cell;
}


- (void)backButtonClick:(UIButton *)button
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
