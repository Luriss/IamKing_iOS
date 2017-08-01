//
//  IKMoreTypeVC.m
//  IamKing
//
//  Created by Luris on 2017/7/12.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKMoreTypeVC.h"
#import "IKSearchView.h"
#import "IKSearchResultVC.h"
#import "IKTypeTableView.h"
#import "IKJobTypeDetailVC.h"
#import "IKJobTypeModel.h"
#import "IKChildJobTypeModel.h"


@interface IKMoreTypeVC ()<IKTypeTableViewDelegate,IKJobTypeDetailVCDelegate>
{
    IKJobTypeDetailVC *_jobDeatil;
}
@property(nonatomic, strong)IKSearchView *searchView;
@property(nonatomic, strong)NSIndexPath *selectIndexPath;
@property(nonatomic, strong)IKTypeTableView *typeTableView;


@end

@implementation IKMoreTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectIndexPath = nil;
    
    [self initLeftBackItem];
    
    [self initNavTitle];
    
    [self initJobTypeDetailVc];
    
    [self initTypeTableView];
    
    IKView *view = [[IKView alloc] initWithFrame:CGRectMake(15, 0, IKSCREEN_WIDTH - 30, 1)];
    view.backgroundColor = IKLineColor;
    [self.view addSubview:view];
    
//    [self initTypeDetailView];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}


- (void)setJobTypeData:(NSArray *)jobTypeData
{
    if (IKArrayIsNotEmpty(jobTypeData)) {
        _jobTypeData = jobTypeData;
        _typeTableView.jobTypeData = self.jobTypeData;
        
    }
}

- (void)initLeftBackItem
{
    // 返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(searchViewCloseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 00, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 50);
    [button setImage:[UIImage imageNamed:@"IK_back"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_back"] forState:UIControlStateHighlighted];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
//    title.backgroundColor = [UIColor redColor];
    title.text = @"职位分类";
    title.textColor = IKMainTitleColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    self.navigationItem.titleView = title;
}


- (void)initTypeTableView
{
    _typeTableView = [[IKTypeTableView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 1200+100)];
    _typeTableView.delegate = self;
    
    [self.view addSubview:_typeTableView];
    
    __weak typeof (self) weakSelf = self;

    [_typeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(1);
        make.left.and.bottom.and.right.equalTo(weakSelf.view);
    }];
}

- (void)initJobTypeDetailVc
{
    _jobDeatil = [[IKJobTypeDetailVC alloc] init];
    _jobDeatil.delegate = self;
}


- (void)dismissViewController
{
    [self dismissSelf];
}


- (void)dismissSelf
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    });
}

#pragma mark -  IKSearchViewDelegate

- (void)searchViewCloseButtonClick
{
    [self dismissSelf];
}


- (void)searchViewSearchButtonClick
{
//    IKSearchResultVC *searchResult = [[IKSearchResultVC alloc] init];
//    
//    [self presentViewController:searchResult animated:YES completion:^{
//        
//    }];
    
}


#pragma mark -  IKTypeTableViewDelegate

- (void)typeTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IKJobTypeModel *model = [self.jobTypeData objectAtIndex:indexPath.row];
    
    NSMutableArray *childArray = [NSMutableArray arrayWithCapacity:model.childType.count];
    NSMutableArray *sildeArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < model.childType.count; i ++) {
        NSDictionary *dict = (NSDictionary *)[model.childType objectAtIndex:i];
        
        IKChildJobTypeModel *childModel = [[IKChildJobTypeModel alloc] init];
        
        childModel.childJobName = [dict objectForKey:@"name"];
        [sildeArray addObject:childModel.childJobName];
        childModel.skillList = (NSArray *)[dict objectForKey:@"skillList"];
        childModel.workList = (NSArray *)[dict objectForKey:@"workList"];
        [childArray addObject:childModel];
    }
    
    
    _jobDeatil.childJobTypeData = childArray;
    _jobDeatil.silderData = sildeArray;
    [self.navigationController pushViewController:_jobDeatil animated:YES];
    
    _selectIndexPath = indexPath;
}

- (void)typeDetailViewDidSelectItemWithTitle:(NSString *)title
{
    IKLog(@"typeDetailViewDidSelectItemWithTitle = %@",title);
    [self dismissSelf];
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
