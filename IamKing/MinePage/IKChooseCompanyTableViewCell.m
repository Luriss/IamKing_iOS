//
//  IKChooseCompanyTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/23.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKChooseCompanyTableViewCell.h"


@interface IKChooseCompanyTableViewCell ()<UITextFieldDelegate>

@property (nonatomic, strong)UIView *lineView;


@end
@implementation IKChooseCompanyTableViewCell

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
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.lineView];
    
    
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
