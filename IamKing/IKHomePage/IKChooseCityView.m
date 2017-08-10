//
//  IKChooseCityView.m
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKChooseCityView.h"
#import "IKLocationCell.h"
#import "IKProvinceModel.h"

extern NSString * currentSelectedCityId;

@interface IKChooseCityView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSIndexPath  *_oldProvinceIndexPath;
    NSIndexPath  *_oldCityIndexPath;
}
@property (nonatomic, strong)UITableView *provinceTableView;
@property (nonatomic, strong)UITableView *cityTableView;
@property (nonatomic,copy)NSMutableArray *provinceData;
@property (nonatomic,copy)NSArray *cityData;
@property (nonatomic,   copy)NSDictionary *baseDict;
@property (nonatomic,   copy)NSString    *selectProvince;
@property (nonatomic,   copy)NSString    *selectCity;
@property (nonatomic,copy)NSMutableDictionary *cityIdDict;

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
    
//    [self plistData];
    
    [self addSubview:self.provinceTableView];
    
    
    [self addSubview:self.cityTableView];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    __weak typeof (self) weakSelf = self;

    [_provinceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.equalTo(weakSelf);
        make.width.equalTo(weakSelf).multipliedBy(0.432);
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

- (NSMutableArray *)provinceData
{
    if (_provinceData == nil) {
        _provinceData = [[NSMutableArray alloc] init];
    }
    return _provinceData;
}


- (NSArray *)cityData
{
    if (_cityData == nil) {
        _cityData = [[NSArray array] init];
    }
    
    return _cityData;
}

- (NSMutableDictionary *)cityIdDict
{
    if (_cityIdDict == nil) {
        _cityIdDict = [[NSMutableDictionary alloc] init];
    }
    return _cityIdDict;
}

- (void)setBaseProvinceData:(NSArray *)baseProvinceData
{
    if (IKArrayIsNotEmpty(baseProvinceData)) {
        _baseProvinceData = baseProvinceData;
        
        IKProvinceModel *showModel = nil;
        for (IKProvinceModel *model in baseProvinceData) {
            if ([model.provinceName isEqualToString:self.selectProvince]) {
                showModel = model;
            }
            [self.provinceData addObject:model.provinceName];
        }
        
        if (showModel == nil) {
            showModel = baseProvinceData.firstObject;
        }
        
        self.cityData = [self setCityDataWithProvince:showModel];
        
        // 默认选中的行.
        NSInteger row = [_provinceData indexOfObject:self.selectProvince];
        _oldProvinceIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
        
        if (_oldProvinceIndexPath) {
            NSInteger cRow = [_cityData indexOfObject:self.selectCity];
            _oldCityIndexPath = [NSIndexPath indexPathForRow:cRow inSection:0];
            
            
            [self.provinceTableView scrollToRowAtIndexPath:_oldProvinceIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
            [self.cityTableView scrollToRowAtIndexPath:_oldCityIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }
}

- (NSArray *)setCityDataWithProvince:(IKProvinceModel *)model
{
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:model.childCity.count];
    
    [self.cityIdDict removeAllObjects];
    
    for (int i = 0; i < model.childCity.count; i ++) {
        NSDictionary *dict = (NSDictionary *)[model.childCity objectAtIndex:i];
        NSString *city = [dict objectForKey:@"text"];
        [data addObject:city];
        NSString *cityId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"value"]];
        [self.cityIdDict setObject:cityId forKey:city];
    }
    return data;
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
        _provinceTableView.rowHeight = 0.069*IKSCREENH_HEIGHT;
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
        _cityTableView.rowHeight = 0.069*IKSCREENH_HEIGHT;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        NSString *provinceStr = [self.provinceData objectAtIndex:indexPath.row];
        cell.tLabel.text = provinceStr;
        
        if ([provinceStr isEqualToString:self.selectProvince]) {
            cell.tLabel.textColor = IKGeneralBlue;
            cell.lineView.hidden = NO;

        }
        else{
            cell.tLabel.textColor = IKMainTitleColor;
            cell.lineView.hidden = YES;

        }
        return cell;
    }
    else{
        static  NSString *cellId=@"cityId";
        IKLocationCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell==nil){
            cell=[[IKLocationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        NSString *cityStr = [self.cityData objectAtIndex:indexPath.row];
        cell.tLabel.text = cityStr;
        
        if ([cityStr isEqualToString:self.selectCity]) {
            cell.tLabel.textColor = IKGeneralBlue;
            IKLog(@"lineView = %@",cell.lineView);
            cell.lineView.hidden = NO;
        }
        else{
            cell.tLabel.textColor = IKMainTitleColor;
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
        cell.lineView.hidden = NO;
        
        if (_oldProvinceIndexPath != indexPath) {
            IKLocationCell *oldCell = (IKLocationCell *)[tableView cellForRowAtIndexPath:_oldProvinceIndexPath];
            oldCell.tLabel.textColor = IKMainTitleColor;
            oldCell.lineView.hidden = YES;
            
            IKProvinceModel *province = (IKProvinceModel *)[self.baseProvinceData objectAtIndex:indexPath.row];
            self.cityData = [self setCityDataWithProvince:province];
            [self.cityTableView reloadData];
        }
        
        _oldProvinceIndexPath = indexPath;
        
        [IKUSERDEFAULT setObject:cell.tLabel.text forKey:@"selectedProvince"];
        [IKUSERDEFAULT synchronize];
    }
    else{
        
        _oldCityIndexPath = indexPath;
        self.selectCity = [self.cityData objectAtIndex:indexPath.row];

        NSString *cityId = [self.cityIdDict objectForKey:self.selectCity];
        NSLog(@"cityId = %@",cityId);
        
        if (!self.isFromSearch) {
            [IKUSERDEFAULT setObject:self.selectCity forKey:@"selectedCity"];
            [IKUSERDEFAULT setObject:cityId forKey:@"selectedCityId"];
            [IKUSERDEFAULT synchronize];
            
            currentSelectedCityId = cityId;
        }
        
        if ([self.delegate respondsToSelector:@selector(chooseCityViewSelectedCity: cityId:)]) {
            [self.delegate chooseCityViewSelectedCity:self.selectCity cityId:cityId];
        }
        
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
