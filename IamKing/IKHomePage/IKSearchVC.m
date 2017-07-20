//
//  IKSearchVC.m
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSearchVC.h"
#import "IKSearchResultView.h"
#import "IKJobInfoModel.h"
#import "IKTagsView.h"
#import "IKImageWordView.h"


@interface IKSearchVC ()<IKSearchViewDelegate,IKTagsViewDelegate>
{
    IKSearchResultView    *_searchResultView;
}

@property(nonatomic,strong)IKSearchView *searchView;
@property (nonatomic,strong)IKTagsView *tag1;
@property (nonatomic,strong)IKTagsView *tag2;
@property (nonatomic,strong)IKTagsView *tag3;

@end

@implementation IKSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSearchView];
    [self initTagsView];
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];

    [self.view addGestureRecognizer:pan];
    
    
    
    _searchResultView = [[IKSearchResultView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 64)];
    _searchResultView.backgroundColor = [UIColor whiteColor];
    
    IKJobInfoModel  *model = [[IKJobInfoModel alloc] init];
    model.logoImageUrl = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646722_1456498424671_800x600.jpg";
    model.title = @"高级营销总监";
    model.salary = @"13~18k";
    model.address = @"杭州";
    model.experience = @"6~8年";
    model.education = @"本科";
    model.skill1 = @"销售能手好";
    model.skill2 = @"NAFC";
    model.skill3 = @"形象好";
    model.introduce = @"时尚连锁健身俱乐部品牌,致力于提供超乎想象的健身运动体验.在江浙沪,拥有36家直营店铺.时尚连锁健身俱乐部品牌,致力于提供超乎想象的健身运动体验.在江浙沪,拥有36家直营店铺.";
    
    _searchResultView.jobModel = model;
    _searchResultView.hidden = YES;
    [self.view addSubview:_searchResultView];
    // Do any additional setup after loading the view.
}


