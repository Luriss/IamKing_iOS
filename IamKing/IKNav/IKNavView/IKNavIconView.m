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
    
    [self ajustFrame];

}

- (void)ajustFrame
{
    UIImageView *image1 = [self viewWithTag:1001];
    __weak typeof (self) weakSelf = self;

    [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(3);
        make.top.equalTo(weakSelf).offset(3);
        make.right.equalTo(weakSelf).offset(-3);
        make.bottom.equalTo(weakSelf).offset(-3);
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
