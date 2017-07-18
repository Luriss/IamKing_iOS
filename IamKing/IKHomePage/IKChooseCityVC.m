//
//  IKChooseCityVC.m
//  IamKing
//
//  Created by Luris on 2017/7/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKChooseCityVC.h"
#import "IKTagsView.h"
#import "IKTagsCollectionViewFlowLayout.h"
#import "IKTagsCollectionViewCell.h"
#import "IKChooseCityView.h"

static NSString * const reuseIdentifier = @"hotCityCollectionViewCellId";
static NSString * const headerReuseIdentifier = @"IKCollectionViewHeader";

@interface IKChooseCityVC ()<IKTagsViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,IKChooseCityViewDelegate>

@property (nonatomic, strong)IKView *locationInfoView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) IKTagsCollectionViewFlowLayout *layout;//布局layout
@property (nonatomic,strong) IKChooseCityView *chooseCity;

@property (nonatomic,   copy)NSDictionary *baseDict;


@end

@implementation IKChooseCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavView];
    [self initHotCityView];
    [self addSubViews];
    [self plistData];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self layoutCustomView];

}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)plistData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"IKProvinceCity" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    self.baseDict = [data objectForKey:@"provinceCity"];
    self.provinceData = [data objectForKey:@"province"];
    
    self.cityData = [self.baseDict objectForKey:[self.provinceData firstObject]];
}

- (void)initNavView
{
    // 分类
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 60, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(14, 0, 14, 44);
    [button setImage:[UIImage imageNamed:@"IK_close"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"城市切换";
    title.textColor = IKMainTitleColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:IKMainTitleFont];
    
    self.navigationItem.titleView = title;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 1)];
    lineView.backgroundColor = IKLineColor;
    
    [self.view addSubview:lineView];
}


- (void)initHotCityView
{
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200) collectionViewLayout:self.layout];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    [_collectionView registerClass:[IKTagsCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    _collectionView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_collectionView.center.x - 100, -25, 200, 30)];
    //        label.backgroundColor = [UIColor redColor];
    label.text = @"热门城市";
    label.textColor = IKMainTitleColor;
    label.font = [UIFont systemFontOfSize:IKSubTitleFont];
    label.textAlignment = NSTextAlignmentCenter;
    [_collectionView addSubview:label];
    
    
    [self.view addSubview:_collectionView];
}


- (void)initChooseCityView
{
}

- (void)addSubViews
{
    // 定位信息 view.
    [self.view addSubview:self.locationInfoView];
    
    _chooseCity = [[IKChooseCityView alloc] init];
    _chooseCity.delegate = self;
    [self.view addSubview:_chooseCity];
    
    __weak typeof (self) weakSelf = self;
    
    [_locationInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(1);
        make.height.mas_equalTo(80);
    }];
    
}
#pragma mark - Property Get

- (IKTagsCollectionViewFlowLayout *)layout
{
    if (_layout == nil) {
        _layout = [[IKTagsCollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(80.0f, 24.0f);
        _layout.minimumInteritemSpacing = 25.0f;
        _layout.minimumLineSpacing = 20.0f;
        _layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    }
    
    return _layout;
}


- (IKView *)locationInfoView
{
    if (_locationInfoView == nil) {
        _locationInfoView = [[IKView alloc]init];
        _locationInfoView.backgroundColor = [UIColor whiteColor];
        
        [self initLocationInfoView];
    }
    return _locationInfoView;
}



- (void)initLocationInfoView
{
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"自动定位";
    tipLabel.textColor = IKMainTitleColor;
    tipLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [_locationInfoView addSubview:tipLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(locationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [button setTitle:@"杭州" forState:UIControlStateNormal];
    button.layer.cornerRadius = 15;
    button.layer.borderColor = IKGeneralBlue.CGColor;
    button.layer.borderWidth = 1;
    [_locationInfoView addSubview:button];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = IKLineColor;
    [_locationInfoView addSubview:view];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationInfoView).offset(8);
        make.left.and.right.equalTo(_locationInfoView);
        make.height.mas_equalTo(30);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_locationInfoView);
        make.bottom.equalTo(_locationInfoView).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_offset(80);
    }];
    
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_locationInfoView);
        make.bottom.equalTo(_locationInfoView).offset(1);
        make.height.mas_equalTo(1);
    }];
}


#pragma mark - Layout View

- (void)layoutCustomView
{
    __weak typeof (self) weakSelf = self;

    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(_locationInfoView.mas_bottom);
        make.height.mas_equalTo(210);
    }];
    
    [_chooseCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_collectionView.mas_bottom);
        make.left.and.right.and.bottom.equalTo(weakSelf.view);
    }];
}


- (void)chooseCityViewSelectedCity:(NSString *)city
{
    IKLog(@"chooseCityViewSelectedCity");
    
    [self dismissSelfWithCity:city];
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cityData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKTagsCollectionViewFlowLayout *layout = (IKTagsCollectionViewFlowLayout *)collectionView.collectionViewLayout;
    
    // item 能显示的最大宽度 ,collectionView的宽度 - section 的偏移 left right.
    CGSize maxSize = CGSizeMake(collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, layout.itemSize.height);
    
    // 根据文字计算尺寸.
    CGRect frame = [self.cityData[indexPath.item] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:IKSubTitleFont]} context:nil];
    
    // item 默认的最小宽度为 80;
    CGFloat width = frame.size.width + 20;
    if (width < 70) {
        width = 70;
    }
    
    // 超过最大宽度显示为最大宽度
    if (width > maxSize.width) {
        width = maxSize.width;
    }
    
    return CGSizeMake(width, layout.itemSize.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKTagsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.titleLabel.textColor = [UIColor blackColor];
    
    NSString *title = self.cityData[indexPath.item];
    cell.titleLabel.text = title;
    
//    if (indexPath.row == 1) {
//        cell.highlightLabel = YES;
//    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IKLog(@"didSelectItemAtIndexPath = %@",indexPath);
    
    IKTagsCollectionViewCell *cell = (IKTagsCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSString *title = cell.titleLabel.text;
    [self dismissSelf];
    
    if ([self.delegate respondsToSelector:@selector(locationVcDismissChangeNavButtonTitle:)]) {
        [self.delegate locationVcDismissChangeNavButtonTitle:title];
    }
}


#pragma mark - BottomView

- (void)dismissSelf
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    });
}

- (void)dismissSelfWithCity:(NSString *)city
{
    IKLog(@"dismissSelfWithCity");
    [self dismissSelf];
    
    if ([self.delegate respondsToSelector:@selector(locationVcDismissChangeNavButtonTitle:)]) {
        [self.delegate locationVcDismissChangeNavButtonTitle:city];
    }
    
}

- (void)locationButtonClick:(UIButton *)button
{
    [self dismissSelfWithCity:button.titleLabel.text];
    
    
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
