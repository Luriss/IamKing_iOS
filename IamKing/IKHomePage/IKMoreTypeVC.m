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
#import "IKTypeDetailView.h"

@interface IKMoreTypeVC ()<IKSearchViewDelegate,IKTypeTableViewDelegate,IKTypeDetailViewDelegate>

@property(nonatomic, strong)IKSearchView *searchView;
@property(nonatomic, strong)IKTypeDetailView *detailView;


@end

@implementation IKMoreTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initSearchView];
    
    [self initInfoTableView];
    
    
    [self initTypeDetailView];
    
    // Do any additional setup after loading the view.
}


- (void)initSearchView
{
    _searchView = [[IKSearchView alloc] init];
    _searchView.delegate = self;
    _searchView.hiddenColse = NO;
    [self.view addSubview:_searchView];
    
    __weak typeof (self) weakSelf = self;

    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(64);
        make.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(40);
    }];
}


- (void)initInfoTableView
{
    IKTypeTableView *typeTableView = [[IKTypeTableView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, 1200+100)];
    typeTableView.delegate = self;
    [self.view addSubview:typeTableView];
    
    __weak typeof (self) weakSelf = self;

    [typeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchView.mas_bottom).offset(1);
        make.left.and.bottom.and.right.equalTo(weakSelf.view);
    }];
}


- (void)initTypeDetailView
{
    IKTypeDetailView *detail = [[IKTypeDetailView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH - 55, IKSCREENH_HEIGHT - 64 - 41)];
    detail.delegate = self;
    detail.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(detail.frame), 0);
    detail.hidden = YES;
    [self.view addSubview:detail];
    
    __weak typeof (self) weakSelf = self;

    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchView.mas_bottom).offset(1);
        make.bottom.and.right.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view).offset(55);
    }];
    
    self.detailView = detail;
}

#pragma mark -  IKSearchViewDelegate

- (void)searchViewCloseButtonClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)searchViewSearchButtonClick
{
    IKSearchResultVC *searchResult = [[IKSearchResultVC alloc] init];
    
    [self presentViewController:searchResult animated:YES completion:^{
        
    }];
    
}


#pragma mark -  IKTypeTableViewDelegate

- (void)typeTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.detailView.hidden) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.detailView.hidden = NO;
            self.detailView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if (indexPath.row == 1) {
        self.detailView.detailData = @[@"私教培训",@"团课培训",@"其他培训"];
    }
    else{
        self.detailView.detailData = @[@"私人教练",@"团课教练"];
    }
    [self.detailView typeDetailViewReloadData];
}

- (void)typeDetailViewDidSelectItemWithTitle:(NSString *)title
{
    IKLog(@"typeDetailViewDidSelectItemWithTitle = %@",title);
    [self dismissViewControllerAnimated:YES completion:^{
        
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
