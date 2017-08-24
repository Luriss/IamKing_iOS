//
//  IKBaseInfoTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/16.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKBaseInfoTableViewCell.h"

@interface IKBaseInfoTableViewCell ()<UITextFieldDelegate>

@property (nonatomic, strong)UIView *lineView;


@end
@implementation IKBaseInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initSubViews];
        [IKNotificationCenter addObserver:self selector:@selector(hideKeybroad) name:@"IKBaseInfoCellNeedHideKeyborad" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [IKNotificationCenter removeObserver:self name:@"IKBaseInfoCellNeedHideKeyborad" object:nil];
}

- (void)initSubViews
{
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.textField];
    
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(120);
    }];

    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(_label.mas_right).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
}



- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont boldSystemFontOfSize:14.0f];
        _label.textColor = IKSubHeadTitleColor;
//        _label.text = @"健身行业从业时间";
        _label.textAlignment = NSTextAlignmentLeft;
//        _label.backgroundColor = [UIColor redColor];
    }
    return _label;
}


- (IKTextField *)textField
{
    if (_textField == nil) {
        _textField = [[IKTextField alloc] init];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
        _textField.textColor = IKGeneralBlue;
        _textField.userInteractionEnabled = NO;
    }
    return _textField;
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

- (void)hideKeybroad
{
    if (self.textField.isFirstResponder) {
        [self.textField resignFirstResponder];
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    //获取button在contentView的位置
    CGRect rect1 = [textField convertRect:textField.frame fromView:self.contentView];
    CGRect rect2 = [textField convertRect:rect1 toView:window];

    BOOL isNeed = NO;
    
    if (rect2.origin.y > (IKSCREENH_HEIGHT*0.5)) {
        isNeed = YES;
    }
    
    if ([self.delegate respondsToSelector:@selector(textFieldBeginEditingNeedAjustkeyBorad:)]) {
        [self.delegate textFieldBeginEditingNeedAjustkeyBorad:isNeed];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(textFieldEndEditingWithText:)]) {
        [self.delegate textFieldEndEditingWithText:textField.text];
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
