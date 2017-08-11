//
//  IKShopListViewController.m
//  IamKing
//
//  Created by Luris on 2017/8/9.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKShopListViewController.h"
#import "IKInfoTableViewCell.h"
#import "IKJobDetailVC.h"


@interface IKShopListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL    _hadShowNoShopBg;
}

@property(nonatomic,strong)IKTableView  *tableView;
@property(nonatomic,copy)NSArray        *dataArray;


@end

@implementation IKShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = IKGeneralLightGray;
    _hadShowNoShopBg = NO;
    // Do any additional setup after loading the view.
    [self initLeftBackItem];
    
    [self initNavTitle];
}

- (void)initLeftBackItem
{
    // 返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 00, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 50);
    [button setImage:[UIImage imageNamed:@"IK_back_white"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_back_white"] forState:UIControlStateHighlighted];
    
    self.navigationView.leftButton = button;
}

- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"该店铺正在招聘的职位";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    self.navigationView.titleView = title;
}

- (void)setDataDict:(NSDictionary *)dataDict
{
    NSLog(@"dataDict = %@",dataDict);
    if (IKDictIsNotEmpty(dataDict)) {
        NSString *shopID = [dataDict objectForKey:@"shopId"];
        NSString *companyID = [dataDict objectForKey:@"companyId"];
        
        [[IKNetworkManager shareInstance] getCompanyPageShopListInfoWithParam:dataDict backData:^(NSArray *dataArray, BOOL success) {
            if (success) {
                self.dataArray = [NSArray arrayWithArray:dataArray];
                [self.view addSubview:self.tableView];
                
                if (dataArray.count == 0) {
                    [self initNoShopBg];
                }
            }
            else{
                [self initNoShopBg];
            }
        }];
    }
}


- (void)initNoShopBg
{
    if (!_hadShowNoShopBg) {
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x - 50, self.view.center.y - 130, 100, 108)];
        [image setImage:[UIImage imageNamed:@"IK_noShop"]];
        
        [self.view addSubview:image];
        _hadShowNoShopBg = YES;
    }
}

- (IKTableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[IKTableView alloc] initWithFrame:CGRectMake(0, 64, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = YES;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.dataSource = self;
//        _tableView.backgroundColor = IKGeneralLightGray;
    }
    return _tableView;
}



#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (IKSCREEN_WIDTH * 0.2933);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId=@"IKInfoCellId";
    IKInfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell==nil)
    {
        cell=[[IKInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
    
    if (indexPath.row < self.dataArray.count) {
        [cell addCellData:self.dataArray[indexPath.row]];
    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IKJobInfoModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    IKJobDetailVC *vc = [[IKJobDetailVC alloc] init];
    vc.jobModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)popSelf
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
