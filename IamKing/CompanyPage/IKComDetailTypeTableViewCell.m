//
//  IKComDetailTypeTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/7/31.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKComDetailTypeTableViewCell.h"

@interface IKComDetailTypeTableViewCell ()

@property (nonatomic, strong) UIButton  *button1;
@property (nonatomic, strong) UIButton  *button2;
@property (nonatomic, strong) UIButton  *button3;
@property (nonatomic, strong) UIButton  *button4;
@property (nonatomic, strong) UIView    *lineView;
@property (nonatomic, strong) UIView    *bottomView;
@property (nonatomic, strong) UIButton  *oldButton;

@end


@implementation IKComDetailTypeTableViewCell

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
    [self.contentView addSubview:self.bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.width.and.height.equalTo(self.contentView);
    }];
    
    
    [_bottomView addSubview:self.button1];
    [_bottomView addSubview:self.button2];
    [_bottomView addSubview:self.button3];
    [_bottomView addSubview:self.button4];
    [_bottomView addSubview:self.lineView];

    self.oldButton = _button1;
    [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_bottomView);
        make.left.equalTo(_bottomView.mas_left);
        make.width.equalTo(_bottomView).multipliedBy(0.25);
    }];
    
    [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_bottomView);
        make.left.equalTo(_button1.mas_right);
        make.width.equalTo(_bottomView).multipliedBy(0.25);
    }];
    
    [_button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_bottomView);
        make.left.equalTo(_button2.mas_right);
        make.width.equalTo(_bottomView).multipliedBy(0.25);
    }];
    
    [_button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(_bottomView);
        make.left.equalTo(_button3.mas_right);
        make.width.equalTo(_bottomView).multipliedBy(0.25);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bottomView).offset(-5);
        make.centerX.equalTo(_button1.mas_centerX);
        make.height.mas_equalTo(5);
        make.width.mas_equalTo(66);
    }];
}

- (UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}


- (UIButton *)button1
{
    if (_button1 == nil) {
        _button1 = [self createButton];
        _button1.tag = 1001;
        [_button1 setTitle:@"关于我们" forState:UIControlStateNormal];
    }
    return _button1;
}

- (UIButton *)button2
{
    if (_button2 == nil) {
        _button2 = [self createButton];
        _button2.tag = 1002;
        [_button2 setTitle:@"管理团队" forState:UIControlStateNormal];
    }
    return _button2;
}

- (UIButton *)button3
{
    if (_button3 == nil) {
        _button3 = [self createButton];
        _button3.tag = 1003;
        [_button3 setTitle:@"连锁门店" forState:UIControlStateNormal];
    }
    return _button3;
}

- (UIButton *)button4
{
    if (_button4 == nil) {
        _button4 = [self createButton];
        _button4.tag = 1004;
        [_button4 setTitle:@"在招职位" forState:UIControlStateNormal];
    }
    return _button4;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = IKGeneralBlue;
        _lineView.layer.cornerRadius = 2.5;
    }
    return _lineView;
}


- (UIButton *)createButton
{
    UIButton *type = [UIButton buttonWithType:UIButtonTypeCustom];
    [type setTitleColor:IKMainTitleColor forState:UIControlStateNormal];
    type.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    type.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [type addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    type.backgroundColor = [UIColor clearColor];
    
    return type;
}


- (void)btnClick:(UIButton *)button
{
    if (_oldButton != button) {
        
        [self startBottomLineAnimation:button.center];
        
        [button setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
        [_oldButton setTitleColor:IKMainTitleColor forState:UIControlStateNormal];
        
        if ([self.delegate respondsToSelector:@selector(typeButtonClick:)]) {
            [self.delegate typeButtonClick:button];
        }
        _oldButton = button;
    }

}

- (void)startBottomLineAnimation:(CGPoint )point
{
//    NSLog(@"xxxx = %@msdadd = %@",[NSValue valueWithCGPoint:_oldButton.center],[NSValue valueWithCGPoint:point]);
//    CABasicAnimation* position = [CABasicAnimation animation];
//    position.duration = 0.1;
//    position.keyPath = @"position.x";
//    position.fromValue = [NSValue valueWithCGPoint:_oldButton.center];
//    position.toValue = [NSValue valueWithCGPoint:point];
//    position.removedOnCompletion = NO;
//    position.fillMode = kCAFillModeForwards;
//    [_lineView.layer addAnimation:position forKey:@"key"];

    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _lineView.center = CGPointMake(point.x, _lineView.center.y);
    } completion:^(BOOL finished) {
        
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
