//
//  IKAttentionListTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKAttentionListTableViewCell.h"
#import "IKImageWordView.h"

@interface IKAttentionListTableViewCell ()

@property(nonatomic,strong)UILabel *nickNameLabel;
@property(nonatomic,strong)UIImageView *headerImageview;

@property(nonatomic,strong)UIView  *approveView;
@property(nonatomic,strong)UILabel *appraiseLabel;
@property(nonatomic,strong)UIView  *maskView;
@property(nonatomic,strong)UIView  *jobNumberView;
@property(nonatomic,strong)UILabel *jobNumberLabel;
@property(nonatomic,strong)UILabel *approveLabel;
@property(nonatomic,strong)UIImageView *approveImage;
@property(nonatomic,strong)UIImageView *arrowImageview;
@property(nonatomic,strong)UIView  *bottomLine;
@property(nonatomic,strong)UIView  *middleLine;
@property(nonatomic,strong)UIButton *cancelAttention;


@property(nonatomic,strong)IKImageWordView     *addressView;
@property(nonatomic,strong)IKImageWordView     *setupView;
@property(nonatomic,strong)IKImageWordView     *shopView;


@end


@implementation IKAttentionListTableViewCell

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
    [self.contentView addSubview:self.headerImageview];
    [self.contentView addSubview:self.approveView];
    [self.contentView addSubview:self.addressView];
    [self.contentView addSubview:self.setupView];
    [self.contentView addSubview:self.shopView];
    [self.contentView addSubview:self.appraiseLabel];
    [self.contentView addSubview:self.maskView];
    [self.contentView addSubview:self.jobNumberView];
    [self.contentView addSubview:self.arrowImageview];
    [self.contentView addSubview:self.bottomLine];
    [self.contentView addSubview:self.middleLine];
    [self.contentView addSubview:self.cancelAttention];
    
    [self layoutCustomSubviews];
}


- (void)layoutCustomSubviews
{
    [_headerImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.and.height.mas_equalTo(90);
    }];
    
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(_headerImageview.mas_right).offset(15);
        make.height.mas_equalTo(22);
        make.right.equalTo(_approveView.mas_left).offset(-10);
    }];
    
    [_approveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(67);
    }];
    
    
    [_setupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickNameLabel.mas_bottom).offset(2);
        make.left.equalTo(_nickNameLabel.mas_left);
        make.height.mas_equalTo(20);
    }];
    
    [_appraiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_setupView.mas_bottom).offset(2);
        make.left.equalTo(_nickNameLabel.mas_left);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_appraiseLabel.mas_top);
        make.left.equalTo(_appraiseLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    
    [_jobNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_appraiseLabel.mas_bottom).offset(4);
        make.left.equalTo(_nickNameLabel.mas_left);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
    
    
    [_arrowImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.width.and.height.mas_equalTo(22);
    }];
    
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerImageview.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    
    [_cancelAttention mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleLine.mas_bottom).offset(7);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(35);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(1);
    }];
}

- (UILabel *)nickNameLabel
{
    if (_nickNameLabel == nil) {
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _nickNameLabel.textColor = IKMainTitleColor;
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _nickNameLabel;
}


- (UIImageView *)headerImageview
{
    if (_headerImageview == nil) {
        _headerImageview = [[UIImageView alloc] init];
        _headerImageview.backgroundColor = IKGeneralLightGray;
        _headerImageview.layer.cornerRadius = 5;
        _headerImageview.layer.masksToBounds = YES;
        _headerImageview.layer.borderColor = IKGeneralLightGray.CGColor;
        _headerImageview.layer.borderWidth = 1;
    }
    return _headerImageview;
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

- (UIImageView *)approveImage
{
    if (_approveImage == nil) {
        _approveImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IK_graybackground"]];
        _approveImage.layer.cornerRadius = 8;
        _approveImage.layer.masksToBounds = YES;
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IK_v"]];
        [_approveImage addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_approveImage.mas_top).offset(3);
            make.left.equalTo(_approveImage.mas_left).offset(3);
            make.right.equalTo(_approveImage.mas_right).offset(-3);
            make.bottom.equalTo(_approveImage.mas_bottom).offset(-3);
        }];
    }
    return _approveImage;
}

- (UIView *)approveView
{
    if (_approveView == nil) {
        _approveView = [[UIView alloc] init];
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

- (IKImageWordView *)addressView
{
    if (_addressView == nil) {
        // 地点
        _addressView = [[IKImageWordView alloc] init];
        [_addressView.imageView setImage:[UIImage imageNamed:@"IK_address_blue"]];
    }
    return _addressView;
}

- (IKImageWordView *)setupView
{
    if (_setupView == nil) {
        // 成立时间
        _setupView = [[IKImageWordView alloc] init];
        [_setupView.imageView setImage:[UIImage imageNamed:@"IK_experience_blue"]];
    }
    return _setupView;
}


- (IKImageWordView *)shopView
{
    if (_shopView == nil) {
        // 店铺数量
        _shopView = [[IKImageWordView alloc] init];
        [_shopView.imageView setImage:[UIImage imageNamed:@"IK_store"]];
    }
    return _shopView;
}


- (UILabel *)jobNumberLabel
{
    if (_jobNumberLabel == nil) {
        _jobNumberLabel = [[UILabel alloc] init];
        _jobNumberLabel.textColor = IKGeneralBlue;
        _jobNumberLabel.textAlignment = NSTextAlignmentLeft;
        _jobNumberLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    }
    return _jobNumberLabel;
}

- (UIView  *)jobNumberView
{
    if (_jobNumberView == nil) {
        // 店铺数量
        _jobNumberView = [[UIView alloc] init];
        
        UIImageView  *imageV = [[UIImageView alloc] init];
        imageV.image = [UIImage imageNamed:@"IK_job_blue"];
        [_jobNumberView addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_jobNumberView.mas_top);
            make.left.equalTo(_jobNumberView.mas_left);
            make.width.and.height.equalTo(_jobNumberView.mas_height);
        }];
        
        [_jobNumberView addSubview:self.jobNumberLabel];
        
        [_jobNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_jobNumberView.mas_top);
            make.left.equalTo(imageV.mas_right).offset(7);
            make.right.equalTo(_jobNumberView.mas_right);
            make.bottom.equalTo(_jobNumberView.mas_bottom);
        }];
    }
    return _jobNumberView;
}

