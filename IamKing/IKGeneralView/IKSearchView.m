//
//  IKSearchView.m
//  IamKing
//
//  Created by Luris on 2017/7/12.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSearchView.h"
#import "UIImage+GetImage.h"

@interface IKSearchView ()<UISearchBarDelegate>

@property (nonatomic, strong)UIButton *closeBtn;
@property (nonatomic, strong)UIView *bottomLine;
@property (nonatomic, assign)BOOL hadAddCloseBtn;


@end


@implementation IKSearchView


- (instancetype)init
{
    self = [super init];
    if (self) {
        _hiddenColse = YES;
        _hadAddCloseBtn = NO;
        [self addSubViews];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _hiddenColse = YES;
        [self addSubViews];
    }
    
    return self;
}

- (void)layoutSubviews
{
    __weak typeof (self) weakSelf = self;

    if (self.hiddenColse) {
        [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.right.and.bottom.and.left.equalTo(self);
        }];
        
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf).offset(1);
            make.height.mas_equalTo(1);
        }];
    }
    else{
        
        [_searchBar mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.bottom.equalTo(weakSelf);
            make.right.equalTo(weakSelf).offset(-40);
        }];
        
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.right.equalTo(weakSelf);
            make.height.mas_equalTo(CGRectGetHeight(weakSelf.frame));
            make.width.mas_equalTo(40);
        }];
        
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf).offset(1);
            make.height.mas_equalTo(1);
        }];
    }
    
    [super layoutSubviews];
}


- (void)addSubViews
{
    [self addSubview:self.searchBar];
    [self addSubview:self.bottomLine];
}

- (void)setHiddenColse:(BOOL)hiddenColse
{
    self.closeBtn.hidden = hiddenColse;
    _hiddenColse = hiddenColse;
    if (!hiddenColse) {
        //添加关闭按钮.
        if (!_hadAddCloseBtn) {
            [self addSubview:self.closeBtn];
            [self setHadAddCloseBtn:YES];
        }
        
        [self setNeedsLayout];
    }
}


- (void)setHadAddCloseBtn:(BOOL)hadAddCloseBtn
{
    _hadAddCloseBtn = hadAddCloseBtn;
}
-(UIButton *)closeBtn
{
    if (_closeBtn == nil) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _closeBtn.backgroundColor = [UIColor clearColor];
//        [_closeBtn setImage:[UIImage imageNamed:@"IK_close"] forState:UIControlStateNormal];
        [_closeBtn setTitle:@"取消 " forState:UIControlStateNormal];
        [_closeBtn setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_closeBtn addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.hidden = YES;
    }
    
    return _closeBtn;
}


- (IKSearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[IKSearchBar alloc] init];
//        _searchBar.placeholder = @" 搜索职位/公司/技能";
        _searchBar.contentMode = UIViewContentModeLeft;
        _searchBar.delegate = self;
    }
    
    return _searchBar;
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
    if ([self.delegate respondsToSelector:@selector(searchViewStartSearch)]) {
        [self.delegate searchViewStartSearch];
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidBeginEditing");
    if ([self.delegate respondsToSelector:@selector(searchViewStartSearch)]) {
        [self.delegate searchViewStartSearch];
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
