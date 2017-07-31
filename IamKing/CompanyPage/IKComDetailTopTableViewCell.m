//
//  IKComDetailTopTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/31.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKComDetailTopTableViewCell.h"
#import "IKImageWordView.h"


@interface IKComDetailTopTableViewCell ()

@property(nonatomic,strong)UIView  *approveView;
@property(nonatomic,strong)UILabel *nickNameLabel;
@property(nonatomic,strong)UIView *approveImage;
@property(nonatomic,strong)UILabel *approveLabel;

@property(nonatomic,strong)IKImageWordView     *typeView;
@property(nonatomic,strong)IKImageWordView     *setupView;
@property(nonatomic,strong)IKImageWordView     *addressView;
@property(nonatomic,strong)IKImageWordView     *shopView;

@end

@implementation IKComDetailTopTableViewCell

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
    [self.contentView addSubview:self.nickNameLabel];
    [self.contentView addSubview:self.approveView];
    [self.contentView addSubview:self.typeView];
    [self.contentView addSubview:self.addressView];
    [self.contentView addSubview:self.setupView];
    [self.contentView addSubview:self.shopView];
}


- (void)layoutSubviews
{
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(35);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(22);
        make.width.equalTo(self.contentView).multipliedBy(0.8);
    }];
    
    [_approveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickNameLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(67);
    }];
    
    [_typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_approveView.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    [_setupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_typeView.mas_top);
        make.left.equalTo(_typeView.mas_right).offset(8);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_typeView.mas_top);
        make.left.equalTo(_setupView.mas_right).offset(8);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    [_shopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_typeView.mas_top);
        make.left.equalTo(_addressView.mas_right).offset(8);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
   
    
    [super layoutSubviews];
}


- (UILabel *)nickNameLabel
{
    if (_nickNameLabel == nil) {
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _nickNameLabel.textColor = IKMainTitleColor;
        _nickNameLabel.textAlignment = NSTextAlignmentCenter;
        _nickNameLabel.text = @"鼎盛健身";
    }
    
    return _nickNameLabel;
}

- (UIView *)approveView
{
    if (_approveView == nil) {
        _approveView = [[UILabel alloc] init];
        _approveView.layer.cornerRadius = 10;
        _approveView.layer.borderColor = IKMainTitleColor.CGColor;
        _approveView.layer.borderWidth = 1.0;
        
        [_approveView addSubview:self.approveImage];
        
        [_approveImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.equalTo(_approveView).offset(2);
            make.width.and.height.mas_equalTo(16);
        }];
        
        [_approveView addSubview:self.approveLabel];
        
        [_approveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(_approveView);
            make.left.equalTo(_approveImage.mas_right).offset(3);
            make.right.equalTo(_approveView.mas_right);
        }];
        
    }
    return _approveView;
}

- (UILabel *)approveLabel
{
    if (_approveLabel == nil) {
        _approveLabel = [[UILabel alloc] init];
        _approveLabel.text = @"未认证";
        _approveLabel.textColor = IKMainTitleColor;
        _approveLabel.textAlignment = NSTextAlignmentLeft;
        _approveLabel.font = [UIFont systemFontOfSize:11.0f];
    }
    return _approveLabel;
}


- (UIView *)approveImage
{
    if (_approveImage == nil) {
        _approveImage = [[UIView alloc] init];
        _approveImage.backgroundColor = IKMainTitleColor;
        _approveImage.layer.cornerRadius = 8;
        _approveImage.layer.masksToBounds = YES;
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IK_v"]];
        [_approveImage addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_approveImage.mas_top).offset(3);
            make.left.equalTo(_approveImage.mas_left).offset(2);
            make.right.equalTo(_approveImage.mas_right).offset(-2);
            make.bottom.equalTo(_approveImage.mas_bottom).offset(-1);
        }];
    }
    return _approveImage;
}




- (IKImageWordView *)typeView
{
    if (_typeView == nil) {
        // 地点
        _typeView = [[IKImageWordView alloc] init];
        [_typeView.imageView setImage:[UIImage imageNamed:@"IK_classify_blue"]];
        _typeView.label.text = @"俱乐部";
    }
    return _typeView;
}

- (IKImageWordView *)addressView
{
    if (_addressView == nil) {
        // 地点
        _addressView = [[IKImageWordView alloc] init];
        [_addressView.imageView setImage:[UIImage imageNamed:@"IK_address_blue"]];
        _addressView.label.text = @"杭州";

    }
    return _addressView;
}

- (IKImageWordView *)setupView
{
    if (_setupView == nil) {
        // 成立时间
        _setupView = [[IKImageWordView alloc] init];
        [_setupView.imageView setImage:[UIImage imageNamed:@"IK_experience_blue"]];
        _setupView.label.text = @"2017年成立";
    }
    return _setupView;
}


- (IKImageWordView *)shopView
{
    if (_shopView == nil) {
        // 店铺数量
        _shopView = [[IKImageWordView alloc] init];
        [_shopView.imageView setImage:[UIImage imageNamed:@"IK_store"]];
        _shopView.label.text = @"2~5家";
    }
    return _shopView;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
