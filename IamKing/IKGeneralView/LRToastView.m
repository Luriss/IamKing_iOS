//
//  LRToastView.m
//  IamKing
//
//  Created by Luris on 2017/8/9.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "LRToastView.h"

#define HadAddToastViewKey (@"hadAddToastViewKey")


@implementation LRToastStyle

- (instancetype)init {
    self = [super init];
    if (self) {
        _backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        _textFont = [UIFont systemFontOfSize:14.0f];
        _textColor = [UIColor whiteColor];
        _maxWidth = IKSCREEN_WIDTH * 0.5;
        _duration = 1.0;
        _verticalAlignment = LRToastVerticalAlignmentMiddle;
    }
    return self;
}

@end


@interface LRToastView ()

@property (nonatomic, strong) LRToastStyle *style;
@property (nonatomic, strong) UILabel *infoLabel;

@end


@implementation LRToastView


+ (void)showTosatWithText:(NSString *)text inView:(UIView *)showView
{
    if (![[self class] hadAddView]) {
        LRToastStyle *style = [[LRToastStyle alloc] init];
        style.text = text;
        
        LRToastView *toastView = [[LRToastView alloc] initWithStyle:style];
        [showView addSubview:toastView];
        [showView bringSubviewToFront:toastView];
        
        [[self class] countDown:style.duration dimissView:toastView];
    }
}


+ (void)showTosatWithText:(NSString *)text
                   inView:(UIView *)showView
        dismissAfterDelay:(NSTimeInterval )duration
{
     if (![[self class] hadAddView]){
         LRToastStyle *style = [[LRToastStyle alloc] init];
         style.text = text;
         style.duration = duration;
         
         LRToastView *toastView = [[LRToastView alloc] initWithStyle:style];
         [showView addSubview:toastView];
         [showView bringSubviewToFront:toastView];
         
         [[self class] countDown:duration dimissView:toastView];
     }
}

+ (void)showTosatWithStyle:(LRToastStyle *)style inView:(UIView *)showView
{
    if (![[self class] hadAddView]){
        LRToastView *toastView = [[LRToastView alloc] initWithStyle:style];
        
        [showView addSubview:toastView];
        [showView bringSubviewToFront:toastView];
        
        [[self class] countDown:style.duration dimissView:toastView];
    }
}


+ (void)countDown:(NSTimeInterval )duration dimissView:(LRToastView *)view
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view dismissToast];
    });
    
}


+ (BOOL )hadAddView
{
    NSString *hadAdd = [[NSUserDefaults standardUserDefaults] objectForKey:HadAddToastViewKey];
    if ([hadAdd isEqualToString:@"1"]) {
        return NO;
    }
    
    return NO;
}


- (instancetype)initWithStyle:(LRToastStyle *)style {
    self = [super init];
    if (self) {
        self.style = style;
        
        self.backgroundColor = _style.backgroundColor;
        self.layer.cornerRadius = 6.0;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.infoLabel];

        self.infoLabel.text = _style.text;
        self.infoLabel.textColor = _style.textColor;
        self.infoLabel.font = _style.textFont;
        CGSize labelSize = [self getSizeWithString:_style.text attribute:@{NSFontAttributeName:_style.textFont}];
        
        CGFloat y = [self getLabelY];
        CGFloat x = (ceilf(IKSCREEN_WIDTH)-labelSize.width)*0.5;
        
        self.frame = CGRectMake(x, y, labelSize.width + 20, labelSize.height);
        self.infoLabel.frame = self.bounds;

        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:HadAddToastViewKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return self;
}


- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.numberOfLines = 0;
        _infoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _infoLabel;
}


- (CGFloat )getLabelY
{
    CGFloat y = 0;
    switch (_style.verticalAlignment) {
        case LRToastVerticalAlignmentTop:
            y = 5;
            break;
            
        case LRToastVerticalAlignmentMiddle:
            y = IKSCREENH_HEIGHT * 0.4;

            break;
            
        case LRToastVerticalAlignmentBottom:
            y = IKSCREENH_HEIGHT * 0.75;

            break;
        default:
            break;
    }
    
    return y;
}


- (CGSize )getSizeWithString:(NSString *)string attribute:(NSDictionary *)attribute
{
    // 高度一定,计算文字长度
    
    NSLog(@"string = %@",string);
    CGSize  strSzie = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 40)  options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine)  attributes:attribute context:nil].size;
    
    // 最大长度计算高度
    
    CGSize hSzie;
    if (strSzie.width > self.style.maxWidth) {
        hSzie = [string boundingRectWithSize:CGSizeMake(self.style.maxWidth, MAXFLOAT)  options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine)  attributes:attribute context:nil].size;
    }
    else{
        hSzie = strSzie;
    }
    
    CGSize reSzie = CGSizeMake(ceilf(hSzie.width) + 16 , ceilf(hSzie.height)+16);
    return reSzie;
}


- (void)dismissToast
{
    
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:HadAddToastViewKey];
                         [[NSUserDefaults standardUserDefaults] synchronize];
                     }];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
