//
//  IKMessageNoticeTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKMessageNoticeTableViewCell.h"

@interface IKMessageNoticeTableViewCell ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *logoView;
@property(nonatomic,strong)UILabel  *noticeLabel;
@property(nonatomic,strong)UILabel  *inforationLabel;
@property(nonatomic,strong)UILabel  *timeNumLabel;
@property(nonatomic,strong)UILabel  *msgNumberLabel;
@property(nonatomic,strong)UIView   *bottomLine;

@end


@implementation IKMessageNoticeTableViewCell

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
    [self.contentView addSubview:self.logoView];
    [self.contentView addSubview:self.noticeLabel];
    [self.contentView addSubview:self.inforationLabel];
    [self.contentView addSubview:self.timeNumLabel];
    [self.contentView addSubview:self.msgNumberLabel];
    [self.contentView addSubview:self.bottomLine];
    
    [_logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(7);
        make.left.equalTo(self.contentView.mas_left).offset(22);
        make.width.and.height.equalTo(self.contentView.mas_height).multipliedBy(0.811);
    }];
    
    [_timeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(16);
    }];


    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.left.equalTo(_logoView.mas_right).offset(10);
        make.right.equalTo(_timeNumLabel.mas_left).offset(-2);
        make.height.mas_equalTo(20);
    }];

    [_noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(1);
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(18);
    }];

    [_inforationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_noticeLabel.mas_bottom).offset(1);
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(_noticeLabel.mas_right);
        make.height.equalTo(_noticeLabel.mas_height);
    }];

    [_msgNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoView.mas_top).offset(-5);
        make.right.equalTo(_logoView.mas_right).offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(1);
    }];
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
        _titleLabel.textColor = IKGeneralBlue;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
//        _titleLabel.backgroundColor = [UIColor yellowColor];
    }
    
    return _titleLabel;
}


- (UIImageView *)logoView
{
    if (_logoView == nil) {
        _logoView = [[UIImageView alloc] init];
        _logoView.backgroundColor = IKGeneralLightGray;
        _logoView.layer.borderColor = IKGeneralLightGray.CGColor;
        _logoView.layer.borderWidth = 1;
        _logoView.layer.cornerRadius = 5;
        _logoView.layer.masksToBounds = YES;
    }
    return _logoView;
}


- (UILabel *)noticeLabel
{
    if (_noticeLabel == nil) {
        _noticeLabel = [[UILabel alloc] init];
        _noticeLabel.font = [UIFont boldSystemFontOfSize:IKSubTitleFont];
        _noticeLabel.textColor = IKMainTitleColor;
        _noticeLabel.textAlignment = NSTextAlignmentLeft;
//        _noticeLabel.backgroundColor = [UIColor purpleColor];
    }
    return _noticeLabel;
}


- (UILabel *)inforationLabel
{
    if (_inforationLabel == nil) {
        _inforationLabel = [[UILabel alloc] init];
        _inforationLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        _inforationLabel.textColor = IKSubHeadTitleColor;
        _inforationLabel.textAlignment = NSTextAlignmentLeft;
//        _inforationLabel.backgroundColor = [UIColor cyanColor];
    }
    return _inforationLabel;
}

- (UILabel *)timeNumLabel
{
    if (_timeNumLabel == nil) {
        _timeNumLabel = [[UILabel alloc] init];
        _timeNumLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        _timeNumLabel.textColor = IKSubHeadTitleColor;
        _timeNumLabel.textAlignment = NSTextAlignmentRight;
//        _timeNumLabel.backgroundColor = [UIColor redColor];
    }
    return _timeNumLabel;
}

- (UILabel *)msgNumberLabel
{
    if (_msgNumberLabel == nil) {
        _msgNumberLabel = [[UILabel alloc] init];
        _msgNumberLabel.font = [UIFont boldSystemFontOfSize:11.0f];
        _msgNumberLabel.textColor = [UIColor whiteColor];
        _msgNumberLabel.textAlignment = NSTextAlignmentCenter;
        _msgNumberLabel.layer.backgroundColor = IKGeneralRed.CGColor;
        _msgNumberLabel.layer.cornerRadius = 10;
//        _msgNumberLabel.layer.borderColor = [UIColor whiteColor].CGColor;
//        _msgNumberLabel.layer.borderWidth = 1;
    }
    return _msgNumberLabel;
}


- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = IKLineColor;
        _bottomLine.hidden = YES;
    }
    return _bottomLine;
}

-(void)setCellType:(IKMessageNoticeTableViewCellType)cellType
{
    _cellType = cellType;
}


- (void)messageNoticeCellAddData
{
    switch (_cellType) {
        case IKMessageNoticeTableViewCellTypeNotice:
        {
            _titleLabel.textColor = IKGeneralBlue;
            _titleLabel.text = @"国王官方公告通知";
            _noticeLabel.text = @"产品更新";
            _inforationLabel.text = @"国王招聘2.0版本已更新,点击查看详情";
            _timeNumLabel.text = @"昨天";
            _msgNumberLabel.text = @"66";
            _bottomLine.hidden = YES;
            break;
        }
        case IKMessageNoticeTableViewCellTypeInterested:
        {
            _titleLabel.textColor = IKGeneralBlue;
            _titleLabel.text = @"对我感兴趣";
            _noticeLabel.text = @"与对你感兴趣的公司沟通,更容易获得职位哟";
//            _inforationLabel.text = @"国王招聘2.0版本已更新,点击查看详情";
//            _timeNumLabel.text = @"昨天";
//            _msgNumberLabel.text = @"66";
            _msgNumberLabel.layer.backgroundColor = [UIColor clearColor].CGColor;
            _bottomLine.hidden = YES;

            break;
        }
        case IKMessageNoticeTableViewCellTypeMessage:
        {
            _titleLabel.textColor = IKMainTitleColor;
            _titleLabel.text = @"奥巴马";
            _noticeLabel.text = @"应聘:私教经理";
            _inforationLabel.text = @"我奥巴马来你们这应聘私教经理,要不要?";
            _timeNumLabel.text = @"4月14日";
            _msgNumberLabel.text = @"6";
            _bottomLine.hidden = NO;

            break;
        }
        default:
            break;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
