//
//  IKResumeSkillTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/17.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKResumeSkillTableViewCell.h"


@interface IKResumeSkillTableViewCell ()

@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UIView *vLineView;
@property (nonatomic, strong)UILabel *tagLabel;
@property (nonatomic, strong)UIButton *garbageBtn;
@property (nonatomic, strong)UIButton *editBtn;
@property (nonatomic, strong)UILabel *psLabel;
@property (nonatomic, copy)NSDictionary *dataDict;

@property (nonatomic, strong)UIImageView *logoImageView;


@end
@implementation IKResumeSkillTableViewCell

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
    [self.contentView addSubview:self.vLineView];
    [self.contentView addSubview:self.tagLabel];
    [self.contentView addSubview:self.garbageBtn];
    [self.contentView addSubview:self.editBtn];
    [self.contentView addSubview:self.psLabel];

    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.and.height.mas_equalTo(50);
    }];
    
    [_vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(_logoImageView.mas_right).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.mas_equalTo(1);
    }];
    
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(_vLineView.mas_right).offset(20);
//        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25);
    }];
    
    [_garbageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.width.and.height.mas_equalTo(26);
    }];
    
    [_psLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(_tagLabel.mas_left);
        make.right.equalTo(_garbageBtn.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_garbageBtn.mas_top);
        make.width.and.height.equalTo(_garbageBtn);
        make.right.equalTo(_garbageBtn.mas_left).offset(-30);
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
        [_logoImageView setImage:[UIImage imageNamed:@"IK_certificate"]];
    }
    return _logoImageView;
}


- (UILabel *)tagLabel
{
    if (_tagLabel == nil) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.font = [UIFont systemFontOfSize:14.0f];
        _tagLabel.textColor = IKGeneralBlue;
        _tagLabel.text = @"EXOS";
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.layer.cornerRadius = 12.5f;
        _tagLabel.layer.borderWidth = 1.0f;
        _tagLabel.layer.borderColor = IKGeneralBlue.CGColor;
        
    }
    return _tagLabel;
}

- (UILabel *)psLabel
{
    if (_psLabel == nil) {
        _psLabel = [[UILabel alloc] init];
        _psLabel.font = [UIFont systemFontOfSize:13.0f];
        _psLabel.textColor = IKSubHeadTitleColor;
//        _psLabel.text = @"已认证    无证书    3~5年    高级";
        _psLabel.textAlignment = NSTextAlignmentLeft;
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

- (UIView *)vLineView
{
    if (_vLineView == nil) {
        _vLineView = [[UIView alloc] init];
        _vLineView.backgroundColor = IKLineColor;
    }
    return _vLineView;
}


- (void)garbageBtnClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(resumeSkillCellDeleteButtonClick:)]) {
        [self.delegate resumeSkillCellDeleteButtonClick:self];
    }
}


- (void)editBtnClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(resumeSkillCellEditButtonClickWithData: cell:)]) {
        [self.delegate resumeSkillCellEditButtonClickWithData:self.dataDict cell:self];
    }
}



- (void)addResumeSkillCellData:(NSDictionary *)dict
{
    NSLog(@"addResumeSkillCellData = %@",dict);
    self.dataDict = [NSDictionary dictionaryWithDictionary:dict];
    
    NSString *name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];
    
    CGSize size = [NSString getSizeWithString:name size:CGSizeMake(IKSCREEN_WIDTH - 210, 25) attribute:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
    
    self.tagLabel.text = name;

    [_tagLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(_vLineView.mas_right).offset(20);
        make.width.mas_equalTo(size.width + 10);
        make.height.mas_equalTo(25);
    }];
    
    NSString *hasCert = @"无证书";
    if ([[dict objectForKey:@"has_certificate"] isEqualToString:@"1"]) {
        hasCert = @"有证书";
    }
    
     NSString *hasApprove = @"未认证";
    if ([[dict objectForKey:@"is_approve"] isEqualToString:@"1"]) {
        hasApprove = @"已认证";
    }
    
    NSString *experience = [NSString stringWithFormat:@"%@",[dict objectForKey:@"experienceTypeName"]];
    NSString *level = [NSString stringWithFormat:@"%@",[dict objectForKey:@"levelName"]];

    self.psLabel.text = [NSString stringWithFormat:@"%@    %@    %@    %@",hasApprove,hasCert,experience,level];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
