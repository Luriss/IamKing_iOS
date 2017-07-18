//
//  IKSelectView.m
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSelectView.h"


@interface IKSelectTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIView *lineView;


@end


@implementation IKSelectTableViewCell

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
        _label.font = [UIFont systemFontOfSize:IKMainTitleFont];
        _label.textColor = IKSubHeadTitleColor;
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}


- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = IKGeneralBlue;
        _lineView.hidden = YES;
    }
    return _lineView;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.width.and.height.equalTo(self.contentView);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-2);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(2);
        make.width.equalTo(self.contentView).multipliedBy(0.7);
    }];
}


@end



@interface IKSelectView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSIndexPath *oldIndexPath;


@end

@implementation IKSelectView


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
    self.oldIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
    }
    
    return _tableView;
}



- (void)setDelegate:(id<IKSelectViewDelegate>)delegate
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
    return 50;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId = @"IKSelectTableViewCellId";
    IKSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[IKSelectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.label.text = self.selectData[indexPath.row];
    if (indexPath.row == 0) {
        cell.label.textColor = IKGeneralBlue;
        cell.lineView.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *select = nil;
    if (indexPath != self.oldIndexPath) {
        IKSelectTableViewCell *cell = (IKSelectTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.label.textColor = IKGeneralBlue;
        cell.lineView.hidden = NO;
        select = cell.label.text;
        
        IKSelectTableViewCell *oldCell = (IKSelectTableViewCell *)[tableView cellForRowAtIndexPath:self.oldIndexPath];
        oldCell.label.textColor = IKSubHeadTitleColor;
        oldCell.lineView.hidden = YES;
        self.oldIndexPath = indexPath;
    }
    
    if ([self.delegate respondsToSelector:@selector(selectViewDidSelect:)]) {
        [self.delegate selectViewDidSelect:select];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}















/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
