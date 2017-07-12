//
//  IKImageWordView.m
//  IamKing
//
//  Created by Luris on 2017/7/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKImageWordView.h"


@interface IKImageWordView ()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *label;


@end

@implementation IKImageWordView


- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initSubviews];
    }
    
    return self;
}


- (void)initSubviews
{
    UIImageView *imageV = [[UIImageView alloc] init];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:13.0];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = IKRGBColor(164.0, 164.0, 164.0);

    [self addSubview:imageV];
    [self addSubview:label];
    
    _imageView = imageV;
    _label = label;
}


- (void)setImageName:(NSString *)imageName
{
    if (!IKStringIsEmpty(imageName)) {
        _imageName = imageName;
        [_imageView setImage:[UIImage imageNamed:imageName]];
    }
}

- (void)setWord:(NSString *)word
{
    if (!IKStringIsEmpty(word)) {
        _word = word;
        _label.text = word;
    }
}


- (void)layoutSubviews
{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(2);
        make.bottom.equalTo(self).offset(-2);
        make.width.mas_equalTo(CGRectGetHeight(self.bounds)-4);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.equalTo(self);
        make.left.equalTo(_imageView.mas_right).offset(2);
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
