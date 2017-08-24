//
//  IKSchoolTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSchoolTableViewCell.h"

@interface IKSchoolTableViewCell ()

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIImageView *logoImage;
@property (nonatomic, strong)UIView *lineView;


@end
@implementation IKSchoolTableViewCell

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
    
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.and.height.mas_equalTo(28);
    }];
    
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(_logoImage.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
}



- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:15.0f];
        _label.textColor = IKMainTitleColor;
        _label.text = @"简历头像";
        _label.textAlignment = NSTextAlignmentLeft;
    }
    return _label;
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
        _logoImage.layer.cornerRadius = 3;
    }
    return _logoImage;
}


- (void)addSchoolTableViewCellData:(IKSchoolListModel *)model
{
    [self.logoImage lwb_loadImageWithUrl:[model.logoImageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] placeHolderImageName:nil radius:5];
    
    self.label.text = model.name;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
