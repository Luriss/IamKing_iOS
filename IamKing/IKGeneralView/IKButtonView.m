//
//  IKButtonView.m
//  IamKing
//
//  Created by Luris on 2017/7/9.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKButtonView.h"

@interface IKButtonView ()

@property (nonatomic, strong)UILabel *label;

@end
@implementation IKButtonView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initButton];
        [self initLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initButton];
        [self initLabel];
    }
    
    return self;
}


- (void)initButton
{
//    self.backgroundColor = [UIColor clearColor];

    UIButton *exchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    exchangeBtn.backgroundColor = [UIColor clearColor];
    exchangeBtn.layer.borderWidth = 1;
    exchangeBtn.layer.borderColor = [UIColor clearColor].CGColor;
    exchangeBtn.layer.cornerRadius = 20;
    
    //按钮按下为松开时调用.
    [exchangeBtn addTarget:self action:@selector(exchangBtnTouchDown:) forControlEvents:UIControlEventTouchDown];
    
    [exchangeBtn addTarget:self action:@selector(exchangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:exchangeBtn];
    
    [exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.and.width.and.height.equalTo(self);
    }];
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = IKRGBColor(93.0, 93.0, 93.0).CGColor;
    self.layer.cornerRadius = 20;
}

- (void)initLabel
{
    UILabel *label = [[UILabel alloc] init];
//    label.text = @"换一换";
    label.textColor = IKRGBColor(94.0, 94.0, 94.0);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.and.width.and.height.equalTo(self);
    }];
    
    self.label = label;
}


- (void)setTitle:(NSString *)title
{
    if (!IKStringIsEmpty(title)) {
        self.label.text = title;
    }
}

- (void)setDelegate:(id<IKButtonVieDelegate>)delegate
{
    _delegate = delegate;
}


- (void)exchangBtnTouchDown:(UIButton *)btn
{
    btn.layer.borderColor = IKRGBColor(47.0, 181.0, 255.0).CGColor;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.label.textColor = IKRGBColor(47.0, 181.0, 255.0);
    
    // X 收缩0.1
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        btn.layer.transform = CATransform3DMakeScale(0.9, 1, 1);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)exchangBtnClick:(UIButton *)btn
{
    // 按钮点击动画,恢复正常
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            btn.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            btn.layer.borderColor = IKRGBColor(93.0, 93.0, 93.0).CGColor;
            self.label.textColor = IKRGBColor(93.0, 93.0, 93.0);
        }];
    });
    
    if ([self.delegate respondsToSelector:@selector(buttonViewButtonClick:)]) {
        [self.delegate buttonViewButtonClick:btn];
    }

}









/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
