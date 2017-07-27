//
//  IKSkillTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/27.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSkillTableViewCell.h"
#import "IKTipsView.h"

@interface IKSkillTableViewCell ()

@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *nameBtn;
@property(nonatomic,strong)UIButton *button1;
@property(nonatomic,strong)UIButton *button2;
@property(nonatomic,strong)UIButton *button3;
@property(nonatomic,strong)UIButton *button4;
@property(nonatomic,strong)UIView  *lineView;

@property(nonatomic, strong)UIButton *skill1;
@property(nonatomic, strong)UIButton *skill2;
@property(nonatomic, strong)UIButton *skill3;
@property(nonatomic, assign)CGFloat   maxSkillButtonWidth;
@property(nonatomic, assign)CGFloat   width;
@property(nonatomic, assign)CGFloat   skill1Width;
@property(nonatomic, assign)CGFloat   skill2Width;
@property(nonatomic, assign)CGFloat   skill3Width;

@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)UILabel *label3;
@property(nonatomic,strong)UILabel *label4;
@property(nonatomic,strong)UILabel *label5;
@property(nonatomic,strong)UILabel *label6;
@property(nonatomic,strong)UILabel *label7;
@property(nonatomic,strong)UILabel *label8;
@property(nonatomic,strong)UILabel *label9;
@property(nonatomic,strong)UILabel *label10;
@property(nonatomic,strong)UILabel *label11;
@property(nonatomic,strong)UILabel *label12;

@end


@implementation IKSkillTableViewCell

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
    _maxSkillButtonWidth = ceilf(IKSCREEN_WIDTH * 0.18);
    
    [self.contentView addSubview:self.imageview];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.nameBtn];
    [self.contentView addSubview:self.button1];
    [self.contentView addSubview:self.button2];
    [self.contentView addSubview:self.button3];
    [self.contentView addSubview:self.button4];
    
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.width.and.height.mas_equalTo(15);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_imageview);
        make.left.equalTo(_imageview.mas_right).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(20);
    }];
    
    [_nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(_lineView.mas_left);
        make.height.mas_equalTo(20);
    }];
    
     _width = ceilf(IKSCREEN_WIDTH * 0.653 * 0.25);
    
    [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameBtn.mas_top);
        make.left.equalTo(_lineView.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
    
    [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameBtn.mas_top);
        make.left.equalTo(_button1.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
    
    [_button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameBtn.mas_top);
        make.left.equalTo(_button2.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
    
    [_button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameBtn.mas_top);
        make.left.equalTo(_button3.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
    
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
        _titleLabel.textColor =  IKMainTitleColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"此职位需要拥有的专业认证/技能及相关要求";
    }
    
    return _titleLabel;
}

- (UIButton *)nameBtn
{
    if (_nameBtn == nil) {
        _nameBtn = [self createButtonWithTag:1005];
        _nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_nameBtn setTitle:@"专业/技能名称" forState:UIControlStateNormal] ;
    }
    return _nameBtn;
}

- (UIButton *)button1
{
    if (_button1 == nil) {
        _button1 = [self createButtonWithTag:1001];
        [_button1 setTitle:@"认证要求" forState:UIControlStateNormal] ;
    }
    return _button1;
}

- (UIButton *)button2
{
    if (_button2 == nil) {
        _button2 = [self createButtonWithTag:1002];
        [_button2 setTitle:@"持证要求" forState:UIControlStateNormal] ;
    }
    return _button2;
}

- (UIButton *)button3
{
    if (_button3 == nil) {
        _button3 = [self createButtonWithTag:1003];
        [_button3 setTitle:@"技能经验" forState:UIControlStateNormal] ;
    }
    return _button3;
}

- (UIButton *)button4
{
    if (_button4 == nil) {
        _button4 = [self createButtonWithTag:1004];
        [_button4 setTitle:@"技能等级" forState:UIControlStateNormal] ;
    }
    return _button4;
}

- (UIButton *)createButtonWithTag:(NSInteger )tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.tag = tag;
    [button addTarget:self action:@selector(defaultButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIImageView *)imageview
{
    if (_imageview == nil) {
        _imageview = [[UIImageView alloc] init];
        [_imageview setImage:[UIImage imageNamed:@"IK_jobDesc"]];
    }
    return _imageview;
}


- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = IKLineColor;
    }
    return _lineView;
}


