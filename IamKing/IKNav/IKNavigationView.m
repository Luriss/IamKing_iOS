//
//  IKNavigationView.m
//  IamKing
//
//  Created by Luris on 2017/8/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKNavigationView.h"

@implementation IKNavigationView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = IKGeneralBlue;
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = IKGeneralBlue;

    }
    
    return self;
}


- (void)setLeftButton:(UIButton *)leftButton
{
    if (leftButton) {
        _leftButton = leftButton;
        leftButton.frame = CGRectMake(10, 20, CGRectGetWidth(leftButton.frame), CGRectGetHeight(leftButton.frame));
        [self addSubview:leftButton];
    }
}

- (void)setTitleView:(UIView *)titleView
{
    if (titleView) {
        _titleView = titleView;
        
        titleView.frame = CGRectMake(self.center.x - CGRectGetWidth(titleView.frame)*0.5, 20, CGRectGetWidth(titleView.frame), CGRectGetHeight(titleView.frame));
        [self addSubview:titleView];
    }
}


- (void)setRightButton:(UIButton *)rightButton
{
    if (rightButton) {
        _rightButton = rightButton;
        rightButton.frame = CGRectMake(CGRectGetWidth(self.frame) - CGRectGetWidth(rightButton.frame) - 10, 20, CGRectGetWidth(rightButton.frame), CGRectGetHeight(rightButton.frame));
//        rightButton.backgroundColor = [UIColor redColor];
        [self addSubview:rightButton];
    }
}

- (void)setRight2Button:(UIButton *)right2Button
{
    if (right2Button) {
        _right2Button = right2Button;
        right2Button.frame = CGRectMake(CGRectGetWidth(self.frame) - CGRectGetWidth(_rightButton.frame) - CGRectGetWidth(right2Button.frame) - 10, 20, CGRectGetWidth(right2Button.frame), CGRectGetHeight(right2Button.frame));
//        right2Button.backgroundColor = [UIColor purpleColor];

        [self addSubview:right2Button];
    }
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
