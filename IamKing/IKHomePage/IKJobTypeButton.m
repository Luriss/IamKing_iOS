//
//  IKJobTypeButton.m
//  IamKing
//
//  Created by Luris on 2017/7/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobTypeButton.h"


@interface IKJobTypeButton ()


@end

@implementation IKJobTypeButton

//-(instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self addSubViews];
//    }
//    return self;
//}
//
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    
//    if (self) {
//        [self addSubViews];
//    }
//    return self;
//}
//
//
//
//- (void)layoutSubviews
//{
//    __weak typeof (self) weakSelf = self;
//
//    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.and.left.and.bottom.equalTo(weakSelf);
//        make.width.equalTo(weakSelf);
//    }];
//    
//    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf.mas_centerY).offset(12);
//        make.centerX.equalTo(weakSelf);
//        make.width.mas_equalTo(60);
//        make.height.mas_equalTo(3);
//    }];
//    
//    [super layoutSubviews];
//}

//
//- (void)setTitle:(NSString *)title
//{
//    if (IKStringIsNotEmpty(title)) {
//        IKLog(@"%@",title);
//        _title = title;
//        [_button setTitle:title forState:UIControlStateNormal];
//    }
//}
//
//-  (void)setButtonIndex:(NSUInteger)buttonIndex
//{
//    if (buttonIndex -100 == 1) {
//        [_button setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
//    }
//}
//
//- (UIButton *)button
//{
//    if (_button == nil) {
//        // 按钮
//        _button = [UIButton buttonWithType:UIButtonTypeCustom];
////                _button.backgroundColor = [UIColor blueColor];
//        [_button setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
//        [_button setTitleColor:IKSubHeadTitleColor forState:UIControlStateDisabled];
//        _button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
//        [_button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    return _button;
//}
//
//
//- (UIView *)nBottomLine
//{
//    if (_bottomLine == nil) {
//        _bottomLine = [[UIView alloc] init];
//        _bottomLine.backgroundColor = IKGeneralBlue;
//    }
//    return _bottomLine;
//}
//
//
//- (void)btnClick:(UIButton *)button
//{
//    NSLog(@"%@",button);
//    
//    _selectedButton = button;
//    
//    [_button setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
//    _button.hidden = NO;
//    
//    if ([self.delegate respondsToSelector:@selector(jobTypeViewNewJobButtonClick:)]) {
//        [self.delegate jobTypeViewNewJobButtonClick:button];
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
