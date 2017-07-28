//
//  IKFeedbackTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/27.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKFeedbackTableViewCell.h"
#import "IKLabel.h"


@interface IKFeedbackTableViewCell ()

@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)UIView  *bottomLineView;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *zanNumberLabel;
@property(nonatomic,strong)UIButton *zanButton;
@property(nonatomic,strong)UILabel *psLabel1;
@property(nonatomic,strong)UILabel *psLabel2;
@property(nonatomic,strong)UILabel *psLabel3;
@property(nonatomic,strong)UILabel *psLabel4;
@property(nonatomic,strong)UIView  *starView1;
@property(nonatomic,strong)UIView  *starView2;
@property(nonatomic,strong)UIView  *starView3;
@property(nonatomic,strong)UIView  *starView4;
@property(nonatomic,strong)UILabel *tipsLabel1;
@property(nonatomic,strong)UILabel *tipsLabel2;
@property(nonatomic,strong)UILabel *tipsLabel3;
@property(nonatomic,strong)IKLabel *contentLabel;

@end


@implementation IKFeedbackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier noData:(BOOL)isNoData
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        if (isNoData) {
            [self noDataLabel];
        }
        else{
            [self initSubViews];
        }
    }
    return self;
}

- (void)noDataLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"暂无评论";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13.0f];
    label.textColor = IKSubHeadTitleColor;
    
    [self.contentView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.width.and.height.equalTo(self.contentView);
    }];
}


- (void)initSubViews
{
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.zanButton];
    [self.contentView addSubview:self.zanNumberLabel];
    [self.contentView addSubview:self.psLabel1];
    [self.contentView addSubview:self.psLabel2];
    [self.contentView addSubview:self.psLabel3];
    [self.contentView addSubview:self.psLabel4];
    [self.contentView addSubview:self.starView1];
    [self.contentView addSubview:self.starView2];
    [self.contentView addSubview:self.starView3];
    [self.contentView addSubview:self.starView4];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.bottomLineView];
    
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(self.contentView).offset(22);
        make.width.and.height.mas_equalTo(40);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(18);
        make.left.equalTo(_imageV.mas_right).offset(12);
        make.height.mas_equalTo(20);
        make.width.equalTo(self.contentView).multipliedBy(0.4);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom);
        make.left.equalTo(_nameLabel.mas_left);
        make.height.mas_equalTo(18);
        make.width.equalTo(_nameLabel);
    }];
    
    [_zanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.width.and.height.mas_equalTo(16);
    }];
    
    [_zanNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(22);
        make.right.equalTo(_zanButton.mas_left).offset(-4);
        make.bottom.equalTo(_zanButton.mas_bottom);
        make.width.equalTo(self.contentView).multipliedBy(0.3);
    }];
    
    [_psLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(5);
        make.left.equalTo(_nameLabel.mas_left);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(40);
    }];
    
    [_starView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_psLabel1);
        make.left.equalTo(_psLabel1.mas_right);
        make.bottom.equalTo(_psLabel1.mas_bottom);
        make.width.mas_equalTo(80);
    }];
    
    
    
    [_starView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_psLabel1.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.equalTo(_psLabel1);
        make.width.mas_equalTo(80);
    }];
    
    [_psLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_psLabel1);
        make.right.equalTo(_starView2.mas_left);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(50);
    }];
    
    
    [_psLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_psLabel1.mas_bottom).offset(5);
        make.left.equalTo(_nameLabel.mas_left);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(50);
    }];
    
    [_starView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_psLabel3);
        make.left.equalTo(_psLabel3.mas_right);
        make.bottom.equalTo(_psLabel3.mas_bottom);
        make.width.mas_equalTo(80);
    }];
    
    [_psLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_psLabel3);
        make.right.equalTo(_starView4.mas_left);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(50);
    }];
    
    [_starView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_psLabel3.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.equalTo(_psLabel3);
        make.width.mas_equalTo(80);
    }];
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(1);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_psLabel3.mas_bottom).offset(10);
        make.left.equalTo(_nameLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
    }];
}

- (void)setShowBottomLine:(BOOL)showBottomLine
{
    self.bottomLineView.hidden = !showBottomLine;
}

- (UIView *)bottomLineView
{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = IKLineColor;
    }
    return _bottomLineView;
}

- (UIImageView *)imageV
{
    if (_imageV == nil) {
        _imageV = [[UIImageView alloc] init];
        _imageV.layer.cornerRadius = 5;
//        _imageV.backgroundColor = [UIColor redColor];
    }
    return _imageV;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
//        _nameLabel.backgroundColor = [UIColor redColor];
        _nameLabel.textColor = IKMainTitleColor;
        _nameLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
//        _nameLabel.text= @"弗兰克·马丁";
    }
    
    return _nameLabel;
}


- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        //        _nameLabel.backgroundColor = [UIColor redColor];
        _timeLabel.textColor = IKSubHeadTitleColor;
        _timeLabel.font = [UIFont systemFontOfSize:12.0f];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}


