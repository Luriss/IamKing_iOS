//
//  IKTagsCollectionViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTagsCollectionViewCell.h"

@implementation IKTagsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.layer.cornerRadius = 5;
        _titleLabel.layer.borderColor = IKRGBColor(213, 213, 213).CGColor;
        _titleLabel.layer.borderWidth = 1;
        _titleLabel.textColor = IKRGBColor(58, 58, 58);
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
        
        __weak typeof (self) weakSelf = self;

        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.contentView);
        }];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
}


- (void)setHighlightLabel:(BOOL )highlightLabel
{
    if (highlightLabel) {
        _titleLabel.textColor = IKGeneralBlue;
        _titleLabel.layer.borderColor = IKGeneralBlue.CGColor;
    }
    else{
        _titleLabel.layer.borderColor = IKRGBColor(213, 213, 213).CGColor;
        _titleLabel.textColor = IKRGBColor(58, 58, 58);
    }
}


- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.titleLabel.text = @"";
}

@end
