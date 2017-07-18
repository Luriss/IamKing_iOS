//
//  IKBottomTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/16.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKBottomTableViewCell.h"
#import "IKSearchView.h"
#import "IKLoopPlayView.h"


@interface IKBottomTableViewCell ()<IKSearchViewDelegate>

@property(nonatomic,strong)UIView      *bottomLine;
@property(nonatomic,strong)IKSearchView *searchView;
@property(nonatomic,strong)IKLoopPlayView *lpView;

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
//    [self.contentView addSubview:self.searchView];
//    [self.contentView addSubview:self.lpView];
    [self.contentView addSubview:self.bottomLine];
}




- (IKSearchView *)searchView
{
    if (_searchView == nil) {
        _searchView = [[IKSearchView alloc] init];
        _searchView.hiddenColse = YES;
        _searchView.hidden = YES;
    }
    
    return _searchView;
}


- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = IKLineColor;
    }
    return _bottomLine;
}

-(IKLoopPlayView *)lpView
{
    if (_lpView == nil) {
        _lpView = [[IKLoopPlayView alloc]init];
        _lpView.imagesArray = @[
                                @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646722_1456498424671_800x600.jpg",
                                @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646649_1456498410838_800x600.jpg",
                                @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646706_1456498430419_800x600.jpg",
                                @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646723_1456498427059_800x600.jpg",
                                @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1602/26/c0/18646705_1456498422529_800x600.jpg"
                                ];
        _lpView.scrollDirection = IKLPVScrollDirectionHorizontal;
        _lpView.pageControlHidden = NO;
        _lpView.hidden = YES;
    }
    
    return _lpView;
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

- (void)setIsShowLooPalyView:(BOOL)isShowLooPalyView
{
    self.lpView.hidden = !isShowLooPalyView;
    
    if (isShowLooPalyView) {
        __weak typeof (self) weakSelf = self;
        [_lpView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(1);
            make.left.and.right.equalTo(weakSelf.contentView);
            make.height.mas_equalTo(175);
        }];
//        [_lpView startAutoScrollPage];
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
}


- (void)layoutSubviews
{
    [self layoutCellSubviews];
    
    [super layoutSubviews];
}



- (void)searchViewStartSearch
{
    NSLog(@"searchViewStartSearch");
    if ([self.delegate respondsToSelector:@selector(searchViewCellStartSearch)]) {
        [self.delegate searchViewCellStartSearch];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
