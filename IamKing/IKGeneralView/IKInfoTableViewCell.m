//
//  IKInfoTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKInfoTableViewCell.h"

#define IKSikllLabelWidth (70)



@interface IKInfoTableViewCell ()

@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)UILabel     *titleLabel;
@property(nonatomic,strong)UILabel     *salaryLabel;
@property(nonatomic,strong)IKImageWordView     *addressView;
@property(nonatomic,strong)IKImageWordView     *experienceView;
@property(nonatomic,strong)IKImageWordView     *educationView;
@property(nonatomic,strong)UILabel     *skillLabel1;
@property(nonatomic,strong)UILabel     *skillLabel2;
@property(nonatomic,strong)UILabel     *skillLabel3;
@property(nonatomic,strong)UILabel     *introduceLabel;
@property(nonatomic,strong)UIView      *maskView;
@property(nonatomic,strong)UIView      *bottomLine;


@end


@implementation IKInfoTableViewCell

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
    [self.contentView addSubview:self.logoImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.salaryLabel];
    [self.contentView insertSubview:self.maskView belowSubview:self.salaryLabel];
    [self.contentView addSubview:self.addressView];
    [self.contentView addSubview:self.experienceView];
    [self.contentView addSubview:self.educationView];
    [self.contentView addSubview:self.skillLabel1];
    [self.contentView addSubview:self.skillLabel2];
    [self.contentView addSubview:self.skillLabel3];
    [self.contentView addSubview:self.introduceLabel];
    [self.contentView addSubview:self.bottomLine];

}


#pragma mark - Property

- (UIImageView *)logoImageView
{
    if (_logoImageView == nil) {
        // 头像
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height - 10, self.bounds.size.height - 10)];
        _logoImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _logoImageView;
}


- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        // 标题
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont boldSystemFontOfSize:IKTitleFont];
        _titleLabel.textColor = IKMainTitleColor;
    }
    return _titleLabel;
}

- (UILabel *)salaryLabel
{
    if (_salaryLabel == nil) {
        // 薪水
        _salaryLabel = [[UILabel alloc] init];
        _salaryLabel.textAlignment = NSTextAlignmentLeft;
        _salaryLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        _salaryLabel.layer.backgroundColor = IKRGBColor(246.0, 101.0, 101.0).CGColor;
        _salaryLabel.textColor = [UIColor whiteColor];
    }
    return _salaryLabel;
}

- (UIView *)maskView
{
    if (_maskView == nil) {
        //遮盖 薪水左边的圆角
        _maskView = [[UIView alloc] init];
        _maskView.layer.backgroundColor = IKRGBColor(246.0, 101.0, 101.0).CGColor;
        _maskView.layer.cornerRadius = 10;
    }
    return _maskView;
}

- (IKImageWordView *)addressView
{
    if (_addressView == nil) {
        // 地点
        _addressView = [[IKImageWordView alloc] init];
    }
    return _addressView;
}

- (IKImageWordView *)experienceView
{
    if (_experienceView == nil) {
        // 工作经验
        _experienceView = [[IKImageWordView alloc] init];
    }
    return _experienceView;
}


- (IKImageWordView *)educationView
{
    if (_educationView == nil) {
        // 学历
        _educationView = [[IKImageWordView alloc] init];
    }
    return _educationView;
}


- (UILabel *)skillLabel1
{
    if (_skillLabel1 == nil) {
        _skillLabel1 = [self getSkillLabel];
    }
    
    return _skillLabel1;
}

- (UILabel *)skillLabel2
{
    if (_skillLabel2 == nil) {
        _skillLabel2 = [self getSkillLabel];
    }
    
    return _skillLabel2;
}

- (UILabel *)skillLabel3
{
    if (_skillLabel3 == nil) {
        _skillLabel3 = [self getSkillLabel];
    }
    
    return _skillLabel3;
}


- (UILabel *)introduceLabel
{
    if (_introduceLabel == nil) {
        //介绍
        _introduceLabel = [[UILabel alloc] init];
        _introduceLabel.textAlignment = NSTextAlignmentCenter;
        _introduceLabel.font = [UIFont boldSystemFontOfSize:11.0f];
        _introduceLabel.textColor = IKRGBColor(164.0, 164.0, 164.0);
        _introduceLabel.numberOfLines = 0;
    }
    return _introduceLabel;
}

- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = IKGeneralLightGray;
    }
    return _bottomLine;
}

- (UILabel *)getSkillLabel
{
    // 技能1
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:12.0f];
    label.textColor = IKGeneralBlue;
    label.layer.borderColor = IKGeneralBlue.CGColor;
    label.layer.borderWidth = 0.5;
    label.layer.cornerRadius = 10;
    return label;
}


- (void)layoutCellSubviews
{
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(10);
//        make.bottom.equalTo(self).offset(-5);
        make.width.and.height.mas_equalTo(self.bounds.size.height - 10);
    }];
    
    [_salaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.right.equalTo(self);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
    }];
    
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_salaryLabel);
        make.left.equalTo(_salaryLabel.mas_left).offset(-10);
        make.width.mas_equalTo(30);
        make.height.equalTo(_salaryLabel);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.left.equalTo(_logoImageView.mas_right).offset(9);
        make.height.mas_equalTo(20);
        make.right.equalTo(_maskView.mas_left);
    }];
    
    [_introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_skillLabel1.mas_bottom);
        make.left.equalTo(_titleLabel);
        make.bottom.equalTo(_logoImageView.mas_bottom);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.mas_bottom).offset(-1);
    }];
}


- (void)layoutSubviews
{
    [self layoutCellSubviews];

    [super layoutSubviews];
}


// 设置 cell 卡片样式
//- (void)setFrame:(CGRect)frame //重写frame.
//{
//    frame.origin.x = 10;
//    frame.origin.y += 5;
//    frame.size.width -= 20;
//    frame.size.height -= 10;
//    
//    [super setFrame:frame];
//}



- (void)addCellData:(IKJobInfoModel *)model
{
    [self.logoImageView lwb_loadImageWithUrl:model.logoImageUrl placeHolderImageName:nil radius:5.0];

    self.titleLabel.text = model.title;
    self.salaryLabel.text = model.salary;
    self.addressView.imageName = @"IK_applyJobAddress";
    self.addressView.word = model.address;
    self.educationView.imageName = @"IK_education";
    self.educationView.word = model.education;
    self.experienceView.imageName = @"IK_experience";
    self.experienceView.word = model.experience;
    self.skillLabel1.text = model.skill1;
    self.skillLabel2.text = model.skill2;
    self.skillLabel3.text = model.skill3;
    self.introduceLabel.text = model.introduce;
    
    [self updateSkillLabelFrame];

}


- (void)updateSkillLabelFrame
{
//    CGFloat addresswidth = [self getSkillLabelWdith:self.skillLabel1.text size:CGSizeMake(MAXFLOAT, 20)];

    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(1);
        make.left.equalTo(_titleLabel);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    
    [_experienceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.and.height.equalTo(_addressView);
        make.left.equalTo(_addressView.mas_right).offset(2);
    }];
    
    [_educationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.and.height.equalTo(_addressView);
        make.left.equalTo(_experienceView.mas_right).offset(2);
    }];
    
    CGFloat width1 = [self getSkillLabelWdith:self.skillLabel1.text size:CGSizeMake(MAXFLOAT, 20)];
    
    [_skillLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressView.mas_bottom).offset(1);
        make.left.and.height.equalTo(_addressView);
        make.width.mas_equalTo(width1);
    }];
    
    CGFloat width2 = [self getSkillLabelWdith:self.skillLabel2.text size:CGSizeMake(MAXFLOAT, 20)];

    [_skillLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_skillLabel1);
        make.left.equalTo(_skillLabel1.mas_right).offset(5);
        make.width.mas_equalTo(width2);
    }];
    
    CGFloat width3 = [self getSkillLabelWdith:self.skillLabel3.text size:CGSizeMake(MAXFLOAT, 20)];

    [_skillLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_skillLabel1);
        make.left.equalTo(_skillLabel2.mas_right).offset(5);
        make.width.mas_equalTo(width3);
    }];
}

- (CGFloat )getSkillLabelWdith:(NSString *)string size:(CGSize )inSize
{
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:12.0f]};
    CGSize size = [NSString getSizeWithString:string size:inSize attribute:attribute];
    
    if (size.width > IKSikllLabelWidth) {
        return IKSikllLabelWidth;
    }
    return size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
