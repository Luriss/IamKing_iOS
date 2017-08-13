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
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UIImageView *sexImage;


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


- (void)initSubViews
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
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
        
        
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.logoImage];
        [self.contentView addSubview:self.sexImage];

        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.and.right.equalTo(self.contentView);
            make.height.mas_equalTo(1);
        }];
        
        [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(imgView.mas_bottom);
            make.width.and.height.mas_equalTo(80);
        }];
        
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_logoImage.mas_bottom).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.height.mas_equalTo(30);
            make.right.equalTo(_logoImage.mas_centerX).offset(4);
        }];
        
        [_sexImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_label.mas_centerY);
            make.left.equalTo(_label.mas_right).offset(5);
            make.width.height.mas_equalTo(20);
        }];
    });
}



- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont boldSystemFontOfSize:16.0f];
        _label.textColor = IKGeneralBlue;
        _label.textAlignment = NSTextAlignmentRight;
//        _label.backgroundColor = [UIColor purpleColor];
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
        _logoImage.layer.cornerRadius = 6;
        _logoImage.layer.masksToBounds = YES;
    }
    return _logoImage;
}

- (UIImageView *)sexImage
{
    if (_sexImage == nil) {
        _sexImage = [[UIImageView alloc] init];
//        _sexImage.backgroundColor = IKGeneralLightGray;
    }
    return _sexImage;
}


- (void)addSettingHeaderTableViewCellData:(NSDictionary *)dict
{
    NSLog(@"addSettingHeaderTableViewCellData = %@",dict);
    NSString *imageStr = [dict objectForKey:@"headerImage"];
    NSArray *arr = [imageStr componentsSeparatedByString:@"http"];
    NSString *newImageUrl = [NSString stringWithFormat:@"http%@",arr.lastObject];

    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:newImageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"image = %@,error = %@ imageURL = %@",image,error,imageURL);
    }];
    
    self.label.text = [dict objectForKey:@"nickname"];

    [self.sexImage setImage:[UIImage imageNamed:@"IK_male"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
