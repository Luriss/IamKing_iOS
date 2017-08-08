//
//  IKCompanyTypeView.m
//  IamKing
//
//  Created by Luris on 2017/8/7.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyTypeView.h"



@interface IKCompanyTypeViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIView *lineView;


@end


@implementation IKCompanyTypeViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews
{
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.lineView];
}



- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:IKSubTitleFont];
        _label.textColor = IKSubHeadTitleColor;
        _label.textAlignment = NSTextAlignmentLeft;
    }
    return _label;
}


- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = IKLineColor;
        _lineView.hidden = NO;
    }
    return _lineView;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(1);
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}


@end


@interface IKCompanyTypeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic,copy)NSArray *selectData;


@end

@implementation IKCompanyTypeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubViews];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubViews];
        
    }
    
    return self;
}


- (void)addSubViews
{
    self.selectData = @[@"俱乐部",@"工作室",@"瑜伽馆",@"培训学院",@"器械设备",@"媒体资讯",@"会展/活动/赛事",@"互联网",@"其他"];
//    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 35;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.98];
    }
    NSLog(@"fraaaaaa = %@",[NSValue valueWithCGRect:_tableView.frame]);
    return _tableView;
}



- (void)setDelegate:(id<IKCompanyTypeViewDelegate>)delegate
{
    _delegate = delegate;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectData.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId = @"IKCompanyTypeViewCellId";
    IKCompanyTypeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[IKCompanyTypeViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = IKGeneralLightGray;
    cell.label.text = self.selectData[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IKCompanyTypeViewCell *cell = (IKCompanyTypeViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSString *select = cell.label.text;
    
    if ([self.delegate respondsToSelector:@selector(selectCompanyTypeViewDidSelectIndexPath:selectContent:)]) {
        [self.delegate selectCompanyTypeViewDidSelectIndexPath:indexPath selectContent:select];
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
