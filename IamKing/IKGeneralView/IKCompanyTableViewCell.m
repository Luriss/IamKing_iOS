//
//  IKCompanyTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyTableViewCell.h"

@interface IKCompanyTableViewCell ()

@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)UILabel     *titleLabel;
@property(nonatomic,strong)IKImageWordView     *setupView;
@property(nonatomic,strong)IKImageWordView     *addressView;
@property(nonatomic,strong)IKImageWordView     *numberStoreView;
@property(nonatomic,strong)IKImageWordView     *numberJobView;

@property(nonatomic,strong)UILabel     *introduceLabel;
@property(nonatomic,strong)UIView      *maskView;
@property(nonatomic,strong)UIView      *bottomLine;


@end


@implementation IKCompanyTableViewCell

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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutCellSubviews];
}

- (void)initSubViews
{
    [self.contentView addSubview:self.logoImageView];
    [self.contentView addSubview:self.titleLabel];
//    [self.contentView addSubview:self.salaryLabel];
    [self.contentView addSubview:self.maskView];
    [self.contentView addSubview:self.setupView];
    [self.contentView addSubview:self.addressView];
    [self.contentView addSubview:self.numberStoreView];
    [self.contentView addSubview:self.introduceLabel];
    [self.contentView addSubview:self.numberJobView];
    [self.contentView addSubview:self.bottomLine];
    
}


#pragma mark - Property

- (UIImageView *)logoImageView
{
    if (_logoImageView == nil) {
        // 头像
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height - 10, self.bounds.size.height - 10)];
        _logoImageView.contentMode = UIViewContentModeScaleToFill;
        _logoImageView.layer.borderWidth = 1.0;
        _logoImageView.layer.borderColor = IKGeneralLightGray.CGColor;
        _logoImageView.layer.cornerRadius = 5;
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
    }
    return _titleLabel;
}

//- (UILabel *)salaryLabel
//{
//    if (_salaryLabel == nil) {
//        // 薪水
//        _salaryLabel = [[UILabel alloc] init];
//        _salaryLabel.textAlignment = NSTextAlignmentLeft;
//        _salaryLabel.font = [UIFont boldSystemFontOfSize:13.0f];
//        _salaryLabel.layer.backgroundColor = IKRGBColor(246.0, 101.0, 101.0).CGColor;
//        _salaryLabel.textColor = [UIColor whiteColor];
//    }
//    return _salaryLabel;
//}

- (UIView *)maskView
{
    if (_maskView == nil) {
        _maskView = [[UIView alloc] init];
        _maskView.layer.backgroundColor = IKRGBColor(246.0, 101.0, 101.0).CGColor;
        _maskView.layer.cornerRadius = 10;
    }
    return _maskView;
}

- (IKImageWordView *)addressView
{
    if (_addressView == nil) {
        // 地点
        _addressView = [[IKImageWordView alloc] init];
    }
    return _addressView;
}

- (IKImageWordView *)setupView
{
    if (_setupView == nil) {
        // 成立时间
        _setupView = [[IKImageWordView alloc] init];
    }
    return _setupView;
}


- (IKImageWordView *)numberStoreView
{
    if (_numberStoreView == nil) {
        // 店面数量
        _numberStoreView = [[IKImageWordView alloc] init];
    }
    return _numberStoreView;
}

- (UILabel *)introduceLabel
{
    if (_introduceLabel == nil) {
        //介绍
        _introduceLabel = [[UILabel alloc] init];
        _introduceLabel.textAlignment = NSTextAlignmentCenter;
        _introduceLabel.font = [UIFont boldSystemFontOfSize:11.0f];
        _introduceLabel.textColor = IKRGBColor(164.0, 164.0, 164.0);
        _introduceLabel.numberOfLines = 0;
    }
    return _introduceLabel;
}

- (IKImageWordView *)numberJobView
{
    if (_numberJobView == nil) {
        _numberJobView = [[IKImageWordView alloc] init];
        _numberJobView.label.font = [UIFont boldSystemFontOfSize:13.0f];
        _numberJobView.label.textColor = IKGeneralBlue;
        
    }
    return _numberJobView;
}

- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = IKGeneralLightGray;
    }
    return _bottomLine;
}


- (void)layoutCellSubviews
{
    __weak typeof (self) weakSelf = self;
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(5);
        make.left.equalTo(weakSelf).offset(10);
        //        make.bottom.equalTo(self).offset(-5);
        make.width.and.height.mas_equalTo(weakSelf.bounds.size.height - 10);
    }];
    
//    [_salaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf).offset(8);
//        make.right.equalTo(weakSelf);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(70);
//    }];
    
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(8);
        make.right.equalTo(weakSelf).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(90);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(8);
        make.left.equalTo(_logoImageView.mas_right).offset(9);
        make.height.mas_equalTo(20);
        make.right.equalTo(_maskView.mas_left);
    }];
    
    
    [_setupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(1);
        make.left.equalTo(_titleLabel);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(20);
    }];
    
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_setupView);
        make.width.mas_equalTo(70);
        make.left.equalTo(_setupView.mas_right).offset(2);
    }];
    
    [_numberStoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_addressView);
        make.left.equalTo(_addressView.mas_right).offset(2);
        make.right.equalTo(weakSelf);
    }];
    
    
    [_introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_setupView.mas_bottom);
        make.left.equalTo(_titleLabel);
        make.bottom.equalTo(_numberJobView.mas_top);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
    }];
    
    [_numberJobView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.bottom.equalTo(weakSelf.contentView).offset(-5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(25);
    }];
    
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(1);
        make.top.equalTo(weakSelf.mas_bottom).offset(-1);
    }];
}



- (void)addCellData:(IKCompanyInfoModel *)model
{
    [self.logoImageView lwb_loadImageWithUrl:model.logoImageUrl placeHolderImageName:nil radius:5.0];
    
    self.titleLabel.text = model.title;

    [self.addressView.imageView setImage:[UIImage imageNamed:@"IK_address_blue"]];
    self.addressView.label.text = @"乌鲁木齐";
    
    [self.numberStoreView.imageView setImage:[UIImage imageNamed:@"IK_store"]];
    self.numberStoreView.label.text = model.numberOfStore;
    
    [self.setupView.imageView setImage:[UIImage imageNamed:@"IK_time_blue"]];
    self.setupView.label.text = model.setupTime;
    self.introduceLabel.text = model.introduce;
    
    [self.numberJobView.imageView setImage:[UIImage imageNamed:@"IK_job_blue"]];
    self.numberJobView.label.text = model.numberOfJob;
    
    [self addStarToMaskView:model.evaluate];
    
}


- (void)addStarToMaskView:(NSInteger )evaluate
{
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(5 + 14 * i, 3, 14, 14)];
        if (i < evaluate) {
            [image setImage:[UIImage imageNamed:@"IK_star_solid"]];
        }
        else{
            [image setImage:[UIImage imageNamed:@"IK_star_hollow"]];
        }
        [_maskView addSubview:image];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
