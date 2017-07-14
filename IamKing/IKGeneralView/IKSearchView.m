//
//  IKSearchView.m
//  IamKing
//
//  Created by Luris on 2017/7/12.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSearchView.h"
#import "IKSearchBar.h"
#import "UIImage+GetImage.h"

@interface IKSearchView ()

@property (nonatomic, strong)UIButton *closeBtn;
@property (nonatomic, strong)IKSearchBar *searchBar;
@property (nonatomic, strong)UIView *bottomLine;
@property (nonatomic, strong)UIButton *searchbtn;


@end


@implementation IKSearchView


- (instancetype)init
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

- (void)layoutSubviews
{
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20);
        make.height.and.width.mas_equalTo(CGRectGetHeight(self.frame)- 18);
    }];
    
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.equalTo(self);
        make.left.equalTo(_closeBtn.mas_right);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self).offset(1);
        make.height.mas_equalTo(1);
    }];
    
    [_searchbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_searchBar.mas_right).offset(-20);
        make.top.equalTo(_searchBar).offset(10);
        make.bottom.equalTo(_searchBar).offset(-10);
        make.width.mas_equalTo(20);
    }];
    
    [super layoutSubviews];
}


- (void)addSubViews
{
    [self addSubview:self.closeBtn];
    [self addSubview:self.searchBar];
    [self addSubview:self.bottomLine];
}


-(UIButton *)closeBtn
{
    if (_closeBtn == nil) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.backgroundColor = [UIColor clearColor];
        [_closeBtn setImage:[UIImage imageNamed:@"IK_close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeBtn;
}


- (IKSearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[IKSearchBar alloc] init];
        _searchBar.placeholder = @"请输入关键字搜索                                      ";
        _searchBar.contentMode = UIViewContentModeLeft;
        [_searchBar addSubview:self.searchbtn];
    }
    
    return _searchBar;
}


- (UIButton *)searchbtn
{
    if (_searchbtn  == nil) {
        _searchbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchbtn setImage:[UIImage imageNamed:@"IK_search"] forState:UIControlStateNormal];
        [_searchbtn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _searchbtn;
}

- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = IKLineColor;
    }
    return _bottomLine;
}



- (void)closeButtonClick:(UIButton *)button
{
    IKLog(@"closeButtonClick");
    
    if ([self.delegate respondsToSelector:@selector(searchViewCloseButtonClick)]) {
        [self.delegate searchViewCloseButtonClick];
    }
}

- (void)searchButtonClick:(UIButton *)button
{
    IKLog(@"searchButtonClick");
    if ([self.delegate respondsToSelector:@selector(searchViewSearchButtonClick)]) {
        [self.delegate searchViewSearchButtonClick];
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
