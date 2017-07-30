//
//  IKBottomTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/16.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKBottomTableViewCell.h"
#import "IKSearchView.h"


@interface IKBottomTableViewCell ()<IKSearchViewDelegate>

@property(nonatomic,strong)UIView      *bottomLine;
@property(nonatomic,strong)IKSearchView *searchView;
@property(nonatomic,strong)UIView      *topLine;

@end


@implementation IKBottomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    [self.contentView addSubview:self.searchView];
    [self.contentView addSubview:self.topLine];
    [self.contentView addSubview:self.bottomLine];
}




- (IKSearchView *)searchView
{
    if (_searchView == nil) {
        _searchView = [[IKSearchView alloc] init];
        _searchView.hiddenColse = YES;
        _searchView.canSearch = NO;
        _searchView.hidden = YES;
    }
    
    return _searchView;
}

- (UIView *)topLine
{
    if (_topLine == nil) {
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = IKLineColor;
        _topLine.hidden = YES;
    }
    return _topLine;
}

- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = IKLineColor;
    }
    return _bottomLine;
}


-(void)setIsShowTopLine:(BOOL)isShowTopLine
{
    self.topLine.hidden = !isShowTopLine;
}

- (void)setIsShowSearchView:(BOOL)isShowSearchView
{
    self.searchView.hidden = !isShowSearchView;
    
    if (isShowSearchView) {
        __weak typeof (self) weakSelf = self;
        [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(1);
            make.left.and.right.equalTo(weakSelf.contentView);
            make.height.mas_equalTo(44);
        }];
    }
}


-(void)setDelegate:(id<IKBottomTableViewCellDelegate>)delegate
{
    if (delegate) {
        _delegate = delegate;
        _searchView.delegate = self;

    }
}

- (void)layoutCellSubviews
{
    __weak typeof (self) weakSelf = self;
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(1);
        make.left.and.right.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(1);
    }];
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(0);
        make.left.and.right.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(1);
    }];
}


- (void)layoutSubviews
{
    [self layoutCellSubviews];
    
    [super layoutSubviews];
}



- (void)searchViewStartSearch
{
    if ([self.delegate respondsToSelector:@selector(searchViewCellStartSearch)]) {
        [self.delegate searchViewCellStartSearch];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
