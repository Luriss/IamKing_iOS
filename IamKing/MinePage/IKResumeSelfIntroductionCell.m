//
//  IKResumeSelfIntroductionCell.m
//  IamKing
//
//  Created by Luris on 2017/8/17.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKResumeSelfIntroductionCell.h"


@interface IKResumeSelfIntroductionCell ()<UITextViewDelegate>

@property (nonatomic, strong)UITextView *textView;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UILabel *number;
@property (nonatomic, strong)NSDictionary *attributes;


@end
@implementation IKResumeSelfIntroductionCell

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
    [self.contentView addSubview:self.textView];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(50);
    }];
    
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label.mas_bottom);
        make.left.equalTo(_label.mas_left);
        make.right.equalTo(_label.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView.mas_top).offset(115);
//        make.right.equalTo(_textView.mas_right).offset(-10);
        make.left.equalTo(_textView.mas_left).offset(IKSCREEN_WIDTH - 110);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(60);
    }];
    
}



- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont boldSystemFontOfSize:14.0f];
        _label.textColor = IKSubHeadTitleColor;
        _label.text = @"自我介绍";
        _label.textAlignment = NSTextAlignmentLeft;
    }
    return _label;
}


- (UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = IKGeneralLightGray;
        _textView.layer.cornerRadius = 6;
        _textView.textColor = IKSubHeadTitleColor;
        _textView.delegate = self;
        _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 10);
        _textView.contentInset = UIEdgeInsetsMake(0, 0, 25, 0);
        _textView.font = [UIFont systemFontOfSize:13.0f];

        // _placeholderLabel
        //        UILabel *placeHolderLabel = [[UILabel alloc] init];
        //        placeHolderLabel.text = @"说点什么...";
        //        placeHolderLabel.numberOfLines = 0;
        //        placeHolderLabel.textColor = [UIColor lightGrayColor];
        //        [placeHolderLabel sizeToFit];
        //        [textView addSubview:placeHolderLabel];
        // same font
        //        placeHolderLabel.font = [UIFont systemFontOfSize:13.f];
        //        [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
        //
    
        [_textView addSubview:self.number];
    }
    return _textView;
}

- (UILabel *)number
{
    if (_number == nil) {
        _number = [[UILabel alloc] init];
        _number.text = @"0/60";
        _number.textColor = IKSubHeadTitleColor;
        _number.font = [UIFont systemFontOfSize:12.0f];
        _number.textAlignment = NSTextAlignmentRight;
//        _number.backgroundColor = [UIColor redColor];
    }
    return _number;
}


- (void)setTextViewText:(NSString *)textViewText
{
    if (IKStringIsNotEmpty(textViewText)) {
        
        self.textView.attributedText = [[NSAttributedString alloc] initWithString:textViewText attributes:self.attributes];
        self.number.text = [NSString stringWithFormat:@"%ld/60",textViewText.length];
    }
}

- (NSDictionary *)attributes
{
    if (_attributes == nil) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;// 字体的行间距
        _attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f],NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:IKSubHeadTitleColor};
    }
    return _attributes;
}

- (void)hideKeybroad
{
    if (self.textView.isFirstResponder) {
        [self.textView resignFirstResponder];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    //获取button在contentView的位置
    CGRect rect1 = [textView convertRect:textView.frame fromView:self.contentView];
    CGRect rect2 = [textView convertRect:rect1 toView:window];
    
    BOOL isNeed = NO;
    
    if (rect2.origin.y > (IKSCREENH_HEIGHT*0.5)) {
        isNeed = YES;
    }
    
    if ([self.delegate respondsToSelector:@selector(textViewBeginEditingNeedAjustkeyBorad:)]) {
        [self.delegate textViewBeginEditingNeedAjustkeyBorad:isNeed];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger length = textView.text.length;
    if (length > 100) {
        textView.text = [textView.text substringToIndex:60];
        self.number.text = @"60/60";
    }
    else{
        self.number.text = [NSString stringWithFormat:@"%ld/60",length];
    }
    
    //    textview 改变字体的行间距
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:self.attributes];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"text = %@",text);
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

- (void)setTitle:(NSString *)title
{
    if (IKStringIsNotEmpty(title)) {
        self.label.text = title;
    }
}


- (void)setTextViewTextColor:(UIColor *)textViewTextColor
{
    self.textView.textColor = textViewTextColor;
    _textViewTextColor = textViewTextColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
