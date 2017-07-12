//
//  IKInfoTableView.m
//  IamKing
//
//  Created by Luris on 2017/7/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKInfoTableView.h"
#import "IKInfoTableViewCell.h"

@interface IKInfoTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIButton *leftHeaderBtn;
@property (nonatomic,strong)UIButton *rightHeaderBtn;
@property (nonatomic,assign)IKTableViewHeaderSelectedButton *headerSelectedBtn;
@property (nonatomic,strong)IKJobInfoModel *model;

@end



@implementation IKInfoTableView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initTableView];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initTableView];

    }
    
    return self;
}



- (void)initTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    _model = [[IKJobInfoModel alloc] init];
    _model.logoImageUrl = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646722_1456498424671_800x600.jpg";
    _model.title = @"高级营销总监";
    _model.salary = @"13~18k";
    _model.address = @"杭州";
    _model.experience = @"6~8年";
    _model.education = @"本科";
    _model.skill1 = @"销售能手好";
    _model.skill2 = @"NAFC";
    _model.skill3 = @"形象好";
    _model.introduce = @"时尚连锁健身俱乐部品牌,致力于提供超乎想象的健身运动体验.在江浙沪,拥有36家直营店铺.时尚连锁健身俱乐部品牌,致力于提供超乎想象的健身运动体验.在江浙沪,拥有36家直营店铺.";
}

- (void)setDelegate:(id<IKInfoTableViewDelegate>)delegate
{
    _delegate = delegate;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId=@"IKInfoCellId";
    IKInfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];

    if(cell==nil)
    {
        cell=[[IKInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];

    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 1) {
        _model.logoImageUrl = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646649_1456498410838_800x600.jpg";
    }
    [cell addCellData:_model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(infoTableView:didSelectRowAtIndexPath:)]) {
        [self.delegate infoTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat btnWidth = tableView.frame.size.width*0.5;
    
    UIView *view = [[UIView alloc] init];
    
    // 默认选中 Btn1
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.tag = IKTableViewHeaderSelectedButtonLeft;
    [btn1 setTitle:_leftHeaderButtonTitle forState:UIControlStateNormal];
    [btn1 setTitleColor:IKRGBColor(71.0, 190.0, 255.0) forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //选中放大效果
    btn1.transform = CGAffineTransformMakeScale(1.05, 1.05);
    
    [view addSubview:btn1];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(view);
        make.left.equalTo(view);
        make.width.mas_equalTo(btnWidth - 10);
    }];
    
    _leftHeaderBtn = btn1;
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.tag = IKTableViewHeaderSelectedButtonRight;
    [btn2 setTitle:_rightHeaderButtonTitle forState:UIControlStateNormal];
    [btn2 setTitleColor:IKRGBColor(155.0, 155.0, 155.0) forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];;
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:btn2];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(view);
        make.right.equalTo(view);
        make.width.equalTo(btn1);
    }];
    
    _rightHeaderBtn = btn2;
    
    UIImageView *exImage = [[UIImageView alloc] init];
    [exImage setImage:[UIImage imageNamed:@"IK_exchange"]];
    [view addSubview:exImage];
    
    [exImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(btn2.mas_left);
        make.left.equalTo(btn1.mas_right);
        make.width.and.height.mas_equalTo(20);
    }];
    
    return view;
}


- (void)btnClick:(UIButton *)button
{
    if (button.tag == IKTableViewHeaderSelectedButtonLeft) {
        [_leftHeaderBtn setTitleColor:IKRGBColor(71.0, 190.0, 255.0) forState:UIControlStateNormal];
        [_rightHeaderBtn setTitleColor:IKRGBColor(155.0, 155.0, 155.0) forState:UIControlStateNormal];
        _leftHeaderBtn.transform = CGAffineTransformMakeScale(1.05, 1.05);
        _rightHeaderBtn.transform = CGAffineTransformIdentity;
        
        if ([self.delegate respondsToSelector:@selector(tableViewHeaderLeftButtonClick:)]) {
            [self.delegate tableViewHeaderLeftButtonClick:button];
        }
    }
    else{
        [_leftHeaderBtn setTitleColor:IKRGBColor(155.0, 155.0, 155.0) forState:UIControlStateNormal];
        [_rightHeaderBtn setTitleColor:IKRGBColor(71.0, 190.0, 255.0) forState:UIControlStateNormal];
        _rightHeaderBtn.transform = CGAffineTransformMakeScale(1.05, 1.05);
        _leftHeaderBtn.transform = CGAffineTransformIdentity;
        
        if ([self.delegate respondsToSelector:@selector(tableViewHeaderRightButtonClick:)]) {
            [self.delegate tableViewHeaderRightButtonClick:button];
        }
    }
}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
