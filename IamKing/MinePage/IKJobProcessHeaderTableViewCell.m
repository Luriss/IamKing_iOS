//
//  IKJobProcessHeaderTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobProcessHeaderTableViewCell.h"

@interface IKJobProcessHeaderTableViewCell ()

@property (nonatomic, strong)UIView *topLineView;
@property (nonatomic, strong)UIView *bottomLineView;
@property (nonatomic, strong)UIView *timeLineView;
@property (nonatomic, strong)UIView *middleLineView;

@property (nonatomic, strong)UILabel *topTimeLabel;
@property (nonatomic, strong)UILabel *psLabel1;
@property (nonatomic, strong)UILabel *psLabel2;

@property (nonatomic, strong)UILabel *jobLabel;
@property (nonatomic, strong)UILabel *processLabel;

@end

@implementation IKJobProcessHeaderTableViewCell

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
    [self.contentView addSubview:self.topLineView];
    [self.contentView addSubview:self.topTimeLabel];
    [self.contentView addSubview:self.timeLineView];
    [self.contentView addSubview:self.middleLineView];
    [self.contentView addSubview:self.bottomLineView];
    [self.contentView addSubview:self.psLabel1];
    [self.contentView addSubview:self.psLabel2];
    [self.contentView addSubview:self.jobLabel];
    [self.contentView addSubview:self.processLabel];
    
    
    
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    
    [_topTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(1);
        make.left.equalTo(self.contentView .mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(27);
    }];
    
    [_timeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topTimeLabel.mas_bottom);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    [_middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLineView.mas_bottom).offset(15);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.width.mas_equalTo(1);
    }];
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    
    [_psLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLineView.mas_bottom).offset(5);
        make.left.equalTo(_topTimeLabel.mas_left);
        make.right.equalTo(_middleLineView.mas_left).offset(-5);
        make.height.mas_equalTo(22);
    }];
    
    [_jobLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_psLabel1.mas_bottom);
        make.left.equalTo(_psLabel1.mas_left);
        make.right.equalTo(_psLabel1.mas_right);
        make.bottom.equalTo(_bottomLineView.mas_top).offset(-5);
    }];
    
    [_psLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_psLabel1.mas_top);
        make.left.equalTo(_middleLineView.mas_right).offset(5);
        make.right.equalTo(_topTimeLabel.mas_right);
        make.height.equalTo(_psLabel1.mas_height);
    }];
    
    [_processLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_jobLabel.mas_top);
        make.left.equalTo(_psLabel2.mas_left);
        make.right.equalTo(_psLabel2.mas_right);
        make.bottom.equalTo(_jobLabel.mas_bottom);
    }];
}



- (UILabel *)topTimeLabel
{
    if (_topTimeLabel == nil) {
        _topTimeLabel = [[UILabel alloc] init];
        _topTimeLabel.font = [UIFont systemFontOfSize:13.0f];
        _topTimeLabel.textColor = IKSubHeadTitleColor;
        _topTimeLabel.textAlignment = NSTextAlignmentCenter;
//        _topTimeLabel.backgroundColor = [UIColor redColor];
    }
    return _topTimeLabel;
}

- (UILabel *)psLabel1
{
    if (_psLabel1 == nil) {
        _psLabel1 = [[UILabel alloc] init];
        _psLabel1.font = [UIFont systemFontOfSize:13.0f];
        _psLabel1.textColor = IKSubHeadTitleColor;
        _psLabel1.textAlignment = NSTextAlignmentCenter;
        _psLabel1.text = @"投递职位";
//        _psLabel1.backgroundColor = [UIColor yellowColor];
        
    }
    return _psLabel1;
}


- (UILabel *)psLabel2
{
    if (_psLabel2 == nil) {
        _psLabel2 = [[UILabel alloc] init];
        _psLabel2.font = [UIFont systemFontOfSize:13.0f];
        _psLabel2.textColor = IKSubHeadTitleColor;
        _psLabel2.textAlignment = NSTextAlignmentCenter;
        _psLabel2.text = @"当前进度";
//        _psLabel2.backgroundColor = [UIColor yellowColor];
        
    }
    return _psLabel2;
}


- (UILabel *)jobLabel
{
    if (_jobLabel == nil) {
        _jobLabel = [[UILabel alloc] init];
        _jobLabel.font = [UIFont systemFontOfSize:15.0f];
        _jobLabel.textColor = IKGeneralBlue;
        _jobLabel.textAlignment = NSTextAlignmentCenter;
//        _jobLabel.text = @"私教总监";
//        _jobLabel.backgroundColor = [UIColor cyanColor];
        
    }
    return _jobLabel;
}


- (UILabel *)processLabel
{
    if (_processLabel == nil) {
        _processLabel = [[UILabel alloc] init];
        _processLabel.font = [UIFont systemFontOfSize:15.0f];
        _processLabel.textColor = IKGeneralBlue;
        _processLabel.textAlignment = NSTextAlignmentCenter;
//        _processLabel.text = @"已投递简历";
//        _processLabel.backgroundColor = [UIColor cyanColor];
        
    }
    return _processLabel;
}

- (UIView *)topLineView
{
    if (_topLineView == nil) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = IKGeneralBlue;
    }
    return _topLineView;
}


- (UIView *)bottomLineView
{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = IKLineColor;
    }
    return _bottomLineView;
}


- (UIView *)timeLineView
{
    if (_timeLineView == nil) {
        _timeLineView = [[UIView alloc] init];
        _timeLineView.backgroundColor = IKLineColor;
    }
    return _timeLineView;
}


- (UIView *)middleLineView
{
    if (_middleLineView == nil) {
        _middleLineView = [[UIView alloc] init];
        _middleLineView.backgroundColor = IKLineColor;
    }
    return _middleLineView;
}


- (void)addProcessHeaderCellTopTime:(NSString *)time
                       inviteStatus:(NSString *)inviteStatus
                         deliverJob:(NSString *)job
                      companyStatus:(NSString *)companyStatus
                         userStatus:(NSString *)userStatus
{
    if (IKStringIsNotEmpty(time)) {
        _topTimeLabel.text = time;
    }
    else{
        _topTimeLabel.text = [NSString stringWithFormat:@"%@",[NSDate date]];;
    }
    
    if ([inviteStatus isEqualToString:@"2"]) {
        _jobLabel.text = @"职位已下架";
        _jobLabel.textColor = IKGeneralRed;
    }
    else{
        _jobLabel.text = job;
        _jobLabel.textColor = IKGeneralBlue;
    }
    
    NSInteger companyStatusI = [companyStatus integerValue];
    NSInteger userStatusI = [userStatus integerValue];

    
    
    if (companyStatusI == 0 && userStatusI == 0) {
        _processLabel.text = @"已投递简历";
    }
    else if(companyStatusI == 1 && userStatusI == 0){
        _processLabel.text = @"收到面试邀请";
    }
    else if(companyStatusI == 1 && userStatusI == 1){
        _processLabel.text = @"应约前往面试";
    }
    else if (userStatusI == 2){
        _processLabel.text = @"面试结束但未评价";
    }
    else if (userStatusI == 3){
        _processLabel.text = @"面试结束并已评价";
    }
    else{
        _processLabel.text = @"无更多信息";
    }
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