- (UIButton *)zanButton
{
    if (_zanButton == nil) {
        _zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _zanButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_zanButton setBackgroundImage:[UIImage imageNamed:@"IK_zan_grey"] forState:UIControlStateNormal];
        [_zanButton addTarget:self action:@selector(zanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zanButton;
}

- (void)zanButtonClick:(UIButton *)button
{
    [_zanButton setBackgroundImage:[UIImage imageNamed:@"IK_zan_blue"] forState:UIControlStateNormal];
    _zanNumberLabel.text = [NSString stringWithFormat:@"%ld",[_zanNumberLabel.text integerValue] + 1];
    button.userInteractionEnabled = NO;
}
- (UILabel *)zanNumberLabel
{
    if (_zanNumberLabel == nil) {
        _zanNumberLabel = [[UILabel alloc] init];
        //        _nameLabel.backgroundColor = [UIColor redColor];
        _zanNumberLabel.textColor = IKSubHeadTitleColor;
        _zanNumberLabel.font = [UIFont systemFontOfSize:12.0f];
        _zanNumberLabel.textAlignment = NSTextAlignmentRight;
    }
    return _zanNumberLabel;
}


- (UILabel *)psLabel1
{
    if (_psLabel1 == nil) {
        _psLabel1 = [[UILabel alloc] init];
//                _psLabel1.backgroundColor = [UIColor redColor];
        _psLabel1.textColor = IKMainTitleColor;
        _psLabel1.font = [UIFont systemFontOfSize:12.0f];
        _psLabel1.textAlignment = NSTextAlignmentLeft;
        _psLabel1.text = @"面试官";
    }
    return _psLabel1;
}


- (UILabel *)psLabel2
{
    if (_psLabel2 == nil) {
        _psLabel2 = [[UILabel alloc] init];
        //        _nameLabel.backgroundColor = [UIColor redColor];
        _psLabel2.textColor = IKMainTitleColor;
        _psLabel2.font = [UIFont systemFontOfSize:12.0f];
        _psLabel2.textAlignment = NSTextAlignmentLeft;
        _psLabel2.text = @"工作环境";
    }
    return _psLabel2;
}

- (UILabel *)psLabel3
{
    if (_psLabel3 == nil) {
        _psLabel3 = [[UILabel alloc] init];
//                _psLabel3.backgroundColor = [UIColor redColor];
        _psLabel3.textColor = IKMainTitleColor;
        _psLabel3.font = [UIFont systemFontOfSize:12.0f];
        _psLabel3.textAlignment = NSTextAlignmentLeft;
        _psLabel3.text = @"职位相符";

    }
    return _psLabel3;
}


- (UILabel *)psLabel4
{
    if (_psLabel4 == nil) {
        _psLabel4 = [[UILabel alloc] init];
        //        _nameLabel.backgroundColor = [UIColor redColor];
        _psLabel4.textColor = IKMainTitleColor;
        _psLabel4.font = [UIFont systemFontOfSize:12.0f];
        _psLabel4.textAlignment = NSTextAlignmentLeft;
        _psLabel4.text = @"薪资相符";
    }
    return _psLabel4;
}


- (UIView *)starView1
{
    if (_starView1 == nil) {
        _starView1 = [[UIView alloc] init];
//        _starView1.backgroundColor = [UIColor cyanColor];
    }
    return _starView1;
}

- (UIView *)starView2
{
    if (_starView2 == nil) {
        _starView2 = [[UIView alloc] init];
//        _starView2.backgroundColor = [UIColor cyanColor];

    }
    return _starView2;
}

- (UIView *)starView3
{
    if (_starView3 == nil) {
        _starView3 = [[UIView alloc] init];
//        _starView3.backgroundColor = [UIColor cyanColor];

    }
    return _starView3;
}

- (UIView *)starView4
{
    if (_starView4 == nil) {
        _starView4 = [[UIView alloc] init];
//        _starView4.backgroundColor = [UIColor cyanColor];

    }
    return _starView4;
}


- (UILabel *)tipsLabel1
{
    if (_tipsLabel1 == nil) {
        _tipsLabel1 = [self createTipsLabel];
    }
    return _tipsLabel1;
}


- (UILabel *)tipsLabel2
{
    if (_tipsLabel2 == nil) {
        _tipsLabel2 = [self createTipsLabel];
    }
    return _tipsLabel2;
}

- (UILabel *)tipsLabel3
{
    if (_tipsLabel3 == nil) {
        _tipsLabel3 = [self createTipsLabel];
    }
    return _tipsLabel3;
}

- (UILabel *)createTipsLabel
{
    UILabel *tips = [[UILabel alloc] init];
    //                _psLabel1.backgroundColor = [UIColor redColor];
    tips.textColor = IKGeneralBlue;
    tips.font = [UIFont systemFontOfSize:11.0f];
    tips.textAlignment = NSTextAlignmentCenter;
    tips.layer.cornerRadius = 8;
    tips.layer.borderColor = IKGeneralBlue.CGColor;
    tips.layer.borderWidth = 1;
    return tips;
}


- (IKLabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[IKLabel alloc] init];
        _contentLabel.textColor = IKSubHeadTitleColor;
        _contentLabel.font = [UIFont systemFontOfSize:12.0f];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        _contentLabel.verticalAlignment = IKVerticalAlignmentTop;
    }
    return _contentLabel;
}


