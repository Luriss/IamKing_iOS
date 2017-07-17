//
//  IKChooseCityVC.m
//  IamKing
//
//  Created by Luris on 2017/7/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKChooseCityVC.h"
#import "IKLocationCell.h"
#import "IKButtonView.h"
#import "IKTagsView.h"
#import "IKTagsCollectionViewFlowLayout.h"
#import "IKTagsCollectionViewCell.h"


static NSString * const reuseIdentifier = @"hotCityCollectionViewCellId";
static NSString * const headerReuseIdentifier = @"IKCollectionViewHeader";

@interface IKChooseCityVC ()<UITableViewDelegate,UITableViewDataSource,IKTagsViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSIndexPath  *_oldProvinceIndexPath;
    NSIndexPath  *_oldCityIndexPath;
}

@property (nonatomic, strong)IKView *locationInfoView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) IKTagsCollectionViewFlowLayout *layout;//布局layout

@property (nonatomic, strong)UITableView *provinceTableView;
@property (nonatomic, strong)UITableView *cityTableView;
@property (nonatomic,   copy)NSDictionary *baseDict;
@property (nonatomic,   copy)NSString    *selectProvince;
@property (nonatomic,   copy)NSString    *selectCity;

@end

@implementation IKChooseCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configBaseData];
    
    [self plistData];

    [self initNavView];
    [self initHotCityView];
    [self addSubViews];
    
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


- (void)configBaseData
{
    _oldProvinceIndexPath = nil;
    _oldCityIndexPath = nil;
    
    self.selectCity = [IKUSERDEFAULT objectForKey:@"selectedCity"];
    self.selectProvince = [IKUSERDEFAULT objectForKey:@"selectedProvince"];
    IKLog(@"self.selectProvince = %@,self.selectCity = %@",self.selectProvince,self.selectCity);
}

- (void)plistData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"IKProvinceCity" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    self.baseDict = [data objectForKey:@"provinceCity"];
    self.provinceData = [data objectForKey:@"province"];
    
    if (IKStringIsNotEmpty(self.selectProvince)) {
        self.cityData = [self.baseDict objectForKey:self.selectProvince];
        // 默认选中的行.
        NSInteger row = [self.provinceData indexOfObject:self.selectProvince];
        _oldProvinceIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
    }
    else{
        self.cityData = [self.baseDict objectForKey:[self.provinceData firstObject]];
    }
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
    label.textColor = IKSubHeadTitleColor;
    label.font = [UIFont boldSystemFontOfSize:IKSubTitleFont];
    label.textAlignment = NSTextAlignmentCenter;
    [_collectionView addSubview:label];
    
    
    [self.view addSubview:_collectionView];
}

- (void)addSubViews
{
    // 所有的 子 view 都建议添加在bottomView上避免影响动画.
    
    // 定位信息 view.
    [self.view addSubview:self.locationInfoView];
    
    [self.view addSubview:self.provinceTableView];
    
    [self.view addSubview:self.cityTableView];
    
    __weak typeof (self) weakSelf = self;
    
    [_locationInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
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


- (UITableView *)provinceTableView
{
    if (_provinceTableView == nil) {
        _provinceTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _provinceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _provinceTableView.backgroundColor = IKRGBColor(240, 240, 243);
        _provinceTableView.bounces = NO;
        _provinceTableView.delegate = self;
        _provinceTableView.dataSource = self;
    }
    
    return _provinceTableView;
}


- (UITableView *)cityTableView
{
    if (_cityTableView == nil) {
        _cityTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _cityTableView.backgroundColor = IKRGBColor(243, 243, 248);
        _cityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _cityTableView.bounces = NO;
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
    }
    return _cityTableView;
}


- (void)initLocationInfoView
{
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"自动定位到您在";
    tipLabel.textColor = IKSubHeadTitleColor;
    tipLabel.font = [UIFont boldSystemFontOfSize:IKSubTitleFont];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [_locationInfoView addSubview:tipLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
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
    
    CGSize size = [self.layout collectionViewContentSize];


    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(_locationInfoView.mas_bottom);
        make.height.mas_equalTo(210);
    }];
    
    [_provinceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_collectionView.mas_bottom);
        make.left.and.bottom.equalTo(weakSelf.view);
        make.width.mas_equalTo(IKSCREEN_WIDTH *0.4);
    }];
    
    [_cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_provinceTableView);
        make.right.equalTo(weakSelf.view);
        make.left.equalTo(_provinceTableView.mas_right);
    }];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _provinceTableView) {
        return 50;
    }
    else{
        return 60;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _provinceTableView) {
        return self.provinceData.count;
    }
    else{
        return self.cityData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.provinceTableView) {
        static  NSString *cellId=@"provinceID";
        IKLocationCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell==nil){
            cell=[[IKLocationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        NSString *provinceStr = [self.provinceData objectAtIndex:indexPath.row];
        cell.tLabel.text = provinceStr;
        
        if ([provinceStr isEqualToString:self.selectProvince]) {
            cell.tLabel.textColor = IKGeneralBlue;
        }
        else{
            cell.tLabel.textColor = IKRGBColor(93.0, 93.0, 93.0);
        }        
        return cell;
    }
    else{
        static  NSString *cellId=@"cityId";
        IKLocationCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell==nil){
            cell=[[IKLocationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *cityStr = [self.cityData objectAtIndex:indexPath.row];
        cell.tLabel.text = cityStr;
        
        if ([cityStr isEqualToString:self.selectCity]) {
            cell.tLabel.textColor = IKGeneralBlue;
            IKLog(@"lineView = %@",cell.lineView);
            cell.lineView.hidden = NO;
        }
        else{
            cell.tLabel.textColor = IKRGBColor(93.0, 93.0, 93.0);
            cell.lineView.hidden = YES;

        }
        
        return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IKLog(@"didSelectRowAtIndexPath  = %@",indexPath);
    if (tableView == self.provinceTableView) {
        
        IKLocationCell *cell = (IKLocationCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.tLabel.textColor = IKGeneralBlue;
        
        if (_oldProvinceIndexPath != indexPath) {
            IKLocationCell *oldCell = (IKLocationCell *)[tableView cellForRowAtIndexPath:_oldProvinceIndexPath];
            oldCell.tLabel.textColor = IKRGBColor(93.0, 93.0, 93.0);
       
            NSString *province = [self.provinceData objectAtIndex:indexPath.row];
            self.cityData = [self.baseDict objectForKey:province];
            [self.cityTableView reloadData];
        }
        
        _oldProvinceIndexPath = indexPath;
        
        [IKUSERDEFAULT setObject:cell.tLabel.text forKey:@"selectedProvince"];
        [IKUSERDEFAULT synchronize];
    }
    else{
        
        _oldCityIndexPath = indexPath;
        self.selectCity = [self.cityData objectAtIndex:indexPath.row];
        
        [self dismissSelf];
        
        if ([self.delegate respondsToSelector:@selector(locationVcDismissChangeNavButtonTitle:)]) {
            [self.delegate locationVcDismissChangeNavButtonTitle:self.selectCity];
        }
        
        [IKUSERDEFAULT setObject:self.selectCity forKey:@"selectedCity"];
        [IKUSERDEFAULT synchronize];
    }
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
    
    NSString *title = self.self.cityData[indexPath.item];
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
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)buttonViewButtonClick:(nullable UIButton *)button
{
    [self dismissSelf];
    
    if ([self.delegate respondsToSelector:@selector(locationVcDismissChangeNavButtonTitle:)]) {
        [self.delegate locationVcDismissChangeNavButtonTitle:self.selectCity];
    }
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
