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
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.imageview];
    [self.contentView addSubview:self.contentLabel];
    
    
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(13);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.left.equalTo(_imageview.mas_right).offset(5);
        make.width.equalTo(self.contentView).multipliedBy(0.3);
        make.height.mas_equalTo(26);
    }];
    
    [self.contentView addSubview:self.bottomLineView];
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(_imageview.mas_bottom).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(1);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLineView.mas_bottom).offset(2);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
    }];
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
//        _titleLabel.text = @"品牌介绍";
    }
    
    return _contentLabel;
}


- (UIButton *)showMoreBtn
{
    if (_showMoreBtn == nil) {
        _showMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _showMoreBtn.backgroundColor = [UIColor cyanColor];
        _showMoreBtn.frame = CGRectMake(0, 0, 50, 40);
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
        //        _showMoreBtn.backgroundColor = [UIColor cyanColor];
        _closeMoreBtn.frame = CGRectMake(0, 0, 50, 40);
        _closeMoreBtn.imageEdgeInsets = UIEdgeInsetsMake(14, 4, 10, 30);
        _closeMoreBtn.titleEdgeInsets = UIEdgeInsetsMake(4, -42, 0, 0);
        [_closeMoreBtn setImage:[UIImage imageNamed:@"IK_closeMore"] forState:UIControlStateNormal];
        [_closeMoreBtn setTitle:@"收起" forState:UIControlStateNormal];
        [_closeMoreBtn setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
        _closeMoreBtn.titleLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
        [_closeMoreBtn addTarget:self action:@selector(closeMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeMoreBtn;
}


- (void)showMoreBtnClick:(UIButton *)button
{
    NSLog(@"showMoreBtnClick");
    
    button.hidden = YES;
    [self addCloseButton];
    if ([self.delegate respondsToSelector:@selector(showMoreButtonClick:)]) {
        [self.delegate showMoreButtonClick:nil];
    }
}

- (void)closeMoreBtnClick:(UIButton *)button
{
    NSLog(@"showMoreBtnClick");
    
    if ([self.delegate respondsToSelector:@selector(closeMoreButtonClick:)]) {
        [self.delegate closeMoreButtonClick:nil];
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
    
    [self.contentView addSubview:self.closeMoreBtn];
    
    [_closeMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(2);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(40);
    }];

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
