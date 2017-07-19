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


@interface IKEvaluationTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UIView *maskView;

- (void)setStarViewWithStarNumber:(NSInteger )starNumber highlight:(BOOL )isHighlight;


@end

@implementation IKEvaluationTableViewCell


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
    [self.contentView addSubview:self.maskView];
}



- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:IKMainTitleFont];
        _label.textColor = IKSubHeadTitleColor;
        _label.textAlignment = NSTextAlignmentLeft;
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

- (UIView *)maskView
{
    if (_maskView == nil) {
        //遮盖 薪水左边的圆角
        _maskView = [[UIView alloc] init];
    }
    return _maskView;
}

- (void)setStarViewWithStarNumber:(NSInteger )starNumber highlight:(BOOL )isHighlight
{
    NSArray *arr = @[@"很差",@"较差",@"一般",@"较好",@"很棒"];
    _label.text = [arr objectAtIndex:starNumber-1];
    
    UIImage *solidImage = nil;
    UIImage *hollowImage = nil;
    if (isHighlight) {
        solidImage = [UIImage imageNamed:@"IK_star_solid_blue"];
        hollowImage = [UIImage imageNamed:@"IK_star_hollow_blue"];
    }
    else{
        solidImage = [UIImage imageNamed:@"IK_star_solid_grey"];
        hollowImage = [UIImage imageNamed:@"IK_star_hollow_grey"];
    }
    
    [self addStarToMaskView:solidImage hollowImage:hollowImage solidImageNumber:starNumber];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(120);
    }];
    
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_maskView.mas_right);
        make.top.and.bottom.and.right.equalTo(self.contentView);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-2);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(2);
        make.width.equalTo(self.contentView).multipliedBy(0.7);
    }];
}


- (void)addStarToMaskView:(UIImage *)solidImage
              hollowImage:(UIImage *)hollowImage
         solidImageNumber:(NSInteger )number
{
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(5 + 18 * i, 16, 18, 18)];

        if (i < number) {
            [image setImage:solidImage];
        }
        else{
            [image setImage:hollowImage];
        }
        [_maskView addSubview:image];
    }
}



@end


@interface IKSelectView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic,copy)NSArray *selectData;


@end

@implementation IKSelectView


- (instancetype)initWithFrame:(CGRect)frame Type:(IKSelectedSubType)type
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.type = type;
        [self addSubViews];
    }
    
    return self;
}

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
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        [self addSubview:_tableView];
    }
    
    return _tableView;
}



- (void)setDelegate:(id<IKSelectViewDelegate>)delegate
{
    _delegate = delegate;
}


- (void)setType:(IKSelectedSubType)type
{
    self.selectData  = nil;
    _type = type;
    switch (type) {
        case IKSelectedSubTypeJobAddress:
            break;
            
        case IKSelectedSubTypeJobCompanyType:
            self.selectData = @[@"不限",@"俱乐部",@"工作室",@"瑜伽馆",@"教育培训",@"器械设备",@"媒体资讯",@"会展/活动/赛事",@"互联网",@"其他"];
            break;
            
        case IKSelectedSubTypeJobSalary:
            self.selectData = @[@"不限",@"3~5k",@"6~8k",@"9~12k",@"13~18k",@"19~25k",@"26~30k",@"31~40k",@"41~50k",@"如果职位薪资与实际面试薪资不一致,可举报!"];
            break;
            
        case IKSelectedSubTypeJobExperience:
            self.selectData = @[@"不限",@"1年以下",@"1~2年",@"3~5年",@"6~8年",@"8~10年",@"10年以上"];
            break;
            
        case IKSelectedSubTypeCompanyType:
            self.selectData = @[@"不限",@"俱乐部",@"工作室",@"瑜伽馆",@"教育培训",@"器械设备",@"媒体资讯",@"会展/活动/赛事",@"互联网",@"其他"];
            break;
            
        case IKSelectedSubTypeCompanyNumberOfStore:
            self.selectData = @[@"不限",@"1家",@"2~5家",@"6~10家",@"11~20家",@"21~35家",@"36~50家",@"51~80家",@"81~100家",@"100家以上"];
            break;
            
        case IKSelectedSubTypeCompanyDirectlyToJoin:
            self.selectData = @[@"不限",@"直营",@"加盟",@"直营+加盟"];
            break;
            
        case IKSelectedSubTypeCompanyEvaluation:
            self.selectData = @[@"不限",@"5",@"4",@"3",@"2",@"1"];
            break;
            
        default:
            break;
    }
}


- (void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath
{
    if (selectedIndexPath) {
        _selectedIndexPath = selectedIndexPath;
    }
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

    if (self.type == IKSelectedSubTypeCompanyEvaluation && indexPath.row != 0) {
        static  NSString *cellId = @"IKSelectTableViewCellId";
        IKEvaluationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKEvaluationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        if (indexPath == self.selectedIndexPath) {
            cell.label.textColor = IKGeneralBlue;
            [cell setStarViewWithStarNumber:[self.selectData[indexPath.row] integerValue] highlight:YES];
            cell.lineView.hidden = NO;
        }
        else{
            [cell setStarViewWithStarNumber:[self.selectData[indexPath.row] integerValue] highlight:NO];
        }
        
        return cell;
    }
    else{
        static  NSString *cellId = @"IKSelectTableViewCellId";
        IKSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[IKSelectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        cell.label.text = self.selectData[indexPath.row];
        if (indexPath == self.selectedIndexPath) {
            cell.label.textColor = IKGeneralBlue;
            cell.lineView.hidden = NO;
        }
        return cell;   
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IKSelectTableViewCell *cell = (IKSelectTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

    NSString *select = cell.label.text;
    
    if ([self.delegate respondsToSelector:@selector(selectViewDidSelectIndexPath:selectContent:)]) {
        [self.delegate selectViewDidSelectIndexPath:indexPath selectContent:select];
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
