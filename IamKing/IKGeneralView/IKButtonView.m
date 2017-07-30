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
@property (nonatomic, strong)UIButton *exchangeBtn;
@property (nonatomic, strong)UIImageView *imageV;

@end
@implementation IKButtonView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.exchangeBtn];
        [self addSubview:self.label];
        [self addSubview:self.imageV];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {

        [self addSubview:self.exchangeBtn];
        [self addSubview:self.label];
        [self addSubview:self.imageV];
    }
    
    return self;
}


- (UIButton *)exchangeBtn
{
    if (_exchangeBtn == nil) {
        _exchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _exchangeBtn.backgroundColor = [UIColor clearColor];
        //按钮按下为松开时调用.
        [_exchangeBtn addTarget:self action:@selector(exchangBtnTouchDown:) forControlEvents:UIControlEventTouchDown];
        
        [_exchangeBtn addTarget:self action:@selector(exchangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangeBtn;
}


- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.textColor = IKRGBColor(94.0, 94.0, 94.0);
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentLeft;
    }
    return _label;
}

- (UIImageView *)imageV
{
    if (_imageV == nil) {
        _imageV = [[UIImageView alloc] init];
        _imageV.image = [UIImage imageNamed:@"IK_xuanzhuan"];
    }
    return _imageV;
}

- (void)layoutSubviews
{
    __weak typeof (self) weakSelf = self;
    [_exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.and.width.and.height.equalTo(weakSelf);
    }];
    
    
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(80);
        make.width.and.height.mas_equalTo(18);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.and.bottom.equalTo(weakSelf);
        make.left.equalTo(_imageV.mas_right).offset(2);
    }];
    
    [super layoutSubviews];
}


- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _exchangeBtn.layer.cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    if (!borderWidth || borderWidth < 0) {
        borderWidth = 1;
    }
    _exchangeBtn.layer.borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;

}


- (void)setBorderColor:(UIColor *)borderColor
{
    if (borderColor) {
        _borderColor = borderColor;
    }
    else{
        _borderColor = IKRGBColor(93.0, 93.0, 93.0);
    }
    self.layer.borderColor = borderColor.CGColor;

}

- (void)setHighBorderColor:(UIColor *)HighBorderColor
{
    if (HighBorderColor) {
        _HighBorderColor = HighBorderColor;
    }
    else{
        _HighBorderColor = IKRGBColor(47.0, 181.0, 255.0);
    }
}

- (void)setNeedAnimation:(BOOL)needAnimation
{
    _needAnimation = needAnimation;
}

- (void)setTitle:(NSString *)title
{
    if (!IKStringIsEmpty(title)) {
        self.label.text = title;
    }
}

- (void)setDelegate:(id<IKButtonViewDelegate>)delegate
{
    _delegate = delegate;
}


- (void)exchangBtnTouchDown:(UIButton *)btn
{
    // X 收缩0.1
    if (_needAnimation) {
        
        btn.layer.borderColor = _HighBorderColor.CGColor;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.label.textColor = _HighBorderColor;
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            btn.layer.transform = CATransform3DMakeScale(0.9, 1, 1);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)exchangBtnClick:(UIButton *)btn
{
    if (_needAnimation) {
        // 按钮点击动画,恢复正常
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                btn.layer.transform = CATransform3DIdentity;
            } completion:^(BOOL finished) {
                btn.layer.borderColor = _borderColor.CGColor;
                self.label.textColor = _borderColor;
            }];
        });
    }
    
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
