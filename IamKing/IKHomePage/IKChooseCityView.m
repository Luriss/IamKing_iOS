//
//  IKChooseCityView.m
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKChooseCityView.h"
#import "IKLocationCell.h"


@interface IKChooseCityView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSIndexPath  *_oldProvinceIndexPath;
    NSIndexPath  *_oldCityIndexPath;
}
@property (nonatomic, strong)UITableView *provinceTableView;
@property (nonatomic, strong)UITableView *cityTableView;

@property (nonatomic,copy)NSArray *provinceData;
@property (nonatomic,copy)NSArray *cityData;
@property (nonatomic,   copy)NSDictionary *baseDict;
@property (nonatomic,   copy)NSString    *selectProvince;
@property (nonatomic,   copy)NSString    *selectCity;

@end


@implementation IKChooseCityView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubviews];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubviews];
    }
    
    return self;
}


- (void)addSubviews
{
    [self configBaseData];
    
    [self plistData];
    
    [self addSubview:self.provinceTableView];
    
    [self addSubview:self.cityTableView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    __weak typeof (self) weakSelf = self;

    [_provinceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.equalTo(weakSelf);
        make.width.equalTo(weakSelf).multipliedBy(0.4);
    }];
    
    [_cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_provinceTableView);
        make.right.equalTo(weakSelf);
        make.left.equalTo(_provinceTableView.mas_right);
    }];
}

- (void)configBaseData
{
    _oldProvinceIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    _oldCityIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
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


- (void)setDelegate:(id<IKChooseCityViewDelegate>)delegate
{
    if (delegate) {
        _delegate = delegate;
    }
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

        if ([self.delegate respondsToSelector:@selector(chooseCityViewSelectedCity:)]) {
            [self.delegate chooseCityViewSelectedCity:self.selectCity];
        }
        
        [IKUSERDEFAULT setObject:self.selectCity forKey:@"selectedCity"];
        [IKUSERDEFAULT synchronize];
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
