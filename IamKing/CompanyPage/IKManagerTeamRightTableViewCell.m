//
//  IKManagerTeamRightTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/1.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKManagerTeamRightTableViewCell.h"
#import "IKLabel.h"


@interface IKManagerTeamRightTableViewCell ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)UIView  *bottomLineView;
@property(nonatomic,strong)UILabel *jobLabel;
@property(nonatomic,strong)IKLabel *contentLabel;

@end


@implementation IKManagerTeamRightTableViewCell

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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.jobLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.bottomLineView];
    
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(26);
        make.right.equalTo(self.contentView.mas_right).offset(-21);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-26);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.368);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(35);
        make.right.equalTo(_imageV.mas_left).offset(-21);
        make.left.equalTo(self.contentView.mas_left).offset(21);
        make.height.mas_equalTo(24);
    }];
    
    
    [_jobLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(_titleLabel.mas_right);
        make.height.equalTo(_titleLabel);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_jobLabel.mas_bottom).offset(35);
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(_titleLabel.mas_right);
        make.bottom.equalTo(_imageV.mas_bottom);
    }];
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(1);
    }];
}



- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _titleLabel.textColor = IKGeneralBlue;
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.text = @"苏格拉底";
    }
    
    return _titleLabel;
}

- (UILabel *)jobLabel
{
    if (_jobLabel == nil) {
        _jobLabel = [[UILabel alloc] init];
        _jobLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        _jobLabel.textColor = IKMainTitleColor;
        _jobLabel.textAlignment = NSTextAlignmentRight;
        _jobLabel.text = @"创始人兼执行总裁";
    }
    
    return _jobLabel;
}

- (IKLabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[IKLabel alloc] init];
        _contentLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        _contentLabel.textColor = IKSubHeadTitleColor;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.backgroundColor = IKGeneralLightGray;
        _contentLabel.numberOfLines = 0;
    }
    
    return _contentLabel;
}
- (UIImageView *)imageV
{
    if (_imageV == nil) {
        _imageV = [[UIImageView alloc] init];
        _imageV.layer.cornerRadius = 10;
        _imageV.layer.masksToBounds = YES;
        _imageV.backgroundColor = IKGeneralLightGray;
    }
    return _imageV;
}


- (UIView *)bottomLineView
{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = IKLineColor;
    }
    return _bottomLineView;
}


- (void)managerTeamCellAddData:(IKCompanyManagerTeamModel *)model
{
    _titleLabel.text = model.name;
    _jobLabel.text = model.workPosition;
    _contentLabel.text = model.describe;
    _contentLabel.backgroundColor = [UIColor clearColor];
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.headerImageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