- (UIButton *)skill1
{
    if (_skill1 == nil) {
        _skill1 = [self createSkillButtonWithTag:2001];
    }
    return _skill1;
}

- (UIButton *)skill2
{
    if (_skill2 == nil) {
        _skill2 = [self createSkillButtonWithTag:2002];
    }
    return _skill2;
}

- (UIButton *)skill3
{
    if (_skill3 == nil) {
        _skill3 = [self createSkillButtonWithTag:2003];
    }
    return _skill3;
}


- (UIButton *)createSkillButtonWithTag:(NSInteger )tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.tag = tag;
    button.layer.cornerRadius = 8;
    button.layer.borderColor = IKGeneralBlue.CGColor;
    button.layer.borderWidth = 1.0;
    button.userInteractionEnabled = NO;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
    button.titleLabel.lineBreakMode =  NSLineBreakByTruncatingTail;
    [button addTarget:self action:@selector(skillButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (UILabel *)createLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textColor =  IKMainTitleColor;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (UILabel *)label1
{
    if (_label1 == nil) {
        _label1 = [self createLabel];
        _label1.text = @"必需";
    }
    return _label1;
}

- (UILabel *)label2
{
    if (_label2 == nil) {
        _label2 = [self createLabel];
        _label2.text = @"必需";
    }
    return _label2;
}

- (UILabel *)label3
{
    if (_label3 == nil) {
        _label3 = [self createLabel];
        _label3.text = @"一年以下";
    }
    return _label3;
}

- (UILabel *)label4
{
    if (_label4 == nil) {
        _label4 = [self createLabel];
        _label4.text = @"初级";
    }
    return _label4;
}

- (UILabel *)label5
{
    if (_label5 == nil) {
        _label5 = [self createLabel];
        _label5.text = @"必需";
    }
    return _label5;
}

- (UILabel *)label6
{
    if (_label6 == nil) {
        _label6 = [self createLabel];
        _label6.text = @"必需";
    }
    return _label6;
}

- (UILabel *)label7
{
    if (_label7 == nil) {
        _label7 = [self createLabel];
        _label7.text = @"一年以下";
    }
    return _label7;
}

- (UILabel *)label8
{
    if (_label8 == nil) {
        _label8 = [self createLabel];
        _label8.text = @"初级";
    }
    return _label8;
}

- (UILabel *)label9
{
    if (_label9 == nil) {
        _label9 = [self createLabel];
        _label9.text = @"必需";
    }
    return _label9;
}

- (UILabel *)label10
{
    if (_label10 == nil) {
        _label10 = [self createLabel];
        _label10.text = @"必需";
    }
    return _label10;
}

- (UILabel *)label11
{
    if (_label11 == nil) {
        _label11 = [self createLabel];
        _label11.text = @"一年以下";
    }
    return _label11;
}

- (UILabel *)label12
{
    if (_label12 == nil) {
        _label12 = [self createLabel];
        _label12.text = @"初级";
    }
    return _label12;
}


- (void)addSkillOneWithData:(NSDictionary *)dict
{
    [self.contentView addSubview:self.skill1];
    
    NSString *str = [NSString stringWithFormat:@"qweeeeeeeeeeeeeee%@",[dict objectForKey:@"name"]];
    [self.skill1 setTitle:str forState:UIControlStateNormal];
    
    CGFloat w = [NSString getSizeWithString:str size:CGSizeMake(MAXFLOAT, 16) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:11.0f]}].width;
    NSLog(@"wwwwwwwww = %.0f",w);
    self.skill1Width = w;
    
    if (w > _maxSkillButtonWidth) {
        w = _maxSkillButtonWidth;
        self.skill1.userInteractionEnabled = YES;
    }
    
    [_skill1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameBtn.mas_bottom).offset(15);
        make.left.equalTo(_nameBtn.mas_left);
        make.width.mas_equalTo(w + 5);
        make.height.mas_equalTo(16);
    }];
    
    [self.contentView addSubview:self.label1];
    [self.contentView addSubview:self.label2];
    [self.contentView addSubview:self.label3];
    [self.contentView addSubview:self.label4];

    
    if ([[dict objectForKey:@"isApprove"] isEqualToString:@"0"]) {
        self.label1.text = @"无需";
    }
    
    if ([[dict objectForKey:@"hasCertificate"] isEqualToString:@"0"]) {
        self.label2.text = @"无需";
    }
    
    self.label3.text = [dict objectForKey:@"experienceName"];
    self.label4.text = [dict objectForKey:@"level_name"];

    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_skill1.mas_centerY);
        make.left.equalTo(_lineView.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label1.mas_top);
        make.left.equalTo(_label1.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
    
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label1.mas_top);
        make.left.equalTo(_label2.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
    
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label1.mas_top);
        make.left.equalTo(_label3.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
    
   
}

