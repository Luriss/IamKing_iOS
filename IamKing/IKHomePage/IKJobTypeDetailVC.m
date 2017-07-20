//
//  IKJobTypeDetailVC.m
//  IamKing
//
//  Created by Luris on 2017/7/17.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobTypeDetailVC.h"
#import "IKSlideView.h"
#import "IKTagsCollectionViewCell.h"
#import "IKSearchVC.h"

@interface IKJobTypeDetailVC ()<IKSlideViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,IKSearchViewControllerDelegate>
@property(nonatomic, strong)IKSlideView *slideView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation IKJobTypeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self initLeftBackItem];
    
    [self initNavTitle];
    
    [self initTypeClassify];
    
    [self initCollectionView];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tagsData = @[@"私人教练",@"私人主管",@"私人主管",@"私人主管",@"TRX",@"SPRINNNG",@"AASFP",@"私人教练",@"私人主管",@"TRX",@"SPRINNNG",@"AASFP",@"私人教练",@"私人主管",@"TRX",@"SPRINNNG",@"AASFP"];
    
    [_slideView reloadData];
    [_collectionView reloadData];
}

- (void)initLeftBackItem
{
    // 返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 00, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(12, 10, 12, 40);
    [button setImage:[UIImage imageNamed:@"IK_back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"健身教练";
    title.textColor = IKMainTitleColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:IKMainTitleFont];
    self.navigationItem.titleView = title;
}

- (void)setDelegate:(id<IKJobTypeDetailVCDelegate>)delegate
{
    if (delegate) {
        _delegate = delegate;
    }
}

- (void)dismissSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)initTypeClassify
{
    _slideView = [[IKSlideView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 50)];
    _slideView.backgroundColor = IKGeneralLightGray;
    _slideView.data = @[@"私人教练",@"团课教练"];
    _slideView.delegate = self;
    [self.view addSubview:_slideView];
}



- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 50);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10.0f; // 列间距
    layout.minimumLineSpacing = 20.0f; //行间距
    layout.sectionInset = UIEdgeInsetsMake(20.0f, 20.0f, 20.0f, 20.0f);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 115, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-115) collectionViewLayout:layout];
    _collectionView.tag = 101;
    _collectionView.bounces = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[IKTagsCollectionViewCell class] forCellWithReuseIdentifier:@"IKTagsCollectionViewCell"];
    
    [self.view addSubview:_collectionView];
}



#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _tagsData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 根据文字计算尺寸.
    CGFloat w = [self widthForLabel:_tagsData[indexPath.row] fontSize:15];
    return CGSizeMake(w, 24);
}



- (CGFloat)widthForLabel:(NSString *)text fontSize:(CGFloat)font
{
    // 根据文字计算尺寸.
    CGRect frame = [text boundingRectWithSize:CGSizeMake(_collectionView.frame.size.width, 24) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]} context:nil];
    
    // item 默认的最小宽度为 40;
    CGFloat width = frame.size.width + 15;
    
    if (width < 40) {
        width = 40;
    }
    
    // 超过最大宽度显示为最大宽度
    CGFloat maxWidth = CGRectGetWidth(self.view.bounds) - 20;
    if (width > maxWidth){
        width = maxWidth;
    }
    
    return width;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKTagsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IKTagsCollectionViewCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = _tagsData[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKLog(@"didSelectItemAtIndexPath = %@",indexPath);
    
    IKTagsCollectionViewCell *cell = (IKTagsCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    IKSearchVC *searchVc = [[IKSearchVC alloc] init];
    searchVc.delegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        searchVc.modalPresentationStyle = UIModalPresentationPopover;
        searchVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        IKNavigationController *nav = [[IKNavigationController alloc] initWithRootViewController:searchVc];
        [self presentViewController:nav animated:NO completion:^{
            [searchVc showSearchResultViewWithSearchText:cell.titleLabel.text];
        }];
    });
}

- (void)searchViewControllerDismiss
{
    if ([self.delegate respondsToSelector:@selector(dismissViewController)]) {
        [self.delegate dismissViewController];
    }
}


- (void)slideView:(IKSlideView *)slideView didSelectItemAtIndex:(NSUInteger )selectedIndex
{
    
    NSInteger x = selectedIndex % 2;
    if (x == 1) {
        self.tagsData = @[@"SPRINNNG",@"AASFP",@"私人教练",@"私人主管",@"TRX",@"SPRINNNG",@"AASFP",@"私人教练",@"私人主管",@"私人主管",@"私人主管",@"TRX",@"SPRINNNG",@"AASFP",@"私人教练",@"私人主管",@"TRX"];
    }
    else{
        self.tagsData = @[@"私人教练",@"私人主管",@"私人主管",@"私人主管",@"TRX",@"SPRINNNG",@"AASFP",@"私人教练",@"私人主管",@"TRX",@"SPRINNNG",@"AASFP",@"私人教练",@"私人主管",@"TRX",@"SPRINNNG",@"AASFP"];
    }
    
    
    [_collectionView reloadData];
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