- (UILabel *)appraiseLabel
{
    if (_appraiseLabel == nil) {
        _appraiseLabel = [[UILabel alloc] init];
        _appraiseLabel.textColor = IKMainTitleColor;
        _appraiseLabel.font = [UIFont systemFontOfSize:13.0f];
        _appraiseLabel.textAlignment = NSTextAlignmentLeft;
        _appraiseLabel.text = @"公司评价: ";
    }
    return _appraiseLabel;
}

- (UIView *)maskView
{
    if (_maskView == nil) {
        _maskView = [[UIView alloc] init];
    }
    return _maskView;
}


- (UIImageView *)arrowImageview
{
    if (_arrowImageview == nil) {
        _arrowImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IK_back"]];
        _arrowImageview.transform = CGAffineTransformMakeRotation(M_PI);
    }
    return _arrowImageview;
}


- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = IKLineColor;
    }
    return _bottomLine;
}


- (UIButton *)cancelAttention
{
    if (_cancelAttention == nil) {
        _cancelAttention = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelAttention.backgroundColor = IKGeneralBlue;
        [_cancelAttention setTitle:@"取消关注" forState:UIControlStateNormal];
        [_cancelAttention setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelAttention.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [_cancelAttention setBackgroundImage:IKButtonBlueBgImgae forState:UIControlStateNormal];
        [_cancelAttention setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
        _cancelAttention.layer.cornerRadius = 6;
        _cancelAttention.layer.masksToBounds = YES;
        [_cancelAttention addTarget:self action:@selector(cancelAttentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelAttention;
}


- (UIView *)middleLine
{
    if (_middleLine == nil) {
        _middleLine = [[UIView alloc] init];
        _middleLine.backgroundColor = IKLineColor;
    }
    return _middleLine;
}


- (void)cancelAttentionButtonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(cancelAttentionButtonClickWithCell:)]) {
        [self.delegate cancelAttentionButtonClickWithCell:self];
    }
}



- (void)addAttentionListCellData:(IKAttentionCompanyModel *)model
{
    [_headerImageview lwb_loadImageWithUrl:model.headerImageUrl placeHolderImageName:nil radius:6];
    
    _nickNameLabel.text = model.nickName;
    
    self.setupView.label.text = model.setupYear;
    
    CGFloat setupWidth = [NSString getSizeWithString:self.setupView.label.text size:CGSizeMake(MAXFLOAT, 20) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:IKSubTitleFont]}].width;
    
    setupWidth = (setupWidth > 60)?60:setupWidth;
    [_setupView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickNameLabel.mas_bottom).offset(2);
        make.left.equalTo(_nickNameLabel.mas_left);
        make.width.mas_equalTo(setupWidth + 25);
        make.height.mas_equalTo(20);
    }];
    
    
    self.addressView.label.text = model.cityName;
    
    CGFloat addressWidth = [NSString getSizeWithString:self.addressView.label.text size:CGSizeMake(MAXFLOAT, 20) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:IKSubTitleFont]}].width;
    
    addressWidth = (addressWidth > 60)?60:addressWidth;
    [_addressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_setupView.mas_top);
        make.left.equalTo(_setupView.mas_right).offset(5);
        make.width.mas_equalTo(addressWidth + 10);
        make.height.mas_equalTo(20);
    }];
    
    self.shopView.label.text = model.product;
    CGFloat shopWidth = [NSString getSizeWithString:self.shopView.label.text size:CGSizeMake(MAXFLOAT, 20) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:IKSubTitleFont]}].width;
    shopWidth = (shopWidth > 60)?60:shopWidth;
    
    [_shopView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_setupView.mas_top);
        make.left.equalTo(_addressView.mas_right).offset(2);
        make.width.mas_equalTo(shopWidth + 5);
        make.height.mas_equalTo(20);
    }];
    
    NSInteger starNumber = [model.appraiseNum integerValue];
    [self addStarToMaskView:starNumber];
    
    
    _jobNumberLabel.text = [NSString stringWithFormat:@"%@个 在招职位",model.workNum];
    
    if (model.isApproveOffcial) {
        _approveView.layer.borderColor = IKGeneralBlue.CGColor;
//        _approveImage.backgroundColor = IKGeneralBlue;
        _approveLabel.text = @"已认证";
        _approveLabel.textColor = IKGeneralBlue;
    }
    else{
        _approveView.layer.borderColor = IKMainTitleColor.CGColor;
//        _approveImage.backgroundColor = IKGeneralBlue;
        _approveLabel.text = @"未认证";
        _approveLabel.textColor = IKMainTitleColor;
    }
}


- (void)addStarToMaskView:(NSInteger )evaluate
{
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(3 + 14 * i, 3, 14, 14)];
        if (i < evaluate) {
            [image setImage:[UIImage imageNamed:@"IK_star_solid_red"]];
        }
        else{
            [image setImage:[UIImage imageNamed:@"IK_star_hollow_red"]];
        }
        [_maskView addSubview:image];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
