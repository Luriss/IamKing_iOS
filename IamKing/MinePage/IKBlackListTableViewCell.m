//
//  IKBlackListTableViewCell.m
//  IamKing
//
//  Created by Luris on 2017/8/14.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKBlackListTableViewCell.h"

@interface IKBlackListTableViewCell ()

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIImageView *logoImage;
@property (nonatomic, strong)UIButton *deleteBtn;
@property (nonatomic, strong)UIView *lineView;


@end
@implementation IKBlackListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [IKNotificationCenter addObserver:self selector:@selector(hideDeleteButton) name:@"IKEditingHideDeleteButton" object:nil];
        [IKNotificationCenter addObserver:self selector:@selector(showDeleteButton) name:@"IKEditingShowDeleteButton" object:nil];

        [self initSubViews];
    }
    return self;
}

//- (void)layoutSubviews
//{
////    [self repalceSelectedImage];
//    [super layoutSubviews];
//}

- (void)initSubViews
{
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.logoImage];
    [self.contentView addSubview:self.deleteBtn];
    
    
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.and.height.mas_equalTo(40);
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25);
    }];
    
    
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(_logoImage.mas_right).offset(15);
        make.right.equalTo(_deleteBtn.mas_left).offset(-5);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
}


- (void)hideDeleteButton
{
    self.deleteBtn.hidden = YES;
}

- (void)showDeleteButton
{
    self.deleteBtn.hidden = NO;
}


- (void)repalceSelectedImage
{
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"IK_tableView_selected"];
                    }
                    else{
                        img.image=[UIImage imageNamed:@"IK_tableView_unselected"];
                    }
                    break ;
                }
            }
        }
    }
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:15.0f];
        _label.textColor = IKMainTitleColor;
        _label.textAlignment = NSTextAlignmentLeft;
        _label.text = @"威尔士健身";
    }
    return _label;
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

- (UIImageView *)logoImage
{
    if (_logoImage == nil) {
        _logoImage = [[UIImageView alloc] init];
        _logoImage.layer.cornerRadius = 6;
        _logoImage.layer.borderWidth = 1.0f;
        _logoImage.layer.borderColor = IKLineColor.CGColor;
        _logoImage.backgroundColor = IKGeneralLightGray;
        _logoImage.layer.masksToBounds = YES;
    }
    return _logoImage;
}


- (UIButton *)deleteBtn
{
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];

//        _deleteBtn.frame = CGRectMake(40, 270, IKSCREEN_WIDTH - 80, 40);
        [_deleteBtn setTitle:@"移除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:IKButtonClickColor forState:UIControlStateHighlighted];
        _deleteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _deleteBtn.layer.cornerRadius = 6;
        _deleteBtn.layer.masksToBounds = YES;
        _deleteBtn.layer.borderColor = IKGeneralBlue.CGColor;
        _deleteBtn.layer.borderWidth = 1.0f;
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}


- (void)deleteBtnClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(deleteButtonClickWithCell:)]) {
        [self.delegate deleteButtonClickWithCell:self];
    }
}




- (void)blackListCellAddData:(IKBlackListModel *)model
{
    [_logoImage lwb_loadImageWithUrl:model.headerImageUrl placeHolderImageName:nil radius:0];
    
    _label.text = model.nickName;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
