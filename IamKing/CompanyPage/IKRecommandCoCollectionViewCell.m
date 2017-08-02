//
//  IKRecommandCoCollectionViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/30.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKRecommandCoCollectionViewCell.h"

@interface IKRecommandCoCollectionViewCell ()

@property(nonatomic,strong)UIImageView   *imageV;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *desLabel;


@end


@implementation IKRecommandCoCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubViews];
    }
    
    return self;
}

- (void)addSubViews
{
    [self.contentView addSubview:self.imageV];
    
    [self.contentView addSubview:self.nameLabel];
    
    [self.contentView addSubview:self.desLabel];
    
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(13);
        make.left.equalTo(self.contentView.mas_left);
        make.width.and.height.mas_equalTo(ceilf(IKSCREEN_WIDTH * 0.2933));
    }];

    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageV.mas_bottom).offset(5);
        make.left.equalTo(_imageV.mas_left);
        make.width.equalTo(_imageV.mas_width);
        make.height.mas_equalTo(20);
    }];

    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(-2);
        make.left.equalTo(_imageV.mas_left);
        make.width.equalTo(_imageV.mas_width);
        make.height.mas_equalTo(18);
    }];
    
}

- (UIImageView *)imageV
{
    if (_imageV == nil) {
        _imageV = [[UIImageView alloc]init];
        _imageV.layer.cornerRadius = 5;
        _imageV.layer.borderWidth = 1;
        _imageV.layer.borderColor = IKLineColor.CGColor;
        _imageV.layer.masksToBounds = YES;
        _imageV.backgroundColor = [UIColor redColor];
        [_imageV sd_setImageWithURL:[NSURL URLWithString:@"https://pic.iamking.com.cn/Public/User/headerImage/1501229456_858_653.jpg"] placeholderImage:nil];
    }
    
    return _imageV;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = IKMainTitleColor;
        _nameLabel.font = [UIFont systemFontOfSize:12.0f];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"威尔士健身";
    }
    return _nameLabel;
}

- (UILabel *)desLabel
{
    if (_desLabel == nil) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.textColor =  IKSubHeadTitleColor;
        _desLabel.font = [UIFont systemFontOfSize:11.0f];
        _desLabel.textAlignment = NSTextAlignmentCenter;
        _desLabel.text = @"国内知名健身品牌";
    }
    return _desLabel;
}



@end
