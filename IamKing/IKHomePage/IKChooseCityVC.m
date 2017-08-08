//
//  IKChooseCityVC.m
//  IamKing
//
//  Created by Luris on 2017/7/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKChooseCityVC.h"
#import "IKTagsCollectionViewCell.h"
#import "IKChooseCityView.h"
#import "IKTagsView.h"
#import "IKHotCityModel.h"
#import "IKProvinceModel.h"
#import "IKLocationManager.h"


static NSString * const reuseIdentifier = @"hotCityCollectionViewCellId";
static NSString * const headerReuseIdentifier = @"IKCollectionViewHeader";

NSString * currentSelectedCityId;


@interface IKChooseCityVC ()<IKChooseCityViewDelegate,IKTagsViewDelegate>

@property (nonatomic, strong)IKView *locationInfoView;
@property (nonatomic,strong) IKChooseCityView *chooseCity;
@property (nonatomic,strong) IKTagsView *tag;

@property (nonatomic,   copy)NSDictionary *baseDict;
@property (nonatomic,copy)NSMutableArray *provinceData;
@property (nonatomic,copy)NSArray *cityData;

@end

@implementation IKChooseCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavView];
//    [self plistData];

//    [self initHotCityView];
    [self addSubViews];

    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *city = [[IKLocationManager shareInstance] getLocationCity];
    
    if (IKStringIsNotEmpty(city)) {
        UIButton *button = (UIButton *)[_locationInfoView viewWithTag:10010];
        [button setTitle:city forState:UIControlStateNormal];
    }
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)setHotCity:(NSArray *)hotCity
{
    if (IKArrayIsNotEmpty(hotCity)) {
        
        _hotCity = hotCity;
        
    }
}


- (void)setBaseProvinceData:(NSArray *)baseProvinceData
{
    if (IKArrayIsNotEmpty(baseProvinceData)) {
        _baseProvinceData = baseProvinceData;
    }
}


- (void)initTagsView
{
    _tag = [[IKTagsView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    [self.view addSubview:_tag ];

    __weak typeof (self) weakSelf = self;

    [_tag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(_locationInfoView.mas_bottom);
        make.height.mas_equalTo(CGRectGetHeight(_tag.frame));
    }];
    
//    tag.backgroundColor = [UIColor cyanColor];
    _tag.delegate = self;
    _tag.lineSpacing = 23.0;
    _tag.verticalSpacing = 20;
    _tag.tagHeight = 25;
    _tag.title = @"热门城市";
    _tag.titleColor = IKMainTitleColor;
    _tag.tagBorderWidth = 1;
    _tag.tagBorderColor = IKSubHeadTitleColor;
    _tag.tagCornerRadius = _tag.tagHeight *0.5;
    _tag.tagTitleColor = IKSubHeadTitleColor;
    _tag.tagFont = IKSubTitleFont;
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:_hotCity.count];
    for (IKHotCityModel *model in _hotCity) {
        [array addObject:model.cityName];
    }
    _tag.data = [array copy];
    [_tag createViewAdjustViewFrame:^(CGRect newFrame) {
        NSLog(@"newFrame = %@",[NSValue valueWithCGRect:newFrame]);
        [_tag mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.view);
            make.top.equalTo(_locationInfoView.mas_bottom);
            make.height.mas_equalTo(CGRectGetHeight(newFrame));
        }];
    }];
}

- (void)initNavView
{
    // 返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 60, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(14, 0, 14, 44);
    [button setImage:[UIImage imageNamed:@"IK_close"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_close"] forState:UIControlStateHighlighted];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"城市切换";
    title.textColor = IKMainTitleColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    
    self.navigationItem.titleView = title;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 1)];
    lineView.backgroundColor = IKLineColor;
    
    [self.view addSubview:lineView];
}


