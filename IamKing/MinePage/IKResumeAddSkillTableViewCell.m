//
//  IKResumeAddSkillTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/23.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKResumeAddSkillTableViewCell.h"


@interface IKResumeAddSkillTableViewCell ()

@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UIImageView *logoImageView;


@end
@implementation IKResumeAddSkillTableViewCell

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
    NSLog(@"height = %.0f",self.frame.size.height);
    [self.contentView addSubview:self.lineView];
    [_lineView addSubview:self.logoImageView];
    [_lineView addSubview:self.psLabel];
    
//    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_top);
//        make.bottom.equalTo(self.contentView.mas_bottom);
//        make.centerX.equalTo(self.contentView.mas_centerX);
//        make.width.mas_equalTo(120);
//    }];
    
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lineView.mas_left);
        make.centerY.equalTo(_lineView.mas_centerY);
        make.width.and.height.mas_equalTo(20);
    }];
    
    [_psLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.mas_top);
        make.bottom.equalTo(_lineView.mas_bottom);
        make.left.equalTo(_logoImageView.mas_right);
        make.right.equalTo(_lineView.mas_right);
    }];
    
}

- (UIImageView *)logoImageView
{
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] init];
        [_logoImageView setImage:[UIImage imageNamed:@"IK_Add_blue"]];
    }
    return _logoImageView;
}


- (UILabel *)psLabel
{
    if (_psLabel == nil) {
        _psLabel = [[UILabel alloc] init];
        _psLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _psLabel.textColor = IKSubHeadTitleColor;
//        _psLabel.text = @"添加认证/技能";
        _psLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _psLabel;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(IKSCREEN_WIDTH*0.5 - 60, 0, 120, self.contentView.frame.size.height)];
//        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
