//
//  IKAddSkilTypeTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/23.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKAddSkilTypeTableViewCell.h"

@interface IKAddSkilTypeTableViewCell ()

@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UILabel *valueLabel;


@end
@implementation IKAddSkilTypeTableViewCell

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
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.psLabel];
    [self.contentView addSubview:self.valueLabel];

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    [_psLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-100);
    }];
    
    
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(_psLabel.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
}

- (UILabel *)psLabel
{
    if (_psLabel == nil) {
        _psLabel = [[UILabel alloc] init];
        _psLabel.font = [UIFont systemFontOfSize:15.0f];
        _psLabel.textColor = IKSubHeadTitleColor;
//        _psLabel.text = @"添加认证/技能";
        _psLabel.textAlignment = NSTextAlignmentLeft;
//        _psLabel.backgroundColor = [UIColor redColor];
    }
    return _psLabel;
}


- (UILabel *)valueLabel
{
    if (_valueLabel == nil) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.font = [UIFont systemFontOfSize:15.0f];
        _valueLabel.textColor = IKMainTitleColor;
        _valueLabel.textAlignment = NSTextAlignmentRight;
//        _valueLabel.text = @"3~5年";
    }
    return _valueLabel;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = IKLineColor;
    }
    return _lineView;
}

- (void)setValue:(NSString *)value
{
    if (IKStringIsNotEmpty(value)) {
        _value = value;
        self.valueLabel.text = value;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
