//
//  IKSettingView.m
//  IamKing
//
//  Created by Luris on 2017/8/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSettingView.h"
#import "IKSettingTableViewCell.h"
#import "IKSettingHeaderTableViewCell.h"

extern NSString *loginUserType;


@interface IKSettingView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIButton *arrowBtn;

@property(nonatomic, copy)NSArray       *imageNameArray;
@property(nonatomic, copy)NSArray       *titleArray;
@property(nonatomic, assign)BOOL         isCompanyVersion;

@end

@implementation IKSettingView

-(instancetype)init
{
    self = [super initWithFrame:CGRectMake(20, 0, IKSCREEN_WIDTH - 40, 300)];
    if (self) {
        
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
    [self setResourceData];
    [self addSubview:self.tableView];
    
    [self addSubview:self.arrowBtn];

    [_arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(self.mas_top).offset(24);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(44);
    }];
    
}

- (void)setDictionary:(NSDictionary *)dictionary
{
    NSLog(@"dictionary = %@",dictionary);
    if (IKDictIsNotEmpty(dictionary)) {
        _dictionary = dictionary;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}


- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
        _tableView.bounces = NO;
    }
    return _tableView;
}


- (UIButton *)arrowBtn
{
    if (_arrowBtn == nil) {
        
        _arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrowBtn addTarget:self action:@selector(arrowButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _arrowBtn.frame = CGRectMake(0, 0, 60, 44);
        //        _arrowBtn.backgroundColor = [UIColor redColor];
        _arrowBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 40, 10, -4);
        [_arrowBtn setImage:[UIImage imageNamed:@"IK_arrow_right_white"] forState:UIControlStateNormal];
        [_arrowBtn setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_arrow_right_white"] forState:UIControlStateHighlighted];
    }
    return _arrowBtn;
}


- (void)setResourceData
{
    NSLog(@"loginUserType = %@",loginUserType);
    if ([loginUserType isEqualToString:@"0"]) {
        self.imageNameArray = @[@"IK_dealResume",@"IK_managerJob",@"IK_star_hollow_grey",@"IK_companyInfo",@"IK_companyconfirm",@"IK_setting"];
        self.titleArray = @[@"简历处理",@"职位管理",@"收藏简历",@"公司信息",@"公司认证",@"我的设置"];
        _isCompanyVersion = YES;
    }
    else{
        self.imageNameArray = @[@"IK_myResume",@"IK_jobprocess",@"IK_star_hollow_grey",@"IK_companyInfo",@"IK_setting"];
        self.titleArray = @[@"我的简历",@"求职进度",@"收藏职位",@"关注公司",@"我的设置"];
        _isCompanyVersion = NO;
        
    }
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.titleArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 250;
    }
    else{
        return 55;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static  NSString *cellId = @"IKSettingHeaderTableViewCellId";
        IKSettingHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKSettingHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
        }
        [cell addSettingHeaderTableViewCellData:self.dictionary];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    else{
        static  NSString *cellId = @"IKSettingTableViewCellId";
        IKSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
        }

        cell.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
        [cell settingCellAddData:self.titleArray[indexPath.row - 1] imageName:self.imageNameArray[indexPath.row - 1]];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row != 0) {
        if ([self.delegate respondsToSelector:@selector(tableViewDidSelectRowAtIndexPath:)]) {
            [self.delegate tableViewDidSelectRowAtIndexPath:indexPath];
        }
    }
    
}



- (void)arrowButtonClick:(UIButton *)button
{
    NSLog(@"arrowButtonClick");
    
    if ([self.delegate respondsToSelector:@selector(tableViewDidSelectRowAtIndexPath:)]) {
        [self.delegate tableViewDidSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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
