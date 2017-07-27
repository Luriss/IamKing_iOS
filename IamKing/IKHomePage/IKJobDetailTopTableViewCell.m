//
//  IKJobDetailTopTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/25.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobDetailTopTableViewCell.h"
#import "IKImageWordView.h"


@interface IKJobDetailTopTableViewCell ()

@property(nonatomic,strong)UILabel *jobNameLabel;
@property(nonatomic,strong)UIImageView *pinImageview;

@property(nonatomic,strong)UILabel *salaryLabel;
@property(nonatomic,strong)UILabel *temptationLabel;
@property(nonatomic,strong)UILabel *releaseTimeLabel;
@property(nonatomic,strong)UIView  *bottomLineView;

@property(nonatomic,strong)IKImageWordView     *addressView;
@property(nonatomic,strong)IKImageWordView     *experienceView;
@property(nonatomic,strong)IKImageWordView     *educationView;


@end


@implementation IKJobDetailTopTableViewCell

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
    [self.contentView addSubview:self.jobNameLabel];
    [_jobNameLabel addSubview:self.pinImageview];
    [self.contentView addSubview:self.salaryLabel];
    [self.contentView addSubview:self.addressView];
    [self.contentView addSubview:self.experienceView];
    [self.contentView addSubview:self.educationView];
    [self.contentView addSubview:self.temptationLabel];
    [self.contentView addSubview:self.releaseTimeLabel];
    [self.contentView addSubview:self.bottomLineView];
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(1);
    }];
}


- (UILabel *)jobNameLabel
{
    if (_jobNameLabel == nil) {
        _jobNameLabel = [[UILabel alloc] init];
        _jobNameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _jobNameLabel.textColor = [UIColor whiteColor];
        _jobNameLabel.backgroundColor = IKGeneralBlue;
        _jobNameLabel.textAlignment = NSTextAlignmentRight;
        _jobNameLabel.layer.cornerRadius = 17.0f;
        _jobNameLabel.layer.masksToBounds = YES;
    }
    
    return _jobNameLabel;
}


- (UIImageView *)pinImageview
{
    if (_pinImageview == nil) {
        _pinImageview = [[UIImageView alloc] init];
        _pinImageview.image = [UIImage imageNamed:@"IK_detail_pin"];
        _pinImageview.backgroundColor = [UIColor whiteColor];
        _pinImageview.layer.cornerRadius = 11;
    }
    return _pinImageview;
}


- (UILabel *)salaryLabel
{
    if (_salaryLabel == nil) {
        _salaryLabel = [[UILabel alloc] init];
        _salaryLabel.textColor = [UIColor whiteColor];
        _salaryLabel.font = [UIFont boldSystemFontOfSize:IKSubTitleFont];
        _salaryLabel.backgroundColor = [IKGeneralRed colorWithAlphaComponent:0.7];
        _salaryLabel.textAlignment = NSTextAlignmentCenter;
        _salaryLabel.layer.cornerRadius = 10;
        _salaryLabel.layer.masksToBounds = YES;
    }
    return _salaryLabel;
}

- (IKImageWordView *)addressView
{
    if (_addressView == nil) {
        // 地点
        _addressView = [[IKImageWordView alloc] init];
        [_addressView.imageView setImage:[UIImage imageNamed:@"IK_address_blue"]];
    }
    return _addressView;
}

- (IKImageWordView *)experienceView
{
    if (_experienceView == nil) {
        // 工作经验
        _experienceView = [[IKImageWordView alloc] init];
        [_experienceView.imageView setImage:[UIImage imageNamed:@"IK_experience_blue"]];
    }
    return _experienceView;
}


- (IKImageWordView *)educationView
{
    if (_educationView == nil) {
        // 学历
        _educationView = [[IKImageWordView alloc] init];
        [_educationView.imageView setImage:[UIImage imageNamed:@"IK_education_blue"]];
    }
    return _educationView;
}

- (UILabel *)temptationLabel
{
    if (_temptationLabel == nil) {
        _temptationLabel = [[UILabel alloc] init];
        _temptationLabel.textColor = IKMainTitleColor;
        _temptationLabel.font = [UIFont systemFontOfSize:14.0f];
//        _temptationLabel.backgroundColor = [UIColor cyanColor];
        _temptationLabel.textAlignment = NSTextAlignmentLeft;
        _temptationLabel.numberOfLines = 2;
    }
    return _temptationLabel;
}


