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
@property(nonatomic,strong)UIImageView *authImageView;
@property(nonatomic,strong)UILabel     *titleLabel;
@property(nonatomic,strong)UILabel     *salaryLabel;
@property(nonatomic,strong)IKImageWordView     *addressView;
@property(nonatomic,strong)IKImageWordView     *experienceView;
@property(nonatomic,strong)IKImageWordView     *educationView;
@property(nonatomic,strong)UILabel     *skillLabel1;
@property(nonatomic,strong)UILabel     *skillLabel2;
@property(nonatomic,strong)UILabel     *skillLabel3;
@property(nonatomic,strong)UILabel     *introduceLabel;
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
    [self.contentView insertSubview:self.authImageView aboveSubview:self.logoImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.salaryLabel];
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
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        _logoImageView.backgroundColor = IKGeneralLightGray;
        _logoImageView.layer.borderWidth = 1.0;
        _logoImageView.layer.borderColor = IKGeneralLightGray.CGColor;
        _logoImageView.layer.cornerRadius = 6;
    }
    return _logoImageView;
}


- (UIImageView *)authImageView
{
    if (_authImageView == nil) {
        _authImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
        _authImageView.contentMode = UIViewContentModeScaleToFill;
        _authImageView.hidden = YES;
        _authImageView.image = [UIImage imageNamed:@"IK_authen"];
    }
    
    return _authImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        // 标题
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _titleLabel.textColor = IKMainTitleColor;
        _titleLabel.backgroundColor = IKGeneralLightGray;
    }
    return _titleLabel;
}

