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

@interface IKChooseCityVC ()<UITableViewDelegate,UITableViewDataSource,IKButtonViewDelegate>
{
    NSIndexPath  *_oldProvinceIndexPath;
    NSIndexPath  *_oldCityIndexPath;
}
@property (nonatomic, strong)IKView *bottomView;
@property (nonatomic, strong)IKView *locationInfoView;
@property (nonatomic, strong)IKButtonView *confirmView;
@property (nonatomic, strong)UITableView *provinceTableView;
@property (nonatomic, strong)UITableView *cityTableView;
@property (nonatomic,   copy)NSDictionary *baseDict;
@property (nonatomic,   copy)NSString    *selectProvince;
@property (nonatomic,   copy)NSString    *selectCity;

@end

@implementation IKChooseCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self configBaseData];
    
    [self plistData];

    [self addSubViews];
    
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showBottomView];
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



- (void)addSubViews
{
    // 底部 view 主要是实现切换动画 (取巧)
    [self.view addSubview:self.bottomView];
    [self hideBottomView]; //初始化后隐藏
    
    // 所有的 子 view 都建议添加在bottomView上避免影响动画.
    
    // 定位信息 view.
    [_bottomView addSubview:self.locationInfoView];
    
    [_bottomView addSubview:self.provinceTableView];
    
    [_bottomView addSubview:self.cityTableView];
    
}
#pragma mark - Property Get

- (IKView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[IKView alloc] initWithFrame:self.view.frame];
        _bottomView.backgroundColor = [UIColor clearColor];
    }
    
    return _bottomView;
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
    tipLabel.textColor = IKGeneralGray;
    tipLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [_locationInfoView addSubview:tipLabel];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.text = @"杭州";
    addressLabel.textColor = IKGeneralBlue;
    addressLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    addressLabel.textAlignment = NSTextAlignmentCenter;
    [_locationInfoView addSubview:addressLabel];
    
    UILabel *pinyinLabel = [[UILabel alloc] init];
    pinyinLabel.text = @"Hangzhou";
    pinyinLabel.textColor = IKGeneralBlue;
    pinyinLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    pinyinLabel.textAlignment = NSTextAlignmentCenter;
    [_locationInfoView addSubview:pinyinLabel];
    
    IKButtonView *confirmView = [[IKButtonView alloc] init];
    confirmView.title = @"确定";
    confirmView.cornerRadius = 18;
    confirmView.borderColor = IKRGBColor(93.0, 93.0, 93.0);
    confirmView.HighBorderColor = IKRGBColor(47.0, 181.0, 255.0);
    confirmView.borderWidth = 1;
    confirmView.needAnimation = YES;
    confirmView.delegate = self;
    [_locationInfoView addSubview:confirmView];
    
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationInfoView).offset(3);
        make.left.and.right.equalTo(_locationInfoView);
        make.height.mas_equalTo(30);
    }];
    
    [confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_locationInfoView);
        make.bottom.equalTo(_locationInfoView).offset(-15);
        make.height.mas_equalTo(36);
        make.width.mas_offset(200);
    }];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom);
        make.left.and.right.equalTo(_locationInfoView);
        make.height.mas_equalTo(40);
    }];
    
    [pinyinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLabel.mas_bottom).offset(-10);
        make.left.and.right.equalTo(_locationInfoView);
        make.height.mas_equalTo(30);
    }];
}


#pragma mark - Layout View

- (void)layoutCustomView
{
    [_locationInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.mas_equalTo(150);
    }];
    
    [_provinceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationInfoView.mas_bottom);
        make.left.and.bottom.equalTo(self.view);
        make.width.mas_equalTo(IKSCREEN_WIDTH *0.4);
    }];
    
    [_cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_provinceTableView);
        make.right.equalTo(self.view);
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
        
        [self dismissSelf:nil];
        
        if ([self.delegate respondsToSelector:@selector(locationVcDismissChangeNavButtonTitle:)]) {
            [self.delegate locationVcDismissChangeNavButtonTitle:self.selectCity];
        }
        
        [IKUSERDEFAULT setObject:self.selectCity forKey:@"selectedCity"];
        [IKUSERDEFAULT synchronize];
    }
}


#pragma mark - BottomView

- (void)hideBottomView
{
    _bottomView.transform = CGAffineTransformMakeTranslation(0, -IKSCREENH_HEIGHT);
}

- (void)showBottomView
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _bottomView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];

}

- (void)dismissSelf:(void(^)(NSString *location))block
{
    block?block(_selectCity):@"";
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _bottomView.transform = CGAffineTransformMakeTranslation(0, -IKSCREENH_HEIGHT);
    } completion:^(BOOL finished) {
        [_bottomView removeFromSuperview];
        _bottomView = nil;
        
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }];
    
}

- (void)buttonViewButtonClick:(nullable UIButton *)button
{
    [self dismissSelf:nil];
    
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
