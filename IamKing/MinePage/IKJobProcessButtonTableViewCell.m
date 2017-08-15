//
//  IKJobProcessButtonTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobProcessButtonTableViewCell.h"


@interface IKJobProcessButtonTableViewCell ()

@property (nonatomic, strong)UIView     *topLineView;
@property (nonatomic, strong)UIButton     *processButton;
@property (nonatomic, assign)IKJobProcessButtonType type;

@end

@implementation IKJobProcessButtonTableViewCell

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
    [self.contentView addSubview:self.processButton];
    
    self.type = IKJobProcessButtonTypeChat;
    
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
  
    [_processButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    
}

- (UIView *)topLineView
{
    if (_topLineView == nil) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = IKLineColor;
    }
    return _topLineView;
}


- (UIButton *)processButton
{
    if (_processButton == nil) {
        _processButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _processButton.backgroundColor = IKGeneralBlue;
        [_processButton setTitle:@"聊一聊" forState:UIControlStateNormal];
        [_processButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_processButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateDisabled];
        
        _processButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [_processButton setBackgroundImage:IKButtonBlueBgImgae forState:UIControlStateNormal];
        [_processButton setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
        _processButton.layer.cornerRadius = 6;
        _processButton.layer.masksToBounds = YES;
        [_processButton addTarget:self action:@selector(processButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _processButton;
}


- (void)processButtonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(jobProcessButtonClickWithType: cell:)]) {
        [self.delegate jobProcessButtonClickWithType:IKJobProcessButtonTypeCheckInterview cell:self];
    }
}


- (void)addProcessButtonTitleWithCompanyStatus:(NSString *)companyStatus
                                    userStatus:(NSString *)userStatus
                                      feedback:(NSString *)hasFeedback
                                  inviteStatus:(NSString *)inviteStatus
{
    NSInteger companyStatusI = [companyStatus integerValue];
    NSInteger userStatusI = [userStatus integerValue];
    NSInteger hasFeedbackI = [hasFeedback integerValue];
    
    if ([inviteStatus isEqualToString:@"2"]) {
        self.processButton.enabled = NO;
    }
    else{
        self.processButton.enabled = YES;
    }
    
    
    
    if (companyStatusI == 1 && userStatusI == 0) {
        [self.processButton setTitle:@"查看面试邀请" forState:UIControlStateNormal];
        self.type = IKJobProcessButtonTypeCheckInterview;
    }
    else if (companyStatusI == 1 && userStatusI == 1){
        [self.processButton setTitle:@"面试结束并进行评价" forState:UIControlStateNormal];
        self.type = IKJobProcessButtonTypeInterViewEndToAppraise;
    }
    else if (userStatusI == 2){
        [self.processButton setTitle:@"进行面试评价" forState:UIControlStateNormal];
        self.type = IKJobProcessButtonTypeGoingAppraise;
    }
    else if (userStatusI == 3 && hasFeedbackI == 1){
        [self.processButton setTitle:@"查看评价" forState:UIControlStateNormal];
        self.type = IKJobProcessButtonTypeCheckAppraise;
    }
    else{
        [self.processButton setTitle:@"聊一聊" forState:UIControlStateNormal];
        self.type = IKJobProcessButtonTypeChat;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
