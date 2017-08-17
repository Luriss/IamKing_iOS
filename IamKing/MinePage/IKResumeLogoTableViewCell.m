//
//  IKResumeLogoTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/16.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKResumeLogoTableViewCell.h"


@interface IKResumeLogoTableViewCell ()

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIImageView *logoImage;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UILabel *psLabel;


@end
@implementation IKResumeLogoTableViewCell

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
    [self.contentView addSubview:self.logoImage];
    [self.contentView addSubview:self.psLabel];
    
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.and.height.mas_equalTo(60);
    }];

    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(7);
        make.left.equalTo(_logoImage.mas_right).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(25);
    }];
    
    [_psLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label.mas_bottom).offset(5);
        make.left.equalTo(_label.mas_left);
        make.right.equalTo(_label.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}



- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont boldSystemFontOfSize:16.0f];
        _label.textColor = IKSubHeadTitleColor;
        _label.text = @"简历头像";
        _label.textAlignment = NSTextAlignmentLeft;
    }
    return _label;
}


- (UILabel *)psLabel
{
    if (_psLabel == nil) {
        _psLabel = [[UILabel alloc] init];
        _psLabel.font = [UIFont systemFontOfSize:13.0f];
        _psLabel.textColor = IKSubHeadTitleColor;
        _psLabel.textAlignment = NSTextAlignmentLeft;
        _psLabel.numberOfLines = 2;
        _psLabel.text = @"请上传求职者本人真实、清晰的照片\n建议尺寸:360*360像素";
    }
    return _psLabel;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = IKLineColor;
        _lineView.hidden = NO;
    }
    return _lineView;
}

- (UIImageView *)logoImage
{
    if (_logoImage == nil) {
        _logoImage = [[UIImageView alloc] init];
        _logoImage.backgroundColor = IKGeneralLightGray;
        _logoImage.layer.cornerRadius = 6;
    }
    return _logoImage;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
