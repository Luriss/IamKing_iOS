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
    // 头像
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height - 10, self.bounds.size.height - 10)];
    _logoImageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:_logoImageView];
    
    // 标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    _titleLabel.textColor = IKRGBColor(86.0, 86.0, 86.0);
    [self.contentView addSubview:_titleLabel];
    
    // 薪水
    _salaryLabel = [[UILabel alloc] init];
    _salaryLabel.textAlignment = NSTextAlignmentCenter;
    _salaryLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    _salaryLabel.layer.backgroundColor = IKRGBColor(246.0, 101.0, 101.0).CGColor;
//    _salaryLabel.layer.cornerRadius = 10;
    _salaryLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_salaryLabel];
    
    //遮盖
    _maskView = [[UIView alloc] init];
    _maskView.layer.backgroundColor = IKRGBColor(246.0, 101.0, 101.0).CGColor;
    _maskView.layer.cornerRadius = 10;
    [self.contentView insertSubview:_maskView belowSubview:_salaryLabel];
    
    // 地点
    _addressView = [[IKImageWordView alloc] init];
    [self.contentView addSubview:_addressView];
    
    // 工作经验
    _experienceView = [[IKImageWordView alloc] init];
    [self.contentView addSubview:_experienceView];
    
    // 学历
    _educationView = [[IKImageWordView alloc] init];
    [self.contentView addSubview:_educationView];
    
    // 技能1
    _skillLabel1 = [[UILabel alloc] init];
    _skillLabel1.textAlignment = NSTextAlignmentCenter;
    _skillLabel1.font = [UIFont boldSystemFontOfSize:12.0f];
    _skillLabel1.textColor = IKGeneralBlue;
    _skillLabel1.layer.borderColor = IKGeneralBlue.CGColor;
    _skillLabel1.layer.borderWidth = 1;
    _skillLabel1.layer.cornerRadius = 10;
    [self.contentView addSubview:_skillLabel1];
    
    // 技能2
    _skillLabel2 = [[UILabel alloc] init];
    _skillLabel2.textAlignment = NSTextAlignmentCenter;
    _skillLabel2.font = [UIFont boldSystemFontOfSize:12.0f];
    _skillLabel2.textColor = IKGeneralBlue;
    _skillLabel2.layer.borderColor = IKGeneralBlue.CGColor;
    _skillLabel2.layer.borderWidth = 1;
    _skillLabel2.layer.cornerRadius = 10;
    [self.contentView addSubview:_skillLabel2];
    
    // 技能3
    _skillLabel3 = [[UILabel alloc] init];
    _skillLabel3.textAlignment = NSTextAlignmentCenter;
    _skillLabel3.font = [UIFont boldSystemFontOfSize:12.0f];
    _skillLabel3.textColor = IKGeneralBlue;
    _skillLabel3.layer.borderColor = IKGeneralBlue.CGColor;
    _skillLabel3.layer.borderWidth = 1;
    _skillLabel3.layer.cornerRadius = 10;
    [self.contentView addSubview:_skillLabel3];
    
    //介绍
    _introduceLabel = [[UILabel alloc] init];
    _introduceLabel.textAlignment = NSTextAlignmentCenter;
    _introduceLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    _introduceLabel.textColor = IKRGBColor(164.0, 164.0, 164.0);
    _introduceLabel.numberOfLines = 0;
    [self.contentView addSubview:_introduceLabel];
}


- (void)layoutCellSubviews
{
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self).offset(5);
        make.width.and.height.mas_equalTo(self.bounds.size.height - 10);
    }];
    
    [_salaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoImageView);
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
        make.top.equalTo(_logoImageView);
        make.left.equalTo(_logoImageView.mas_right).offset(5);
        make.height.mas_equalTo(20);
        make.right.equalTo(_salaryLabel.mas_left);
    }];
    
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(3);
        make.left.equalTo(_titleLabel);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    [_experienceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_addressView);
        make.left.equalTo(_addressView.mas_right).offset(2);
        make.width.mas_equalTo(70);
    }];
    
    [_educationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.and.height.equalTo(_addressView);
        make.left.equalTo(_experienceView.mas_right).offset(2);
    }];
    
//    [_skillLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_addressView.mas_bottom).offset(3);
//        make.left.and.height.equalTo(_addressView);
//        make.width.mas_equalTo(IKSikllLabelWidth);
//    }];
//    
//    [_skillLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.and.width.and.height.equalTo(_skillLabel1);
//        make.left.equalTo(_skillLabel1.mas_right).offset(5);
//    }];
//    
//    [_skillLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.and.width.and.height.equalTo(_skillLabel1);
//        make.left.equalTo(_skillLabel2.mas_right).offset(5);
//    }];
    
    [_introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_skillLabel1.mas_bottom);
        make.left.equalTo(_titleLabel);
        make.bottom.equalTo(_logoImageView.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
}


- (void)layoutSubviews
{
    [self layoutCellSubviews];

    [super layoutSubviews];
}


// 设置 cell 卡片样式
- (void)setFrame:(CGRect)frame //重写frame.
{
    frame.origin.x = 10;
    frame.origin.y += 5;
    frame.size.width -= 20;
    frame.size.height -= 10;
    
    [super setFrame:frame];
}



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
    
    CGFloat width1 = [self getSkillLabelWdith:self.skillLabel1.text];
    
    [_skillLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressView.mas_bottom).offset(3);
        make.left.and.height.equalTo(_addressView);
        make.width.mas_equalTo(width1);
    }];
    
    CGFloat width2 = [self getSkillLabelWdith:self.skillLabel2.text];

    [_skillLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_skillLabel1);
        make.left.equalTo(_skillLabel1.mas_right).offset(5);
        make.width.mas_equalTo(width2);
    }];
    
    CGFloat width3 = [self getSkillLabelWdith:self.skillLabel3.text];

    [_skillLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_skillLabel1);
        make.left.equalTo(_skillLabel2.mas_right).offset(5);
        make.width.mas_equalTo(width3);
    }];
}

- (CGFloat )getSkillLabelWdith:(NSString *)string
{
    CGSize inSize = CGSizeMake(MAXFLOAT, 20);
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
