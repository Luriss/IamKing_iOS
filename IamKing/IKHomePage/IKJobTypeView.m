//
//  IKJobTypeView.m
//  IamKing
//
//  Created by Luris on 2017/7/14.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobTypeView.h"

@interface IKJobTypeView ()

@property (nonatomic, strong) UIButton *newJobBtn;
@property (nonatomic, strong) UIView     *nBottomLine;
@property (nonatomic, strong) UIButton *hotJobBtn;
@property (nonatomic, strong) UIView     *hBottomLine;


@end

@implementation IKJobTypeView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubViews];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubViews];
    }
    return self;
}


- (void)addSubViews
{
    [self addSubview:self.newJobBtn];
    [self addSubview:self.hotJobBtn];
    [self addSubview:self.nBottomLine];
    [self addSubview:self.hBottomLine];
}


- (void)layoutSubviews
{
    [_newJobBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5);
    }];
    
    [_hotJobBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5);
    }];
    
    [_nBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_newJobBtn.mas_centerY).offset(12);
        make.centerX.equalTo(_newJobBtn);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(3);
    }];
    
    [_hBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_hotJobBtn.mas_centerY).offset(12);
        make.centerX.equalTo(_hotJobBtn);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(3);
    }];
    
    [super layoutSubviews];
}

- (UIButton *)newJobBtn
{
    if (_newJobBtn == nil) {
        // 搜索按钮
        _newJobBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _newJobBtn.tag = 1001;
//        _newJobBtn.backgroundColor = [UIColor blueColor];
        [_newJobBtn setTitle:@"最新职位" forState:UIControlStateNormal];
        [_newJobBtn setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
        _newJobBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [_newJobBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _newJobBtn;
}

- (UIButton *)hotJobBtn
{
    if (_hotJobBtn == nil) {
        // 更多按钮
        _hotJobBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _hotJobBtn.tag = 1002;
//        _hotJobBtn.backgroundColor = [UIColor whiteColor];
        [_hotJobBtn setTitle:@"最热职位" forState:UIControlStateNormal];
        [_hotJobBtn setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        _hotJobBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [_hotJobBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _hotJobBtn;
}

- (UIView *)nBottomLine
{
    if (_nBottomLine == nil) {
        _nBottomLine = [[UIView alloc] init];
        _nBottomLine.backgroundColor = IKGeneralBlue;
    }
    return _nBottomLine;
}


- (UIView *)hBottomLine
{
    if (_hBottomLine == nil) {
        _hBottomLine = [[UIView alloc] init];
        _hBottomLine.backgroundColor = IKGeneralBlue;
        _hBottomLine.hidden = YES;
    }
    return _hBottomLine;
}

- (void)btnClick:(UIButton *)button
{
    NSLog(@"%@",button);
    if (button == _newJobBtn) {
        
        [_hotJobBtn setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        _hBottomLine.hidden = YES;
        
        [_newJobBtn setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
        _nBottomLine.hidden = NO;
        
        if ([self.delegate respondsToSelector:@selector(jobTypeViewNewJobButtonClick:)]) {
            [self.delegate jobTypeViewNewJobButtonClick:button];
        }
    }
    else{
        
        [_newJobBtn setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        _nBottomLine.hidden = YES;
        
        [_hotJobBtn setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
        _hBottomLine.hidden = NO;
        
        if ([self.delegate respondsToSelector:@selector(jobTypeViewHotJobButtonClick:)]) {
            [self.delegate jobTypeViewHotJobButtonClick:button];
        }
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
