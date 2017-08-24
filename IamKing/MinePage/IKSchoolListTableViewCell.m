//
//  IKSchoolListTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSchoolListTableViewCell.h"


@interface IKSchoolListTableViewCell ()

@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UILabel *jobLabel;
@property (nonatomic, strong)UILabel *companyLabel;
@property (nonatomic, strong)UIButton *garbageBtn;
@property (nonatomic, strong)UIButton *editBtn;
@property (nonatomic, strong)UILabel *psLabel;
@property (nonatomic, copy)NSDictionary *dataDict;

@property (nonatomic, strong)UIImageView *logoImageView;


@end
@implementation IKSchoolListTableViewCell

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
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.logoImageView];
    [self.contentView addSubview:self.jobLabel];
    [self.contentView addSubview:self.garbageBtn];
    [self.contentView addSubview:self.editBtn];
    [self.contentView addSubview:self.psLabel];
    [self.contentView addSubview:self.companyLabel];
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.width.and.height.mas_equalTo(20);
    }];
    
    [_garbageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.width.and.height.mas_equalTo(26);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_garbageBtn.mas_top);
        make.width.and.height.equalTo(_garbageBtn);
        make.right.equalTo(_garbageBtn.mas_left).offset(-30);
    }];
    
    [_companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(_logoImageView.mas_right).offset(2);
        make.right.equalTo(_editBtn.mas_left).offset(-5);
        make.height.mas_equalTo(30);
    }];
    
    [_jobLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_companyLabel.mas_bottom).offset(2);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.45);
        make.height.mas_equalTo(30);
    }];
    
    [_psLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_jobLabel.mas_bottom);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(_jobLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    
}

- (UIImageView *)logoImageView
{
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] init];
//        _logoImageView.hidden = YES;
        _logoImageView.layer.cornerRadius = 3;
        _logoImageView.layer.masksToBounds = YES;
    }
    return _logoImageView;
}


- (UILabel *)jobLabel
{
    if (_jobLabel == nil) {
        _jobLabel = [[UILabel alloc] init];
        _jobLabel.font = [UIFont systemFontOfSize:13.0f];
        _jobLabel.textColor = IKGeneralBlue;
        _jobLabel.text = @"私人教练";
        _jobLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _jobLabel;
}

- (UILabel *)companyLabel
{
    if (_companyLabel == nil) {
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _companyLabel.textColor = IKSubHeadTitleColor;
        _companyLabel.text = @"舒适堡健身";
        _companyLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _companyLabel;
}

- (UILabel *)psLabel
{
    if (_psLabel == nil) {
        _psLabel = [[UILabel alloc] init];
        _psLabel.font = [UIFont systemFontOfSize:13.0f];
        _psLabel.textColor = IKMainTitleColor;
        _psLabel.text = @"为会员提供器械指导和一对一私教训练服务，并协助私教经理的工作.";
        _psLabel.textAlignment = NSTextAlignmentLeft;
        _psLabel.numberOfLines = 2;
    }
    return _psLabel;
}
//

- (UIButton *)garbageBtn
{
    if (_garbageBtn == nil) {
        _garbageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_garbageBtn addTarget:self action:@selector(garbageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_garbageBtn setImage:[UIImage imageNamed:@"IK_garbage_red"] forState:UIControlStateNormal];
        [_garbageBtn setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_garbage_red"] forState:UIControlStateHighlighted];
    }
    return _garbageBtn;
}

- (UIButton *)editBtn
{
    if (_editBtn == nil) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_editBtn setImage:[UIImage imageNamed:@"IK_assessment"] forState:UIControlStateNormal];
        [_editBtn setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_assessment"] forState:UIControlStateHighlighted];
    }
    return _editBtn;
}


- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = IKLineColor;
    }
    return _lineView;
}



- (void)garbageBtnClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(resumeSchoolListCellDeleteButtonClick:)]) {
        [self.delegate resumeSchoolListCellDeleteButtonClick:self];
    }
}


- (void)editBtnClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(resumeSchoolListCellEditButtonClickWithData: cell:)]) {
        [self.delegate resumeSchoolListCellEditButtonClickWithData:self.dataDict cell:self];
    }
}


- (void)addResumeSchoolListCellData:(NSDictionary *)dict
{
    NSLog(@"addResumeWorkListCellData = %@",dict);
    self.dataDict = dict;

    self.companyLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];
    self.jobLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"work_name"]];
    
    NSMutableString *startTime = [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"time_start"]];
    [startTime insertString:@"-" atIndex:4];
    
    NSMutableString *mEndTime = [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"time_end"]];
    
    NSString *endTime = nil;
    if ([mEndTime isEqualToString:@"-1"]) {
        endTime = @"至今";
    }
    else{
        [mEndTime insertString:@"-" atIndex:4];
        endTime = [mEndTime copy];
    }
    
    NSString *isGraduate = nil;
    if ([[dict objectForKey:@"is_graduate"] isEqualToString:@"1"]) {
        isGraduate = @"已结业";
    }
    else{
        isGraduate = @"未结业";
    }
    
    NSString *hasCert = nil;
    if ([[dict objectForKey:@"has_certificate"] isEqualToString:@"1"]) {
        hasCert = @"有证书";
    }
    else{
        hasCert = @"无证书";
    }
    
    self.psLabel.text = [NSString stringWithFormat:@"%@ - %@        %@        %@",startTime,endTime,isGraduate,hasCert];
    
    NSString *logoUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"school_logo"]];
    logoUrl = [logoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:logoUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
