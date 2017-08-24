//
//  IKChooseCompanyTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/23.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKChooseCompanyTableViewCell.h"
#import "IKButton.h"

@interface IKChooseCompanyTableViewCell ()<UITextFieldDelegate>

@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)IKButton *arrowBtn;


@end
@implementation IKChooseCompanyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initSubViews];
        [IKNotificationCenter addObserver:self selector:@selector(chooseCompanyhideKeybroad) name:@"IKBaseInfoCellNeedHideKeyborad" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [IKNotificationCenter removeObserver:self name:@"IKBaseInfoCellNeedHideKeyborad" object:nil];
}


- (void)initSubViews
{
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.arrowBtn];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView).offset(60);
    }];
    
    [_arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-25);
        make.width.and.height.mas_equalTo(20);
    }];
    
    
}



- (IKTextField *)textField
{
    if (_textField == nil) {
        _textField = [[IKTextField alloc] init];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
        _textField.textColor = IKMainTitleColor;
        _textField.font = [UIFont boldSystemFontOfSize:14.0f];
        _textField.placeholder = @"公司或品牌名称";
        [_textField setValue:IKSubHeadTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        [_textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _textField;
}

- (IKButton *)arrowBtn
{
    if (_arrowBtn == nil) {
        _arrowBtn = [IKButton buttonWithType:UIButtonTypeCustom];
        [_arrowBtn addTarget:self action:@selector(arrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_arrowBtn setImage:[UIImage imageNamed:@"IK_xiala"] forState:UIControlStateNormal];
        [_arrowBtn setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_xiala"] forState:UIControlStateHighlighted];
    }
    return _arrowBtn;
}


- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = IKLineColor;
        _lineView.hidden = NO;
    }
    return _lineView;
}


- (void)chooseCompanyhideKeybroad
{
    if (self.textField.isFirstResponder) {
        [self.textField resignFirstResponder];
    }
}


- (void)arrowBtnClick:(IKButton *)button
{
    [self chooseCompanyhideKeybroad];
    
    
    if (button.isClick) {
        button.isClick = NO;
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            button.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        button.isClick = YES;
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            button.transform = CGAffineTransformMakeRotation(M_PI);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if ([self.delegate respondsToSelector:@selector(showCompanyListView:)]) {
        [self.delegate showCompanyListView:button.isClick];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(textFieldBeginEditing)]) {
        [self.delegate textFieldBeginEditing];
    }
    
    return YES;
}

- (void)textFieldEditingChanged:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(textFieldEditingChangedWithText:)]) {
        [self.delegate textFieldEditingChangedWithText:textField.text];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(companyTextFieldEndEditingWithText:)]) {
        [self.delegate companyTextFieldEndEditingWithText:textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
