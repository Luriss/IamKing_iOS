//
//  IKNavIconView.m
//  IamKing
//
//  Created by Luris on 2017/7/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKNavIconView.h"

@interface IKNavIconView ()

@property(nonatomic,assign)CGFloat angle;
@end


@implementation IKNavIconView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setViewContent];
        
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setViewContent];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setViewContent];
    }
    return self;
}


- (void)setViewContent
{
    
    _angle = 0;
    
    UIImageView *fImageView = [[UIImageView alloc] init];
    fImageView.backgroundColor = [UIColor clearColor];
    fImageView.tag = 1001;
    [fImageView setImage:[UIImage imageNamed:@"IK_logo"]];
    [self addSubview:fImageView];
    
    
    UIImageView *cImageView = [[UIImageView alloc] init];
    cImageView.backgroundColor = [UIColor clearColor];
    cImageView.tag = 1002;
    [cImageView setImage:[UIImage imageNamed:@"IK_cycle"]];
    
    [self insertSubview:cImageView aboveSubview:fImageView];
}

- (void)ajustFrame
{
    UIImageView *image1 = [self viewWithTag:1001];
    [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(6);
        make.width.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(-6);
    }];
    
    UIImageView *image2 = [self viewWithTag:1002];
    
    [image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(2);
        make.top.equalTo(self).offset(4);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    
}

- (void)startAnimation
{
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 10;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    UIImageView *imageView = [self viewWithTag:1002];
    [imageView.layer addAnimation:animation forKey:nil];
}






/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
