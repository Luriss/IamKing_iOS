//
//  IKCompanyProgressTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/1.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyProgressTableViewCell.h"

@interface IKCompanyProgressTableViewCell ()

@property(nonatomic,strong)UILabel *monthLabel;
@property(nonatomic,strong)UILabel *yearLabel;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *infoLabel;

@property(nonatomic,strong)UIView *circleView1;
@property(nonatomic,strong)UIView  *circleView2;
@property(nonatomic,strong)UIView  *verTopLine;
@property(nonatomic,strong)UIView  *verBottomLine;
@property(nonatomic,strong)UIView  *cellBottomLine;

@property(nonatomic,assign)BOOL  showVerTopLine;
@property(nonatomic,assign)BOOL  showVerBottomLine;


@end


@implementation IKCompanyProgressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


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
    [self.contentView addSubview:self.monthLabel];
    [self.contentView addSubview:self.yearLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.infoLabel];
    [self.contentView addSubview:self.circleView1];
    [self.contentView insertSubview:self.circleView2 aboveSubview:self.circleView2];
    [self.contentView addSubview:self.cellBottomLine];


    [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(18);
        make.left.equalTo(self.contentView).offset(20);
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(22);
    }];
    
    [_yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_monthLabel.mas_bottom);
        make.right.equalTo(_monthLabel.mas_right);
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(20);
    }];
    
    [_circleView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(23);
        make.left.equalTo(_monthLabel.mas_right).offset(13);
        make.width.and.height.mas_equalTo(14);
    }];
    
    [_circleView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_circleView1);
        make.width.and.height.mas_equalTo(9);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(18);
        make.left.equalTo(_circleView1.mas_right).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(22);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom);
        make.left.and.right.equalTo(_nameLabel);
        make.height.mas_equalTo(20);
    }];
    
    
    [_cellBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.left.equalTo(_nameLabel.mas_left);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.contentView addSubview:self.verTopLine];
    [self.contentView addSubview:self.verBottomLine];
    
    [_verTopLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.centerX.equalTo(_circleView1.mas_centerX);
        make.width.mas_equalTo(3);
        make.bottom.equalTo(_circleView1.mas_top);
    }];
    
    [_verBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_circleView1.mas_bottom);
        make.centerX.equalTo(_circleView1.mas_centerX);
        make.width.mas_equalTo(3);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}


- (UILabel *)monthLabel
{
    if (_monthLabel == nil) {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.font = [UIFont systemFontOfSize:16.0f];
        _monthLabel.textColor = IKMainTitleColor;
        _monthLabel.textAlignment = NSTextAlignmentRight;
//        _monthLabel.text = @"08/08";
    }
    
    return _monthLabel;
}

- (UILabel *)yearLabel
{
    if (_yearLabel == nil) {
        _yearLabel = [[UILabel alloc] init];
        _yearLabel.font = [UIFont systemFontOfSize:10.0f];
        _yearLabel.textColor = IKMainTitleColor;
        _yearLabel.textAlignment = NSTextAlignmentRight;
//        _yearLabel.text = @"2017年";
    }
    
    return _yearLabel;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:15.0f];
        _nameLabel.textColor = IKMainTitleColor;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
//        _nameLabel.text = @"威尔士健身";
    }
    
    return _nameLabel;
}

- (UILabel *)infoLabel
{
    if (_infoLabel == nil) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.font = [UIFont systemFontOfSize:11.0f];
        _infoLabel.textColor = IKSubHeadTitleColor;
        _infoLabel.textAlignment = NSTextAlignmentLeft;
//        _infoLabel.text = @"公司成立";
    }
    
    return _infoLabel;
}


- (UIView *)cellBottomLine
{
    if (_cellBottomLine == nil) {
        _cellBottomLine = [[UIView alloc] init];
        _cellBottomLine.backgroundColor = IKLineColor;
    }
    return _cellBottomLine;
}


- (UIView *)verBottomLine
{
    if (_verBottomLine == nil) {
        _verBottomLine = [[UIView alloc] init];
        _verBottomLine.backgroundColor = IKLineColor;
    }
    return _verBottomLine;
}

- (UIView *)verTopLine
{
    if (_verTopLine == nil) {
        _verTopLine = [[UIView alloc] init];
        _verTopLine.backgroundColor = IKLineColor;
    }
    return _verTopLine;
}

- (UIView *)circleView1
{
    if (_circleView1 == nil) {
        _circleView1 = [[UIView alloc] init];
        _circleView1.backgroundColor = [IKGeneralBlue colorWithAlphaComponent:0.3f];
        _circleView1.layer.cornerRadius = 7;
    }
    return _circleView1;
}


- (UIView *)circleView2
{
    if (_circleView2 == nil) {
        _circleView2 = [[UIView alloc] init];
        _circleView2.backgroundColor = IKGeneralBlue;
        _circleView2.layer.cornerRadius = 4.5;
    }
    return _circleView2;
}


- (void)addProgressCellData:(NSDictionary *)progress
             showVerTopLine:(BOOL )isShowVerTopLine
          showVerBottomLine:(BOOL )isShowVerBottomLine
{
    self.verTopLine.hidden = !isShowVerTopLine;
    self.verBottomLine.hidden = !isShowVerBottomLine;
    
    _nameLabel.text = [NSString stringWithFormat:@"%@",[progress objectForKey:@"title"]];
    _infoLabel.text = [NSString stringWithFormat:@"%@",[progress objectForKey:@"describe"]];
    
    NSString *time = [NSString stringWithFormat:@"%@",[progress objectForKey:@"time"]];
    
    _monthLabel.text = [NSString stringWithFormat:@"%@/%@",[time substringWithRange:NSMakeRange(4, 2)],[time substringFromIndex:6]];
    
    _yearLabel.text = [NSString stringWithFormat:@"%@年", [time substringToIndex:4]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