- (UILabel *)releaseTimeLabel
{
    if (_releaseTimeLabel == nil) {
        _releaseTimeLabel = [[UILabel alloc] init];
        _releaseTimeLabel.textColor = IKSubHeadTitleColor;
        _releaseTimeLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
        _releaseTimeLabel.textAlignment = NSTextAlignmentLeft;
        _releaseTimeLabel.numberOfLines = 2;
    }
    return _releaseTimeLabel;
}

- (UIView *)bottomLineView
{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = IKLineColor;
    }
    return _bottomLineView;
}


- (void)addCellData:(IKJobDetailModel *)detailModel
{
    __weak typeof (self) weakSelf = self;

    __block CGFloat jobLabelW = 0;
    [self setAttributeString:detailModel.jobName callback:^(NSAttributedString *attributeStr, CGSize size) {
        weakSelf.jobNameLabel.attributedText = attributeStr;
        jobLabelW = size.width;
    }];
    
    [_jobNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(-17);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(jobLabelW + 82);
    }];
    
    [_pinImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).offset(20);
        make.top.equalTo(_jobNameLabel.mas_top).offset(6);
        make.width.and.height.mas_equalTo(22);
    }];
    
    _salaryLabel.text = detailModel.salary;
    [_salaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(22);
        make.right.equalTo(self.contentView).offset(-20);
        make.width.mas_equalTo(84);
        make.height.mas_equalTo(20);
    }];
    
    self.addressView.label.text = detailModel.workCity;
    
    CGFloat addressWidth = [NSString getSizeWithString:detailModel.workCity size:CGSizeMake(MAXFLOAT, 24) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:IKSubTitleFont]}].width;
    
    addressWidth = (addressWidth > 70)?70:addressWidth;
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_jobNameLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.contentView.mas_left).offset(20);
        make.width.mas_equalTo(addressWidth + 20);
        make.height.mas_equalTo(24);
    }];
    
    self.experienceView.label.text = detailModel.experience;
    CGFloat experienceWidth = [NSString getSizeWithString:detailModel.experience size:CGSizeMake(MAXFLOAT, 24) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:IKSubTitleFont]}].width;
    experienceWidth = (experienceWidth > 70)?70:experienceWidth;

    [_experienceView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_addressView);
        make.left.equalTo(_addressView.mas_right).offset(2);
        make.width.mas_equalTo(experienceWidth + 20);
    }];
    
    self.educationView.label.text = detailModel.education;
    
    CGFloat educationWidth = [NSString getSizeWithString:detailModel.education size:CGSizeMake(MAXFLOAT, 24) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:IKSubTitleFont]}].width;
    educationWidth = (educationWidth > 70)?70:educationWidth;

    [_educationView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_addressView);
        make.left.equalTo(_experienceView.mas_right).offset(2);
        make.width.mas_equalTo(educationWidth + 24);
    }];
    
    _temptationLabel.text = detailModel.temptation;
    
    CGFloat temptationH = [NSString getSizeWithString:detailModel.temptation size:CGSizeMake(CGRectGetWidth(self.contentView.bounds)*0.87, MAXFLOAT) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:14.0f]}].height;
    
    NSLog(@"temptationH = %.0f",temptationH);
    
    [_temptationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressView.mas_bottom).offset(5);
        make.left.equalTo(_addressView.mas_left);
        make.width.equalTo(weakSelf.contentView).multipliedBy(0.87);
        make.height.mas_equalTo(temptationH);
    }];
    
    _releaseTimeLabel.text = detailModel.releaseTime;
    
    [_releaseTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_temptationLabel.mas_bottom).offset(5);
        make.left.equalTo(_temptationLabel.mas_left);
        make.height.mas_equalTo(22);
        make.width.equalTo(self.contentView).multipliedBy(0.8);
    }];
}



- (void)setAttributeString:(NSString *)text callback:(void(^)(NSAttributedString *attributeStr,CGSize size))block
{
    NSMutableParagraphStyle *
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.tailIndent = -20; //设置与尾部的距离
    style.alignment = NSTextAlignmentRight;//靠右显示
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString
                                              alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName:style}];
    
    CGSize sz = [NSString getSizeWithString:text size:CGSizeMake(MAXFLOAT, 34) attribute:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0f]}];
    
    if (block) {
        block(attrString,sz);
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
