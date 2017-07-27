//
//  IKWorkAddressTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/27.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKWorkAddressTableViewCell.h"


@interface IKWorkAddressTableViewCell ()

@property(nonatomic,strong)UILabel *shopNameLabel;
@property(nonatomic,strong)UILabel *shopAddressLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UIView  *lineView;

@end


@implementation IKWorkAddressTableViewCell

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
    [self.contentView addSubview:self.shopNameLabel];
    [self.contentView addSubview:self.shopAddressLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.imageview];
    
    [_shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.width.equalTo(self.contentView).multipliedBy(0.67);
        make.height.mas_equalTo(25);
    }];
    
    [_shopAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopNameLabel.mas_bottom);
        make.left.equalTo(_shopNameLabel.mas_left);
        make.width.equalTo(_shopNameLabel);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(IKSCREEN_WIDTH * 0.78);
        make.width.mas_equalTo(1);
        make.height.equalTo(self.contentView).multipliedBy(0.4);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lineView.mas_right).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(12);
        make.height.mas_equalTo(16);
    }];
    
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-10);
        make.centerX.equalTo(_addressLabel.mas_centerX);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
}

- (UILabel *)shopNameLabel
{
    if (_shopNameLabel == nil) {
        _shopNameLabel = [[UILabel alloc] init];
        _shopNameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _shopNameLabel.textColor = IKGeneralBlue;
        _shopNameLabel.textAlignment = NSTextAlignmentLeft;
//        _shopNameLabel.backgroundColor = [UIColor redColor];
    }
    
    return _shopNameLabel;
}


- (UILabel *)shopAddressLabel
{
    if (_shopAddressLabel == nil) {
        _shopAddressLabel = [[UILabel alloc] init];
        _shopAddressLabel.font = [UIFont systemFontOfSize:12.0f];
        _shopAddressLabel.textColor = IKMainTitleColor;
        _shopAddressLabel.textAlignment = NSTextAlignmentLeft;
        _shopAddressLabel.numberOfLines = 2;
//        _shopAddressLabel.backgroundColor = [UIColor redColor];
    }
    
    return _shopAddressLabel;
}


- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = IKLineColor;
    }
    return _lineView;
}

- (UILabel *)addressLabel
{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"地图";
        _addressLabel.font = [UIFont systemFontOfSize:12.0f];
        _addressLabel.textColor = IKSubHeadTitleColor;
        _addressLabel.textAlignment = NSTextAlignmentCenter;
//        _addressLabel.backgroundColor = [UIColor redColor];

    }
    return _addressLabel;
}

- (UIImageView *)imageview
{
    if (_imageview == nil) {
        _imageview = [[UIImageView alloc] init];
        [_imageview setImage:[UIImage imageNamed:@"IK_address_grey"]];
    }
    return _imageview;
}


- (void)setShopName:(NSString *)shopName
{
    if (IKStringIsNotEmpty(shopName)) {
        _shopNameLabel.text = shopName;
    }
}

- (void)setShopAddress:(NSString *)shopAddress
{
    if (IKStringIsNotEmpty(shopAddress)) {
        _shopAddressLabel.text = shopAddress;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