- (void)addSkillTwoWithData:(NSDictionary *)dict
{
    [self.contentView addSubview:self.skill2];
    NSString *str = [dict objectForKey:@"name"];

    [self.skill2 setTitle:str forState:UIControlStateNormal];
    
    CGFloat w = [NSString getSizeWithString:str size:CGSizeMake(MAXFLOAT, 16) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:11.0f]}].width;
    NSLog(@"wwwwwwwww 2 = %.0f",w + 5);
    self.skill2Width = w;
    if (w > _maxSkillButtonWidth) {
        w = _maxSkillButtonWidth;
        self.skill2.userInteractionEnabled = YES;
    }
    
    [_skill2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_skill1.mas_bottom).offset(15);
        make.left.equalTo(_nameBtn.mas_left);
        make.width.mas_equalTo(w + 5);
        make.height.mas_equalTo(16);
    }];
    
    [self.contentView addSubview:self.label5];
    [self.contentView addSubview:self.label6];
    [self.contentView addSubview:self.label7];
    [self.contentView addSubview:self.label8];
    
    
    if ([[dict objectForKey:@"isApprove"] isEqualToString:@"0"]) {
        self.label5.text = @"无需";
    }
    
    if ([[dict objectForKey:@"hasCertificate"] isEqualToString:@"0"]) {
        self.label6.text = @"无需";
    }
    
    self.label7.text = [dict objectForKey:@"experienceName"];
    self.label8.text = [dict objectForKey:@"level_name"];
    
    [_label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_skill2.mas_centerY);
        make.left.equalTo(_lineView.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
    
    [_label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label5.mas_top);
        make.left.equalTo(_label5.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
    
    [_label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label5.mas_top);
        make.left.equalTo(_label6.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
    
    [_label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label5.mas_top);
        make.left.equalTo(_label7.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
}


- (void)addSkillThreeWithData:(NSDictionary *)dict
{
    [self.contentView addSubview:self.skill3];
    NSString *str = [NSString stringWithFormat:@"qweeeeeeeeeeeeeee%@",[dict objectForKey:@"name"]];
    
    [self.skill3 setTitle:str forState:UIControlStateNormal];
    
    CGFloat w = [NSString getSizeWithString:str size:CGSizeMake(MAXFLOAT, 16) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:11.0f]}].width;
    NSLog(@"wwwwwwwww 3 = %.0f",w);
    self.skill3Width = w;

    if (w > _maxSkillButtonWidth) {
        w = _maxSkillButtonWidth;
        self.skill3.userInteractionEnabled = YES;
    }
    [_skill3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_skill2.mas_bottom).offset(15);
        make.left.equalTo(_nameBtn.mas_left);
        make.width.mas_equalTo(w + 5);
        make.height.mas_equalTo(16);
    }];
    
    [self.contentView addSubview:self.label9];
    [self.contentView addSubview:self.label10];
    [self.contentView addSubview:self.label11];
    [self.contentView addSubview:self.label12];
    
    
    if ([[dict objectForKey:@"isApprove"] isEqualToString:@"0"]) {
        self.label9.text = @"无需";
    }
    
    if ([[dict objectForKey:@"hasCertificate"] isEqualToString:@"0"]) {
        self.label10.text = @"无需";
    }
    
    self.label11.text = [dict objectForKey:@"experienceName"];
    self.label12.text = [dict objectForKey:@"level_name"];
    
    [_label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_skill3.mas_centerY);
        make.left.equalTo(_lineView.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
    
    [_label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label9.mas_top);
        make.left.equalTo(_label9.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
    
    [_label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label9.mas_top);
        make.left.equalTo(_label10.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
    
    [_label12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label9.mas_top);
        make.left.equalTo(_label11.mas_right);
        make.height.equalTo(_nameBtn);
        make.width.mas_equalTo(_width);
    }];
}



