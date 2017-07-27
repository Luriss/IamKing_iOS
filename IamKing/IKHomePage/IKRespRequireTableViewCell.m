//
//  IKRespRequireTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/26.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKRespRequireTableViewCell.h"
#import "IKLabel.h"

@interface IKRespRequireTableViewCell ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)IKLabel *contentLabel;
@property(nonatomic,strong)UILabel *psLabel;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UIView  *bottomLineView;

@end


@implementation IKRespRequireTableViewCell

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
    [self.contentView addSubview:self.imageview];

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.psLabel];
    [self.contentView addSubview:self.contentLabel];
    
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.width.and.height.mas_equalTo(15);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_imageview);
        make.left.equalTo(_imageview.mas_right).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    [_psLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel);
        make.left.equalTo(_titleLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [self.contentView addSubview:self.bottomLineView];
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(1);
    }];
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:IKSubTitleFont];
        _titleLabel.textColor =  IKGeneralBlue;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _titleLabel;
}

- (UILabel *)psLabel
{
    if (_psLabel == nil) {
        _psLabel = [[UILabel alloc] init];
        _psLabel.textColor = IKSubHeadTitleColor;
        _psLabel.font = [UIFont systemFontOfSize:12.0f];
        _psLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _psLabel;
}

- (IKLabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[IKLabel alloc] init];
        _contentLabel.textColor = IKMainTitleColor;
        _contentLabel.font = [UIFont systemFontOfSize:12.0f];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.verticalAlignment = IKVerticalAlignmentTop;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
- (UIImageView *)imageview
{
    if (_imageview == nil) {
        _imageview = [[UIImageView alloc] init];
        [_imageview setImage:[UIImage imageNamed:@"IK_jobDesc"]];
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


-(void)setType:(IKRespRequireType)type
{
    switch (type) {
        case IKRespRequireTypeResp:
        {
            _titleLabel.text = @"岗位职责";
            _psLabel.text = @"(具体工作内容)";
            _bottomLineView.hidden = NO;
            break;
        }
        case IKRespRequireTypeRequire:
        {
            _titleLabel.text = @"任职要求";
            _psLabel.text = @"(任职所需具备的要求)";
            _bottomLineView.hidden = YES;
            break;
        }
        default:
            break;
    }
}

- (void)setContent:(NSString *)content
{
    if (IKStringIsNotEmpty(content)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 5;
        
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:12.0f],NSParagraphStyleAttributeName:style}];
        
        _contentLabel.attributedText = attri;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
