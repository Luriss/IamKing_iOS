//
//  IKAddPhotoCollectionViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/25.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKAddPhotoCollectionViewCell.h"

@interface IKAddPhotoCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;


@end


@implementation IKAddPhotoCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = IKSeachBarBgColor;
        [self setupImageView];
    }
    return self;
}

- (void)setupImageView {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.label];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-10);
        make.width.and.height.mas_equalTo(26);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom);
        make.height.mas_equalTo(26);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
    }];
}

- (UIImageView* )imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        [_imageView setImage:[UIImage imageNamed:@"IK_Add_gray"]];
    }
    return _imageView;
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont boldSystemFontOfSize:15.0f];
        _label.textColor = IKSubHeadTitleColor;
        _label.text = @"添加照片";
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}


@end
