//
//  IKTypeTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTypeTableViewCell.h"


@interface IKTypeTableViewCell ()

@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)UIImageView *arrowView;

@property(nonatomic,strong)UILabel     *titleLabel;
@property(nonatomic,strong)UILabel     *introduceLabel;
@property(nonatomic,strong)UIView      *bottomLine;


@end


@implementation IKTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    [self.contentView addSubview:self.logoImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.introduceLabel];
    [self.contentView addSubview:self.arrowView];
    [self.contentView addSubview:self.bottomLine];
    
    self.arrowView.transform = CGAffineTransformMakeRotation(M_PI);
    
    __weak typeof (self) weakSelf = self;
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(23);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.and.height.mas_equalTo(25);
    }];
    
    
    [_arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_logoImageView);
        make.width.and.height.mas_equalTo(20);
        make.right.equalTo(weakSelf.contentView).offset(-20);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(20);
        make.left.equalTo(_logoImageView.mas_right).offset(13);
        make.height.mas_equalTo(20);
        make.right.equalTo(_arrowView.mas_left).offset(-5);
    }];
    
    CGFloat va = 0;
    
    if (iPhone5SE) {
        va = 10;
    }
    else{
        va = 20;
    }
    [_introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(-va);
        make.left.and.right.and.height.equalTo(_titleLabel);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(1);
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.height.mas_equalTo(1);
    }];
    
}


- (UIImageView *)logoImageView
{
    if (_logoImageView == nil) {
        // 头像
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _logoImageView.contentMode = UIViewContentModeScaleToFill;
//        _logoImageView.backgroundColor = [UIColor redColor];
    }
    return _logoImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        // 标题
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
        _titleLabel.textColor = IKMainTitleColor;
//        _titleLabel.backgroundColor = [UIColor blueColor];
    }
    return _titleLabel;
}

- (UILabel *)introduceLabel
{
    if (_introduceLabel == nil) {
        //介绍
        _introduceLabel = [[UILabel alloc] init];
        _introduceLabel.textAlignment = NSTextAlignmentLeft;
        _introduceLabel.font = [UIFont boldSystemFontOfSize:IKSubTitleFont];
        _introduceLabel.textColor = IKSubHeadTitleColor;
//        _introduceLabel.backgroundColor = [UIColor greenColor];
        _introduceLabel.numberOfLines = 0;
    }
    return _introduceLabel;
}


- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        // 头像
        _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _arrowView.contentMode = UIViewContentModeScaleToFill;
//        _arrowView.transform = 
        [_arrowView setImage:[UIImage imageNamed:@"IK_back"]];
    }
    return _arrowView;
}

- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = IKLineColor;
    }
    return _bottomLine;
}


- (void)addCellDataWithLogo:(NSString *)logoName data:(IKJobTypeModel *)model
{
    [self.logoImageView setImage:[UIImage imageNamed:logoName]];
    
    self.titleLabel.text = model.JobName;
    self.introduceLabel.text = model.describe;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
