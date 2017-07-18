//
//  IKImageWordView.m
//  IamKing
//
//  Created by Luris on 2017/7/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKImageWordView.h"


@interface IKImageWordView ()




@end

@implementation IKImageWordView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}


- (void)initSubviews
{
    UIImageView *imageV = [[UIImageView alloc] init];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:12.0];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = IKSubHeadTitleColor;

    [self addSubview:imageV];
    [self addSubview:label];
    
    _imageView = imageV;
    _label = label;
}


- (void)layoutSubviews
{
    __weak typeof (self) weakSelf = self;

    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf).offset(2);
        make.bottom.equalTo(weakSelf).offset(-2);
        make.width.mas_equalTo(CGRectGetHeight(weakSelf.bounds)-4);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.equalTo(weakSelf);
        make.left.equalTo(_imageView.mas_right).offset(4);
    }];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