- (UILabel *)salaryLabel
{
    if (_salaryLabel == nil) {
        // 薪水
        _salaryLabel = [[UILabel alloc] init];
        _salaryLabel.textAlignment = NSTextAlignmentCenter;
        _salaryLabel.layer.cornerRadius = 10;
        _salaryLabel.layer.masksToBounds = YES;
        _salaryLabel.font = [UIFont boldSystemFontOfSize:IKSubTitleFont];
        _salaryLabel.layer.backgroundColor = [IKGeneralRed colorWithAlphaComponent:0.7].CGColor;
        _salaryLabel.textColor = [UIColor whiteColor];
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
        _introduceLabel.textAlignment = NSTextAlignmentLeft;
        _introduceLabel.font = [UIFont systemFontOfSize:11.0f];
        _introduceLabel.textColor = IKSubHeadTitleColor;
        _introduceLabel.numberOfLines = 2;
        _introduceLabel.backgroundColor = IKGeneralLightGray;
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
    label.font = [UIFont systemFontOfSize:10.0f];
    label.textColor = IKGeneralBlue;
    label.layer.borderColor = IKGeneralBlue.CGColor;
    label.layer.borderWidth = 0.5;
    label.layer.cornerRadius = 10;
    label.hidden = YES;
    label.backgroundColor = IKGeneralLightGray;
    return label;
}


- (void)layoutCellSubviews
{
    __weak typeof (self) weakSelf = self;

    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(5);
        make.left.equalTo(weakSelf).offset(10);
//        make.bottom.equalTo(self).offset(-5);
        make.width.and.height.mas_equalTo(weakSelf.bounds.size.height - 10);
    }];
    
    
    [_authImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(_logoImageView);
        make.width.and.height.mas_equalTo(36);
    }];
    
    [_salaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(8);
        make.right.equalTo(weakSelf).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(90);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(8);
        make.left.equalTo(_logoImageView.mas_right).offset(9);
        make.height.mas_equalTo(20);
        make.right.equalTo(_salaryLabel.mas_left);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(1);
        make.top.equalTo(weakSelf.mas_bottom).offset(-1);
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
    
    self.logoImageView.backgroundColor = [UIColor whiteColor];
    self.authImageView.hidden = !model.isAuthen;
    
    self.titleLabel.text = model.title;
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    self.salaryLabel.text = model.salary;
    
    self.addressView.label.text = model.address;
    
    CGFloat addressWidth = [self getStringWdith:_addressView.label.text fontSize:IKSubTitleFont];
    
    [_addressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(1);
        make.left.equalTo(_titleLabel);
        make.width.mas_equalTo(addressWidth + 20);
        make.height.mas_equalTo(20);
    }];
    
    self.experienceView.label.text = model.experience;
    CGFloat experienceWidth = [self getStringWdith:_experienceView.label.text fontSize:IKSubTitleFont];
    
    [_experienceView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_addressView);
        make.left.equalTo(_addressView.mas_right).offset(2);
        make.width.mas_equalTo(experienceWidth + 20);
    }];
    
    self.educationView.label.text = model.education;

    CGFloat educationWidth = [self getStringWdith:_educationView.label.text fontSize:IKSubTitleFont];
    
    [_educationView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.equalTo(_addressView);
        make.left.equalTo(_experienceView.mas_right).offset(2);
        make.width.mas_equalTo(educationWidth + 20);
    }];
    
    self.introduceLabel.text = model.introduce;
    self.introduceLabel.backgroundColor = [UIColor whiteColor];

    
    if (IKStringIsEmpty(model.skill1) && IKStringIsEmpty(model.skill2) && IKStringIsEmpty(model.skill3)) {
        self.skillLabel1.hidden = YES;
        self.skillLabel2.hidden = YES;
        self.skillLabel3.hidden = YES;
        
        [_introduceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_addressView.mas_bottom);
            make.left.equalTo(_titleLabel);
            make.height.mas_equalTo(30);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
    }
    else{
        if (IKStringIsNotEmpty(model.skill1)) {
            self.skillLabel1.hidden = NO;
            self.skillLabel1.text = model.skill1;
            self.skillLabel1.backgroundColor = [UIColor whiteColor];

            CGFloat width1 = [self getStringWdith:self.skillLabel1.text fontSize:12.0f];
            [_skillLabel1 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_addressView.mas_bottom).offset(3);
                make.left.and.height.equalTo(_addressView);
                make.width.mas_equalTo(width1);
            }];
        }
        else{
            self.skillLabel1.hidden = YES;
        }
        
        if (IKStringIsNotEmpty(model.skill2)) {
            self.skillLabel2.hidden = NO;
            _skillLabel2.text = model.skill2;
            self.skillLabel2.backgroundColor = [UIColor whiteColor];

            CGFloat width2 = [self getStringWdith:self.skillLabel2.text fontSize:12.0f];
            [_skillLabel2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.and.height.equalTo(_skillLabel1);
                make.left.equalTo(_skillLabel1.mas_right).offset(5);
                make.width.mas_equalTo(width2);
            }];
        }
        else{
            self.skillLabel2.hidden = YES;
        }
        
        if (IKStringIsNotEmpty(model.skill3)) {
            self.skillLabel3.hidden = NO;
            self.skillLabel3.text = model.skill3;
            self.skillLabel3.backgroundColor = [UIColor whiteColor];

            CGFloat width3 = [self getStringWdith:self.skillLabel3.text fontSize:12.0f];
            [_skillLabel3 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.and.height.equalTo(_skillLabel1);
                make.left.equalTo(_skillLabel2.mas_right).offset(5);
                make.width.mas_equalTo(width3);
            }];
        }
        else{
            self.skillLabel3.hidden = YES;
        }
        
        [_introduceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_skillLabel1.mas_bottom).offset(2);
            make.left.equalTo(_titleLabel);
            make.height.mas_equalTo(30);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
    }
    
    [self needsUpdateConstraints];
}


- (CGFloat )getStringWdith:(NSString *)string fontSize:(CGFloat )fontSize
{
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:fontSize]};
    CGSize size = [NSString getSizeWithString:string size:CGSizeMake(MAXFLOAT, 20) attribute:attribute];
    
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