- (void)setLineConstraint:(NSInteger )index
{
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(8);
        make.left.mas_equalTo(IKSCREEN_WIDTH * 0.293);
        if (index == 1) {
            make.bottom.equalTo(self.skill1.mas_bottom);
        }
        else if (index == 2){
            make.bottom.equalTo(self.skill2.mas_bottom);
        }
        else{
            make.bottom.equalTo(self.skill3.mas_bottom);
        }
        
        make.width.mas_equalTo(1);
    }];
    
}

- (void)defaultButtonClick:(UIButton *)button
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    //获取button在contentView的位置
    CGRect rect1 = [button convertRect:button.frame fromView:self.contentView];
    CGRect rect2 = [button convertRect:rect1 toView:window];
    
    switch (button.tag) {
        case 1001:
        {
            CGRect frame = CGRectMake(rect2.origin.x + rect2.size.width * 0.5, rect2.origin.y, 170, 24);
            [self showTipsWithViewFrame:frame tipsContent:@"是否必须经官方权威机构认证"];
        }            
            break;
        case 1002:
        {
            CGRect frame = CGRectMake(rect2.origin.x + rect2.size.width * 0.5, rect2.origin.y, 170, 24);
            [self showTipsWithViewFrame:frame tipsContent:@"是否必须持有认证证书才聘用"];
        }
            break;
        case 1003:
        {
            CGRect frame = CGRectMake(rect2.origin.x + rect2.size.width * 0.5, rect2.origin.y, 120, 24);
            [self showTipsWithViewFrame:frame tipsContent:@"需要多久的授课经验"];
        }
            break;
        case 1004:
        {
            CGRect frame = CGRectMake(rect2.origin.x + rect2.size.width * 0.5, rect2.origin.y, 80, 40);
            [self showTipsWithViewFrame:frame tipsContent:@"需要达到什么等级"];
        }
            break;
        case 1005:
        {
            CGRect frame = CGRectMake(rect2.origin.x + rect2.size.width * 0.5, rect2.origin.y, 90, 24);
            [self showTipsWithViewFrame:frame tipsContent:@"专业/技能名称"];
        }
            break;
        default:
            break;
    }
}

- (void)skillButtonClick:(UIButton *)button
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    //获取button在contentView的位置
    CGRect rect1 = [button convertRect:button.frame fromView:self.contentView];
    CGRect rect2 = [button convertRect:rect1 toView:window];

    CGFloat w = 0;
    switch (button.tag) {
        case 2001:
            w = self.skill1Width;
            break;
        case 2002:
            w = self.skill2Width;
            NSLog(@"22");
            break;
        case 2003:
            w = self.skill3Width;
            NSLog(@"23");
            break;

        default:
            break;
    }
        
    CGFloat h = 24;
    
    if (w > 100) {
        w = 100;
        h = 40;
    }
    [self showTipsWithViewFrame:CGRectMake(rect2.origin.x + rect2.size.width * 0.5, rect2.origin.y, w, h) tipsContent:button.titleLabel.text];
}


- (void)showTipsWithViewFrame:(CGRect )frame tipsContent:(NSString *)content
{
    IKTipsView *tips = [[IKTipsView alloc] initWithFrame:frame arrowDirection:IKTipsArrowDirectionDownCenter bgColor:IKGeneralBlue];
    tips.tipsContent = content;
    [tips popView];
}


- (void)addSkillCellData:(NSArray *)tagList
{
    switch (tagList.count) {
        case 1:
            NSLog(@"11111");
            [self addSkillOneWithData:tagList.firstObject];
            [self setLineConstraint:1];
            break;
        case 2:
            NSLog(@"22222");
            [self addSkillOneWithData:tagList.firstObject];
            [self addSkillTwoWithData:[tagList objectAtIndex:1]];
            [self setLineConstraint:2];
            break;

        case 3:
            NSLog(@"33333");
            [self addSkillOneWithData:tagList.firstObject];
            [self addSkillTwoWithData:[tagList objectAtIndex:1]];
            [self addSkillThreeWithData:[tagList objectAtIndex:2]];
            [self setLineConstraint:3];
            break;

        default:
            break;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