- (void)pan:(UIPanGestureRecognizer *)pan
{
    if (_searchView.searchBar.isFirstResponder) {
        [_searchView.searchBar resignFirstResponder];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _searchView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}




- (void)initSearchView
{
    _searchView = [[IKSearchView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
    _searchView.delegate = self;
    _searchView.hiddenColse = NO;
    _searchView.backgroundColor = [UIColor whiteColor];
    _searchView.transform = CGAffineTransformMakeTranslation(0, 44);
    [_searchView.searchBar becomeFirstResponder];
    self.navigationItem.titleView = _searchView;

}

- (void)initTagsView
{
    __weak typeof (self) weakSelf = self;

    
    _tag1 = [[IKTagsView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    [self.view addSubview:_tag1 ];
        
    [_tag1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        make.height.mas_equalTo(CGRectGetHeight(_tag1.frame));
    }];
    
    _tag1.delegate = self;
    _tag1.data = @[@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练",@"私人教练"];
    _tag1.lineSpacing = 10.0;
    _tag1.verticalSpacing = 15.0;
    _tag1.tagHeight = 26;
    _tag1.tagBorderWidth = 1;
    _tag1.tagBorderColor = IKSubHeadTitleColor;
    _tag1.tagCornerRadius = _tag1.tagHeight *0.5;
    _tag1.tagTitleColor = IKSubHeadTitleColor;
    _tag1.tagFont = IKSubTitleFont;
    
    IKImageWordView *view1 = [[IKImageWordView alloc] init];
    view1.imageView.image = [UIImage imageNamed:@"IK_hot"];
    view1.label.text = @"热门职位";
    _tag1.titleView = view1;
    
    [_tag1 createViewAdjustViewFrame:^(CGRect newFrame) {
        NSLog(@"newFrame = %@",[NSValue valueWithCGRect:newFrame]);
        CGFloat height = CGRectGetHeight(newFrame);
        [_tag1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(weakSelf.view);
            make.top.equalTo(weakSelf.view);
            make.height.mas_equalTo(height);
        }];
    }];
    
    _tag2 = [[IKTagsView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    [self.view addSubview:_tag2 ];
    
    [_tag2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(_tag1.mas_bottom);
        make.height.mas_equalTo(CGRectGetHeight(_tag2.frame));
    }];
    
    //    tag.backgroundColor = [UIColor cyanColor];
    _tag2.delegate = self;
    _tag2.data = @[@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",@"lesmills",@"SPINNNG",];
    _tag2.lineSpacing = 10.0;
    _tag2.verticalSpacing = 15.0;
    _tag2.tagHeight = 26;
    _tag2.tagBorderWidth = 1;
    _tag2.tagBorderColor = IKSubHeadTitleColor;
    _tag2.tagCornerRadius = _tag2.tagHeight *0.5;
    _tag2.tagTitleColor = IKSubHeadTitleColor;
    _tag2.tagFont = IKSubTitleFont;
    
    IKImageWordView *view2 = [[IKImageWordView alloc] init];
    view2.imageView.image = [UIImage imageNamed:@"IK_hot"];
    view2.label.text = @"热门技能";
    _tag2.titleView = view2;
    
    [_tag2 createViewAdjustViewFrame:^(CGRect newFrame) {
        NSLog(@"newFrame = %@",[NSValue valueWithCGRect:newFrame]);
        CGFloat height = CGRectGetHeight(newFrame);
        [_tag2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(weakSelf.view);
            make.top.equalTo(_tag1.mas_bottom);
            make.height.mas_equalTo(height);
        }];
    }];

    _tag3 = [[IKTagsView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    [self.view addSubview:_tag3 ];
    
    [_tag3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(_tag2.mas_bottom);
        make.height.mas_equalTo(CGRectGetHeight(_tag3.frame));
    }];
    
    //    tag.backgroundColor = [UIColor cyanColor];
    _tag3.delegate = self;
    _tag3.data = @[@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身",@"威尔士健身"];
    _tag3.lineSpacing = 10.0;
    _tag3.verticalSpacing = 15.0;
    _tag3.tagHeight = 26;
    _tag3.tagBorderWidth = 1;
    _tag3.tagBorderColor = IKSubHeadTitleColor;
    _tag3.tagCornerRadius = _tag3.tagHeight *0.5;
    _tag3.tagTitleColor = IKSubHeadTitleColor;
    _tag3.tagFont = IKSubTitleFont;
    
    IKImageWordView *view3 = [[IKImageWordView alloc] init];
    view3.imageView.image = [UIImage imageNamed:@"IK_hot"];
    view3.label.text = @"热门公司";
    _tag3.titleView = view3;
    
    [_tag3 createViewAdjustViewFrame:^(CGRect newFrame) {
        NSLog(@"newFrame = %@",[NSValue valueWithCGRect:newFrame]);
        CGFloat height = CGRectGetHeight(newFrame);
        [_tag3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(weakSelf.view);
            make.top.equalTo(_tag2.mas_bottom);
            make.height.mas_equalTo(height);
        }];
    }];
    
}


- (void)startSearchViewAnimation
{
    _searchView.hidden = NO;
    
    
}


#pragma mark -  IKSearchViewDelegate



- (void)searchViewCloseButtonClick
{
    __weak typeof (self) weakSelf = self;
    [self dismissViewControllerAnimated:NO completion:^{
        if ([weakSelf.delegate respondsToSelector:@selector(searchViewControllerDismiss)]) {
            [weakSelf.delegate searchViewControllerDismiss];
        }
    }];
}


- (void)searchViewStartSearch
{
    [_searchResultView resetOldSelectedView:nil];
    
}


- (void)searchViewSearchBarSearchButtonClicked:(nullable UISearchBar *)searchBar
{
    IKLog(@"searchViewSearchBarSearchButtonClicked");
    
    [self showSearchResultView];
}


- (void)tagViewDidSelectedTagWithTitle:(NSString *)title
{
    [self showSearchResultViewWithSearchText:title];
}

- (void)showSearchResultViewWithSearchText:(NSString *)searchText
{
    _searchView.searchBar.text = searchText;
    
    [self showSearchResultView];
}

- (void)showSearchResultView
{
    if (_searchResultView.hidden) {
        _searchResultView.hidden = NO;
    }
    else{
        [_searchResultView reloadData];
    }
    [_searchView.searchBar resignFirstResponder];

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