- (void)addFeedbackCellData:(NSDictionary *)dict
{
    [_imageV lwb_loadImageWithUrl:[[dict objectForKey:@"userInfo"] objectForKey:@"headerImage"] placeHolderImageName:nil radius:5];
    [_nameLabel setText:[[dict objectForKey:@"userInfo"] objectForKey:@"name"]];
    
    _timeLabel.text = [self dealTime:[dict objectForKey:@"create_time"]];
    _zanNumberLabel.text = [dict objectForKey:@"like_num"];
    _zanButton.userInteractionEnabled = YES;
    
    [self addContentLabelText:[dict objectForKey:@"content"]];
    
    [self addStarToStarView:[[dict objectForKey:@"interviewer_num"] integerValue] starView:_starView1];
    [self addStarToStarView:[[dict objectForKey:@"env_num"] integerValue] starView:_starView2];
    [self addStarToStarView:[[dict objectForKey:@"conform_num"] integerValue] starView:_starView3];
    [self addStarToStarView:[[dict objectForKey:@"salary_num"] integerValue] starView:_starView4];
    
    [self addTips:[dict objectForKey:@"tag_str"]];
}


- (void)addContentLabelText:(NSString *)text
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 3.0;
    
    _contentLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:13.0f],NSParagraphStyleAttributeName:style}];
}

- (void)addTips:(NSString *)tips
{
    if (IKStringIsNotEmpty(tips)) {
        NSArray *array = [tips componentsSeparatedByString:@","];
        
         if (array.count == 2){
             [self addTipsOne:array.firstObject];
             [self addTipsTwo:array.lastObject];
        }
         else if (array.count == 3){
             [self addTipsOne:array.firstObject];
             [self addTipsTwo:array[1]];
             [self addTipsThree:array.lastObject];
         }
         else{
             [self addTipsOne:array.firstObject];
         }
        [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tipsLabel1.mas_bottom).offset(10);
            make.left.equalTo(_nameLabel.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
        }];
        
    }
    else{
        [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_psLabel3.mas_bottom).offset(10);
            make.left.equalTo(_nameLabel.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
        }];
    }
}


- (void)addTipsOne:(NSString *)tips
{
    [self.contentView addSubview:self.tipsLabel1];
    _tipsLabel1.text = tips;
    CGSize size = [NSString getSizeWithString:tips size:CGSizeMake(100, 16) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:11.0f]}];
    
    [_tipsLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_psLabel3.mas_bottom).offset(10);
        make.left.equalTo(_nameLabel.mas_left);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(size.width + 8);
    }];
}


- (void)addTipsTwo:(NSString *)tips
{
    [self.contentView addSubview:self.tipsLabel2];
    _tipsLabel2.text = tips;
    CGSize size = [NSString getSizeWithString:tips size:CGSizeMake(100, 16) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:11.0f]}];
    
    [_tipsLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tipsLabel1);
        make.left.equalTo(_tipsLabel1.mas_right).offset(10);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(size.width + 8);
    }];
}

- (void)addTipsThree:(NSString *)tips
{
    [self.contentView addSubview:self.tipsLabel3];
    _tipsLabel3.text = tips;
    CGSize size = [NSString getSizeWithString:tips size:CGSizeMake(100, 16) attribute:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:11.0f]}];
    
    [_tipsLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tipsLabel1);
        make.left.equalTo(_tipsLabel2.mas_right).offset(10);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(size.width + 8);
    }];
}

- (NSString *)dealTime:(NSString *)timeInterval
{
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    //时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    NSInteger x = [timeSp integerValue] - [timeInterval integerValue];
    NSLog(@"timeSp:%ld",x); //时间戳的值

    if (x < 60) {
        return [NSString stringWithFormat:@"%ld秒前",x];
    }
    else if (x >= 60 && x < 3600){
        return [NSString stringWithFormat:@"%ld分钟前",x/60];
    }
    else if (x >= 3600 && x < 86400){
        return [NSString stringWithFormat:@"%ld个小时前",x/3600];
    }
    else{
        return [NSString stringWithFormat:@"%ld天前",x/86400];
    }
}

- (void)addStarToStarView:(NSInteger )evaluate starView:(UIView *)starView
{
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(2 + 14 * i, 2, 14, 14)];
        if (i < evaluate) {
            [image setImage:[UIImage imageNamed:@"IK_star_solid_yellow"]];
        }
        else{
            [image setImage:[UIImage imageNamed:@"IK_star_hollow_grey"]];
        }
        [starView addSubview:image];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
