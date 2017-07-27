//
//  IKDetailTitleTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/26.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKDetailTitleTableViewCell.h"


@interface IKDetailTitleTableViewCell ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UIView  *bottomLineView;

@end


@implementation IKDetailTitleTableViewCell

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
    [self.contentView addSubview:self.imageview];
    
    
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.left.equalTo(_imageview.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(26);
    }];
    
    [self.contentView addSubview:self.bottomLineView];
    
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
        _titleLabel.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
        _titleLabel.textColor = IKMainTitleColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _titleLabel;
}


- (UIImageView *)imageview
{
    if (_imageview == nil) {
        _imageview = [[UIImageView alloc] init];
    }
    return _imageview;
}


- (UIView *)bottomLineView
{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = IKLineColor;
    }
    return _bottomLineView;
}

- (void)setTitleType:(IKDetailTitleType)titleType
{
    switch (titleType) {
        case IKDetailTitleTypeSkill:
        {
            [_imageview setImage:[UIImage imageNamed:@"IK_certificate"]];
            _titleLabel.text = @"专业认证/技能要求";
            break;
        }
        case IKDetailTitleTypeResumeDetail:
        {
            [_imageview setImage:[UIImage imageNamed:@"IK_jobDetail"]];
            _titleLabel.text = @"职位详情";
            break;
        }
        case IKDetailTitleTypeWorkAddress:
        {
            [_imageview setImage:[UIImage imageNamed:@"IK_address_blue"]];
            _titleLabel.text = @"工作地点";
            break;
        }
        case IKDetailTitleTypeInterViewAssessment:
        {
            [_imageview setImage:[UIImage imageNamed:@"IK_assessment"]];
            _titleLabel.text = @"面试评价";
            break;
        }

        default:
            break;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
