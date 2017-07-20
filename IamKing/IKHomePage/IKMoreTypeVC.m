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

@interface IKMoreTypeVC ()<IKTypeTableViewDelegate,IKJobTypeDetailVCDelegate>
{
    IKJobTypeDetailVC *_jobDeatil;
}
@property(nonatomic, strong)IKSearchView *searchView;
@property(nonatomic, strong)NSIndexPath *selectIndexPath;


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


- (void)initLeftBackItem
{
    // 返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(searchViewCloseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 00, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 50);
    [button setImage:[UIImage imageNamed:@"IK_back"] forState:UIControlStateNormal];
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
    IKTypeTableView *typeTableView = [[IKTypeTableView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 1200+100)];
    typeTableView.delegate = self;
    [self.view addSubview:typeTableView];
    
    __weak typeof (self) weakSelf = self;

    [typeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
