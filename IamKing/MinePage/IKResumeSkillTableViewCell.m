//
//  IKResumeSkillTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/17.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKResumeSkillTableViewCell.h"


@interface IKResumeSkillTableViewCell ()<UITextFieldDelegate>

@property (nonatomic, strong)UIView *lineView;
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
    
//    [_];
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
//        _logoImageView.backgroundColor = IKGeneralLightGray;
//        _logoImageView.layer.cornerRadius = 6;
    }
    return _logoImageView;
}


//- (UILabel *)label
//{
//    if (_label == nil) {
//        _label = [[UILabel alloc] init];
//        _label.font = [UIFont boldSystemFontOfSize:14.0f];
//        _label.textColor = IKSubHeadTitleColor;
//        //        _label.text = @"健身行业从业时间";
//        _label.textAlignment = NSTextAlignmentLeft;
//        //        _label.backgroundColor = [UIColor redColor];
//    }
//    return _label;
//}


- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = IKLineColor;
        _lineView.hidden = NO;
    }
    return _lineView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
