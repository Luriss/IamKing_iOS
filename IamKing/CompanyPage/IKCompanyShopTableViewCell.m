//
//  IKCompanyShopTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/1.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyShopTableViewCell.h"
#import "IKImageWordView.h"

#define IKSikllLabelWidth (70)



@interface IKCompanyShopTableViewCell ()

@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)UIImageView *authImageView;
@property(nonatomic,strong)UILabel     *titleLabel;
@property(nonatomic,strong)UIView  *bottomLineView;

@property(nonatomic,strong)IKImageWordView     *addressView;
@property(nonatomic,strong)IKImageWordView     *shopTypeView;
@property(nonatomic,strong)IKImageWordView     *squareView;
@property(nonatomic,strong)IKImageWordView     *memberView;
@property(nonatomic,strong)IKImageWordView     *needjobView;


@end


@implementation IKCompanyShopTableViewCell

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
    [self.contentView addSubview:self.logoImageView];
    [self.contentView insertSubview:self.authImageView aboveSubview:self.logoImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.addressView];
    [self.contentView addSubview:self.shopTypeView];
    [self.contentView addSubview:self.squareView];
    [self.contentView addSubview:self.memberView];
    [self.contentView addSubview:self.needjobView];
    [self.contentView addSubview:self.bottomLineView];
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(6);
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-6);
        make.width.equalTo(self.contentView).multipliedBy(0.408);
    }];
    
    
    [_authImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoImageView.mas_top);
        make.left.equalTo(_logoImageView.mas_left);
        make.width.and.height.mas_equalTo(ceilf(IKSCREENH_HEIGHT * 0.07));
    }];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(_logoImageView.mas_right).offset(13);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.contentView.mas_right).offset(2);
    }];
    
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(6);
        make.left.equalTo(_titleLabel.mas_left);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(70);
    }];
    
    [_shopTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressView.mas_top);
        make.left.equalTo(_addressView.mas_right).offset(2);
        make.bottom.equalTo(_addressView.mas_bottom);
        make.right.equalTo(_titleLabel.mas_right);
    }];
    
    [_squareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressView.mas_bottom);
        make.left.equalTo(_addressView.mas_left);
        make.height.equalTo(_addressView.mas_height);
        make.width.equalTo(_addressView.mas_width);
    }];
    
    [_memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_squareView.mas_top);
        make.left.equalTo(_shopTypeView.mas_left);
        make.bottom.equalTo(_squareView.mas_bottom);
        make.right.equalTo(_shopTypeView.mas_right);
    }];
    
    [_needjobView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_squareView.mas_bottom).offset(6);
        make.left.equalTo(_titleLabel.mas_left);
        make.height.mas_equalTo(25);
        make.width.equalTo(_titleLabel.mas_width);

    }];
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(1);
    }];
}


#pragma mark - Property

- (UIView *)bottomLineView
{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = IKLineColor;
    }
    return _bottomLineView;
}

- (UIImageView *)logoImageView
{
    if (_logoImageView == nil) {
        // 头像
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.contentMode = UIViewContentModeScaleToFill;
        _logoImageView.backgroundColor = IKGeneralLightGray;
        _logoImageView.layer.cornerRadius = 6;
        _logoImageView.layer.masksToBounds = YES;
    }
    return _logoImageView;
}


- (UIImageView *)authImageView
{
    if (_authImageView == nil) {
        _authImageView = [[UIImageView alloc] init];
        _authImageView.contentMode = UIViewContentModeScaleToFill;
//        _authImageView.hidden = YES;
    }
    
    return _authImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        // 标题
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _titleLabel.textColor = IKMainTitleColor;
        _titleLabel.backgroundColor = IKGeneralLightGray;
    }
    return _titleLabel;
}



- (IKImageWordView *)addressView
{
    if (_addressView == nil) {
        // 地点
        _addressView = [[IKImageWordView alloc] init];
        [_addressView.imageView setImage:[UIImage imageNamed:@"IK_address_blue"]];
        _addressView.backgroundColor = IKGeneralLightGray;
    }
    return _addressView;
}

- (IKImageWordView *)shopTypeView
{
    if (_shopTypeView == nil) {
        //
        _shopTypeView = [[IKImageWordView alloc] init];
        [_shopTypeView.imageView setImage:[UIImage imageNamed:@"IK_circle_blue"]];
        _shopTypeView.backgroundColor = IKGeneralLightGray;
    }
    return _shopTypeView;
}


- (IKImageWordView *)squareView
{
    if (_squareView == nil) {
        // 
        _squareView = [[IKImageWordView alloc] init];
        [_squareView.imageView setImage:[UIImage imageNamed:@"IK_square_blue"]];
        _squareView.backgroundColor = IKGeneralLightGray;
    }
    return _squareView;
}

- (IKImageWordView *)memberView
{
    if (_memberView == nil) {
        _memberView = [[IKImageWordView alloc] init];
        [_memberView.imageView setImage:[UIImage imageNamed:@"IK_member_blue"]];
        _memberView.backgroundColor = IKGeneralLightGray;
    }
    return _memberView;
}

- (IKImageWordView *)needjobView
{
    if (_needjobView == nil) {
        _needjobView = [[IKImageWordView alloc] init];
        _needjobView.label.font = [UIFont systemFontOfSize:13.0f];
        _needjobView.label.textColor = IKGeneralBlue;
        [_needjobView.imageView setImage:[UIImage imageNamed:@"IK_job_blue"]];
        _needjobView.backgroundColor = IKGeneralLightGray;
    }
    return _needjobView;
}


// 设置 cell 卡片样式
//- (void)setFrame:(CGRect)frame //重写frame.
//{
//    frame.origin.x = 10;
//    frame.origin.y += 7;
//    frame.size.width -= 20;
//    frame.size.height -= 14;
//    
//    [super setFrame:frame];
//}




- (void)addCompanyShopCellData:(IKCompanyShopNumModel *)model
{
    self.titleLabel.text = model.name;
    _titleLabel.backgroundColor = [UIColor whiteColor];
     self.addressView.label.text = model.workCity;
    _addressView.backgroundColor = [UIColor whiteColor];

    self.shopTypeView.label.text = model.shopTypeName;
    _shopTypeView.backgroundColor = [UIColor whiteColor];

 
    self.squareView.label.text = model.area;
    _squareView.backgroundColor = [UIColor whiteColor];


    self.memberView.label.text = model.numberOfMember;
    _memberView.backgroundColor = [UIColor whiteColor];


    self.needjobView.label.text = model.inviteNum;
    _needjobView.backgroundColor = [UIColor whiteColor];

    if (model.isBusiness) {
        [_authImageView setImage:[UIImage imageNamed:@"IK_businessStore"]];
    }
    else{
        [_authImageView setImage:[UIImage imageNamed:@"IK_presellStore"]];
    }
    
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.logoImageUrl] completed:nil];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
