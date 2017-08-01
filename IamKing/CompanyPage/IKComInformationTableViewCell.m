//
//  IKComInformationTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/31.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKComInformationTableViewCell.h"

@interface IKComInformationTableViewCell ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UIView  *bottomLineView;
@property(nonatomic,strong)UIButton  *showMoreBtn;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIButton  *closeMoreBtn;
@property(nonatomic,assign)CGFloat   cellHeight;
@property(nonatomic,copy)NSString   *content;
@property (nonatomic,assign)BOOL needShowMoreBtn;
@property (nonatomic,assign)BOOL needCloseMoreBtn;

@end


@implementation IKComInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){

        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.imageview];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.showMoreBtn];
        [self.contentView addSubview:self.closeMoreBtn];
        [self.contentView addSubview:self.bottomLineView];
        _showMoreBtn.hidden = YES;
        _closeMoreBtn.hidden = YES;
    }
    return self;
}

- (void)createSubViews:(NSString *)content needShowMore:(BOOL)needMore needClose:(BOOL)needClose cellHeight:(CGFloat)cellH
{
    _cellHeight = cellH;
    _content = content;
    _needShowMoreBtn = needMore;
    _needCloseMoreBtn = needClose;
    
    [self initSubViews];
}

- (void)initSubViews
{
    _imageview.frame = CGRectMake(20, 13, 16, 16);
    _titleLabel.frame = CGRectMake(42, 8, IKSCREEN_WIDTH*0.3, 26);
    _bottomLineView.frame = CGRectMake(20, 39, IKSCREEN_WIDTH - 40, 1);

    
    
    _contentLabel.text = _content;

    if (_needShowMoreBtn) {
        _showMoreBtn.frame = CGRectMake(IKSCREEN_WIDTH - 70, 0, 50, 40);
        _showMoreBtn.hidden = NO;
    }
    else{
        _showMoreBtn.hidden = YES;
    }
    
    if (_needCloseMoreBtn) {
        _closeMoreBtn.hidden = NO;
        [self.contentLabel setFrame:CGRectMake(20, 42, IKSCREEN_WIDTH - 40, _cellHeight - 42 - 40)];
        [self.closeMoreBtn setFrame:CGRectMake(IKSCREEN_WIDTH*0.5 - 25, _cellHeight - 43, 50, 40)];
    }
    else{
        _closeMoreBtn.hidden = YES;
        _contentLabel.frame = CGRectMake(20, 42, IKSCREEN_WIDTH - 40, _cellHeight - 42 -2);
    }
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:IKSubTitleFont];
        _titleLabel.textColor = IKMainTitleColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"品牌介绍";
    }
    
    return _titleLabel;
}


- (UIImageView *)imageview
{
    if (_imageview == nil) {
        _imageview = [[UIImageView alloc] init];
        _imageview.image = [UIImage imageNamed:@"IK_brand_blue"];
    }
    return _imageview;
}


- (UIView *)bottomLineView
{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = IKLineColor;
    }
    return _bottomLineView;
}


- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
        _contentLabel.textColor = IKSubHeadTitleColor;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        _contentLabel.frame = CGRectMake(20, 42, 335, 122);
//        _contentLabel.backgroundColor = [UIColor redColor];
    }
    
    return _contentLabel;
}


- (UIButton *)showMoreBtn
{
    if (_showMoreBtn == nil) {
        _showMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _showMoreBtn.backgroundColor = [UIColor cyanColor];
        _showMoreBtn.imageEdgeInsets = UIEdgeInsetsMake(14, 4, 10, 30);
        _showMoreBtn.titleEdgeInsets = UIEdgeInsetsMake(4, -42, 0, 0);
        [_showMoreBtn setImage:[UIImage imageNamed:@"IK_showMore"] forState:UIControlStateNormal];
        [_showMoreBtn setTitle:@"展开" forState:UIControlStateNormal];
        [_showMoreBtn setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
        _showMoreBtn.titleLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
        [_showMoreBtn addTarget:self action:@selector(showMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showMoreBtn;
}


- (UIButton *)closeMoreBtn
{
    if (_closeMoreBtn == nil) {
        _closeMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                _closeMoreBtn.backgroundColor = [UIColor whiteColor];
        _closeMoreBtn.frame = CGRectMake(0, 0, 50, 40);
        _closeMoreBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 4, 14, 30);
        _closeMoreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -42, 4, 0);
        [_closeMoreBtn setImage:[UIImage imageNamed:@"IK_closeMore"] forState:UIControlStateNormal];
        [_closeMoreBtn setTitle:@"收起" forState:UIControlStateNormal];
        [_closeMoreBtn setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
        _closeMoreBtn.titleLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
        [_closeMoreBtn addTarget:self action:@selector(closeMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        _closeMoreBtn.hidden = YES;
    }
    return _closeMoreBtn;
}


- (void)showMoreBtnClick:(UIButton *)button
{
    NSLog(@"showMoreBtnClick");
    
//    _showMoreBtn.hidden = YES;
//    self.closeMoreBtn.hidden = NO;
//    [self layoutSubviews];
    NSLog(@"subviews = %@",self.contentView.subviews);

    if ([self.delegate respondsToSelector:@selector(showMoreButtonClick:)]) {
        [self.delegate showMoreButtonClick:YES];
    }
}

- (void)closeMoreBtnClick:(UIButton *)button
{
    NSLog(@"showMoreBtnClick");
    if ([self.delegate respondsToSelector:@selector(showMoreButtonClick:)]) {
        [self.delegate showMoreButtonClick:NO];
    }
}

- (void)setNeedShowMoreBtn:(BOOL)needShowMoreBtn
{
    _needShowMoreBtn = needShowMoreBtn;
    
    if (needShowMoreBtn == YES) {
        [self.contentView addSubview:self.showMoreBtn];
        
        [_showMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.width.mas_equalTo(50);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.height.mas_equalTo(40);
        }];
    }
}

- (void)addCloseButton
{
    

}


- (void)setContent:(NSString *)content
{
    if (IKStringIsNotEmpty(content)) {
        _contentLabel.text = content;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
