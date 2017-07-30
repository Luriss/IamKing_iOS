//
//  IKCompanyClassifyView.m
//  IamKing
//
//  Created by Luris on 2017/7/30.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyClassifyView.h"


@interface IKCompanyClassifyCell : UITableViewCell

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIView *lineView;


@end


@implementation IKCompanyClassifyCell

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


@interface IKCompanyClassifyView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic,copy)NSArray *selectData;


@end

@implementation IKCompanyClassifyView

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
    self.selectData = @[@"全部公司",@"俱乐部",@"工作室",@"瑜伽馆",@"培训学院",@"器械设备",@"媒体资讯",@"会展/活动/赛事",@"互联网",@"其他"];
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tableView];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.tableView.frame), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-CGRectGetHeight(self.tableView.frame))];
    
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    [self addSubview:view];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 45 * self.selectData.count) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 45;
        _tableView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
        [self addSubview:_tableView];
    }
    
    return _tableView;
}



- (void)setDelegate:(id<IKCompanyClassifyViewDelegate>)delegate
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
    static  NSString *cellId = @"IKCompanyClassifyCellId";
    IKCompanyClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[IKCompanyClassifyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.label.text = self.selectData[indexPath.row];
    if (indexPath == self.selectedIndexPath) {
        cell.label.textColor = IKMainTitleColor;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IKCompanyClassifyCell *cell = (IKCompanyClassifyCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSString *select = cell.label.text;
    
    if ([self.delegate respondsToSelector:@selector(selectViewDidSelectIndexPath:selectContent:)]) {
        [self.delegate selectViewDidSelectIndexPath:indexPath selectContent:select];
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
