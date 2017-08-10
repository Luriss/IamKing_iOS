//
//  IKSettingHeaderTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/7.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSettingHeaderTableViewCell.h"
#import "IKWaveView.h"
#import "UIImage+GIF.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"

@interface IKSettingHeaderTableViewCell ()

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIImageView *logoImage;
@property (nonatomic, strong)UIImageView *arrowImage;
@property (nonatomic, strong)UIView *lineView;


@end
@implementation IKSettingHeaderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initSubViews];

    }
    return self;
}


- (void)initWaveView
{
    // 读取gif图片数据 注意:传入nil参数可能有警告
    FLAnimatedImageView *imgView = [[FLAnimatedImageView alloc] init];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    NSURL *imgUrl = [[NSBundle mainBundle] URLForResource:@"IK_wave" withExtension:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfURL:imgUrl];
    imgView.backgroundColor = [UIColor clearColor];
    imgView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
    [self.contentView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(ceilf(IKSCREENH_HEIGHT *0.225));
    }];
 
}


- (void)initSubViews
{
    [self initWaveView];

    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.logoImage];
    [self.contentView addSubview:self.arrowImage];
        
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-15);
        make.width.and.height.mas_equalTo(80);
    }];
    
    [_arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.and.height.mas_equalTo(18);
    }];
    
    
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(_logoImage.mas_right).offset(24);
        make.right.equalTo(_arrowImage.mas_left).offset(-5);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}



- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:15.0f];
        _label.textColor = IKMainTitleColor;
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
        _logoImage.backgroundColor = [UIColor redColor];
        _logoImage.layer.cornerRadius = 6;
        _logoImage.layer.masksToBounds = YES;
    }
    return _logoImage;
}

- (UIImageView *)arrowImage
{
    if (_arrowImage == nil) {
        _arrowImage = [[UIImageView alloc] init];
        [_arrowImage setImage:[UIImage imageNamed:@"IK_arrow_right"]];
    }
    return _arrowImage;
}


- (void)settingCellAddData:(NSString *)title imageName:(NSString *)image
{
    [_logoImage setImage:[UIImage imageNamed:image]];
    _label.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