- (void)addSubViews
{
    // 定位信息 view.
    [self.view addSubview:self.locationInfoView];
    
    [self initTagsView];

    _chooseCity = [[IKChooseCityView alloc] init];
    _chooseCity.delegate = self;
    _chooseCity.baseProvinceData = self.baseProvinceData;
    [self.view addSubview:_chooseCity];
    
    __weak typeof (self) weakSelf = self;
    
    [_locationInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(1);
        make.height.mas_equalTo(0.137*IKSCREENH_HEIGHT);
    }];
    
    [_chooseCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tag.mas_bottom);
        make.left.and.right.and.bottom.equalTo(weakSelf.view);
    }];
    

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
    [button setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [button setTitle:@"全国" forState:UIControlStateNormal];
    button.tag = 10010;
    button.layer.cornerRadius = 0.038*IKSCREENH_HEIGHT*0.5;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = IKGeneralBlue.CGColor;
    button.layer.borderWidth = 1;
    [button setBackgroundImage:IKButtonClickBgImage forState:UIControlStateHighlighted];
    [_locationInfoView addSubview:button];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = IKLineColor;
    [_locationInfoView addSubview:view];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationInfoView).offset(0.024*IKSCREENH_HEIGHT);
        make.left.and.right.equalTo(_locationInfoView);
        make.height.mas_equalTo(0.023*IKSCREENH_HEIGHT);
    }];
    
    CGSize stringSize = [NSString getSizeWithString:@"全国" size:CGSizeMake(IKSCREEN_WIDTH,0.038*IKSCREENH_HEIGHT) attribute:@{NSFontAttributeName : [UIFont systemFontOfSize:15.0f]}];

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_locationInfoView);
        make.bottom.equalTo(_locationInfoView).offset(-20);
        make.height.mas_equalTo(0.038*IKSCREENH_HEIGHT);
        make.width.mas_offset(stringSize.width + 30);
    }];
    
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_locationInfoView);
        make.bottom.equalTo(_locationInfoView).offset(1);
        make.height.mas_equalTo(1);
    }];
}


#pragma mark - Layout View


- (void)relayoutCustomView
{
    __weak typeof (self) weakSelf = self;
    
    [_tag mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(_locationInfoView.mas_bottom);
        make.height.mas_equalTo(CGRectGetHeight(_tag.frame));
    }];
    
    [_chooseCity mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tag.mas_bottom);
        make.left.and.right.and.bottom.equalTo(weakSelf.view);
    }];
}


- (void)chooseCityViewSelectedCity:(NSString *)city
{
    IKLog(@"chooseCityViewSelectedCity");
    
    [self dismissSelfWithCity:city];
}

- (void)tagViewDidSelectedTagWithTitle:(NSString *)title selectedIndex:(NSUInteger)index
{
    NSLog(@"tagViewDidSelectedTagWithTitle = %@ index = %ld",title,index);
    [IKUSERDEFAULT removeObjectForKey:@"selectedProvince"];
    [IKUSERDEFAULT setObject:title forKey:@"selectedCity"];
    
    IKHotCityModel *model = [_hotCity objectAtIndex:index];
    NSLog(@"cityName = %@",model.cityName);
    if ([model.cityName isEqualToString:title]) {
        [IKUSERDEFAULT setObject:model.regionID forKey:@"selectedCityId"];
        currentSelectedCityId = model.regionID;
    }
    
    [IKUSERDEFAULT synchronize];
    
    
    IKLog(@"self.selectProvince = %@,self.selectCity = %@",[IKUSERDEFAULT objectForKey:@"selectedCity"],[IKUSERDEFAULT objectForKey:@"selectedProvince"]);
    
    [self dismissSelfWithCity:title];
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
    NSString * cityId = [[IKLocationManager shareInstance] getLocationCityId];
    [IKUSERDEFAULT setObject:button.titleLabel.text forKey:@"selectedCity"];
    [IKUSERDEFAULT setObject:cityId forKey:@"selectedCityId"];
    [IKUSERDEFAULT synchronize];
    
    currentSelectedCityId = cityId;
    
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
