//
//  IKAddCertTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKAddCertTableViewCell.h"


@interface IKAddCertTableViewCell ()

@property (nonatomic, strong)UIImageView *logoImageView;


@end
@implementation IKAddCertTableViewCell

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
    NSLog(@"height = %.0f",self.frame.size.height);
    [self.contentView addSubview:self.lineView];
    [_lineView addSubview:self.logoImageView];
    [_lineView addSubview:self.psLabel];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.centerX.equalTo(self.contentView.mas_centerX).offset(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lineView.mas_left);
        make.centerY.equalTo(_lineView.mas_centerY);
        make.width.and.height.mas_equalTo(20);
    }];
    
    [_psLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.mas_top);
        make.bottom.equalTo(_lineView.mas_bottom);
        make.left.equalTo(_logoImageView.mas_right);
        make.right.equalTo(_lineView.mas_right);
    }];
    
}

- (UIImageView *)logoImageView
{
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] init];
        [_logoImageView setImage:[UIImage imageNamed:@"IK_Add_blue"]];
    }
    return _logoImageView;
}


- (UILabel *)psLabel
{
    if (_psLabel == nil) {
        _psLabel = [[UILabel alloc] init];
        _psLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _psLabel.textColor = IKSubHeadTitleColor;
        _psLabel.text = @"上传证书";
        _psLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _psLabel;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
    }
    return _lineView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
