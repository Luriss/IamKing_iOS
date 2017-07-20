//
//  IKLocationCell.m
//  IamKing
//
//  Created by Luris on 2017/7/12.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKLocationCell.h"

@interface IKLocationCell ()



@end

@implementation IKLocationCell

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

- (UILabel *)tLabel
{
    if (_tLabel == nil) {
        // 标题 省/ 城市
        _tLabel = [[UILabel alloc] init];
        _tLabel.textAlignment = NSTextAlignmentCenter;
        _tLabel.font = [UIFont systemFontOfSize:14.0f];
        _tLabel.textColor = IKRGBColor(93.0, 93.0, 93.0);
    }
    return _tLabel;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UILabel alloc] init];
        
        _lineView.hidden = YES;
        _lineView.backgroundColor = IKGeneralBlue;
    }
    
    return _lineView;
}

- (void)initSubViews
{
    [self.contentView addSubview:self.tLabel];
    [self.contentView addSubview:self.lineView];
}


- (void)layoutCellSubviews
{
    __weak typeof (self) weakSelf = self;

    [_tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.contentView);
        make.width.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(CGRectGetHeight(weakSelf.contentView.frame)*0.7);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_tLabel.mas_bottom).offset(-5);
        make.centerX.equalTo(_tLabel);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(2);
    }];
}


- (void)layoutSubviews
{
    [self layoutCellSubviews];
    
    [super layoutSubviews];
}

- (void)setTitle:(NSString *)title
{
    if (IKStringIsNotEmpty(title)) {
        _tLabel.text = title;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

//    IKLog(@"selected = %d",selected);
    
//    if (selected) {
//        _tLabel.textColor = IKGeneralBlue;
//    }
//    else{
//        _titleLabel.textColor = IKRGBColor(93.0, 93.0, 93.0);
//
//    }
    // Configure the view for the selected state
}

@end
