//
//  IKSettingNomalTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSettingNomalTableViewCell.h"


@interface IKSettingNomalTableViewCell ()

@property (nonatomic, strong)UIImageView *arrowImage;
@property (nonatomic, strong)UIView *lineView;


@end

@implementation IKSettingNomalTableViewCell

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
    [self.contentView addSubview:self.arrowImage];
    [self.contentView addSubview:self.psLabel];

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    

    [_arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.and.height.mas_equalTo(18);
    }];
    
    
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView .mas_left).offset(20);
        make.width.mas_equalTo(120);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [_psLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.contentView);
        make.left.equalTo(_label.mas_right).offset(5);
        make.right.equalTo(_arrowImage.mas_left).offset(-5);
    }];
}



- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:13.0f];
        _label.textColor = IKSubHeadTitleColor;
        _label.textAlignment = NSTextAlignmentLeft;
//        _label.backgroundColor = [UIColor redColor];
    }
    return _label;
}

- (UILabel *)psLabel
{
    if (_psLabel == nil) {
        _psLabel = [[UILabel alloc] init];
        _psLabel.font = [UIFont systemFontOfSize:13.0f];
        _psLabel.textColor = IKSubHeadTitleColor;
        _psLabel.textAlignment = NSTextAlignmentRight;
//        _psLabel.backgroundColor = [UIColor yellowColor];

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


- (UIImageView *)arrowImage
{
    if (_arrowImage == nil) {
        _arrowImage = [[UIImageView alloc] init];
        [_arrowImage setImage:[UIImage imageNamed:@"IK_arrow_right"]];
    }
    return _arrowImage;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
