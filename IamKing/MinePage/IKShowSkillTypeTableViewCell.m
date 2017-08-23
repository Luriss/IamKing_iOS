//
//  IKShowSkillTypeTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/23.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKShowSkillTypeTableViewCell.h"

@interface IKShowSkillTypeTableViewCell ()

@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UILabel *valueLabel;


@end
@implementation IKShowSkillTypeTableViewCell

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
        make.right.equalTo(self.contentView.mas_right).offset(-200);
    }];
    
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_psLabel.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(26);
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
        _valueLabel.textColor = IKGeneralBlue;
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.layer.cornerRadius = 13.0f;
        _valueLabel.layer.borderColor = IKGeneralBlue.CGColor;
        _valueLabel.layer.borderWidth = 1.0f;
        
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
        
        CGSize size = [NSString getSizeWithString:value size:CGSizeMake(IKSCREEN_WIDTH - 240, 30) attribute:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}];
        [_valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(26);
            make.width.mas_equalTo(size.width + 20);
        }];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
