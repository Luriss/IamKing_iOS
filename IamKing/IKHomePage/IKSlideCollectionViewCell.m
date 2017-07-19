//
//  IKSlideCollectionViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSlideCollectionViewCell.h"

@implementation IKSlideCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    
    return self;
}


- (void)addSubviews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.lineView];

    
    __weak typeof (self) weakSelf = self;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.right.equalTo(weakSelf.contentView);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(-10);
        make.centerX.equalTo(_titleLabel);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(3);
    }];
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = IKSubHeadTitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
    }
    
    return _titleLabel;
}


- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = IKGeneralBlue;
        _lineView.hidden = YES;
    }
    return _lineView;
}

@end
