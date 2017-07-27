//
//  IKTagsView.m
//  IamKing
//
//  Created by Luris on 2017/7/20.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTagsView.h"

#define IKDefaultHeight   (30.0f)
#define IKDefaultFontSize   (13.0f)
#define IKDefaultLineSpacing   (5.0f)
#define IKDefaultVerticalSpacing   (5.0f)


@interface IKTagsView ()

@property(nonatomic,strong)NSArray  *frameArray;
@property(nonatomic,assign)BOOL  isHideTitle;
@property(nonatomic,strong)UILabel  *titleLabel;


@end



@implementation IKTagsView

- (instancetype)init
{
    if (self = [super init]) {
        _isHideTitle = YES;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _isHideTitle = YES;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _isHideTitle = YES;
        self.userInteractionEnabled = YES;

    }
    
    return self;
}

- (void)setTitleView:(UIView *)titleView
{
    if (titleView) {
        titleView.frame = CGRectMake(10, 8, CGRectGetWidth(self.bounds), IKDefaultHeight - 8);
        [self addSubview:titleView];
        if (self.titleLabel) {
            [self.titleLabel removeFromSuperview];
            self.titleLabel = nil;
        }
        _isHideTitle = NO;
    }
}

- (void)setTitle:(NSString *)title
{
    if (title && title.length != 0) {
        [self addSubview:self.titleLabel];
        [self.titleLabel setText:title];
        _title = title;
    }
}


- (void)setTitleAlignment:(NSTextAlignment)titleAlignment
{
    _titleAlignment = titleAlignment;
    
    if (self.titleLabel) {
        self.titleLabel.textAlignment = titleAlignment;
    }
}


- (void)setTitleFont:(CGFloat)titleFont
{
    _titleFont = titleFont;
    
    if (self.titleLabel) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:titleFont]];
    }
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    if (self.titleLabel) {
        [self.titleLabel setTextColor:titleColor];
    }
}



- (void)setData:(NSArray *)data
{
    _data = data;
}

-(void)setTagHeight:(CGFloat)tagHeight
{
    if (!tagHeight) {
        _tagHeight = IKDefaultHeight;
    }
    else{
        _tagHeight = tagHeight;
    }
}

- (NSArray *)frameArray
{
    if (_frameArray == nil) {
        _frameArray = [[NSArray alloc] init];
    }
    
    return _frameArray;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil && _titleView == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, CGRectGetWidth(self.bounds), IKDefaultHeight - 15)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        [_titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        _titleLabel.userInteractionEnabled = YES;
        _isHideTitle = NO;
    }
    
    return _titleLabel;
}
- (CGFloat)tagFont
{
    if (_tagFont <= 0) {
        _tagFont = IKDefaultFontSize;
    }
    return _tagFont;
}


- (void)setLineSpacing:(CGFloat)lineSpacing
{
    if (!lineSpacing) {
        _lineSpacing = IKDefaultLineSpacing;
    }
    else{
        _lineSpacing = lineSpacing;
    }
}



- (void)setVerticalSpacing:(CGFloat)verticalSpacing
{
    if (verticalSpacing <= 0) {
        _verticalSpacing = IKDefaultVerticalSpacing;
    }
    else{
        _verticalSpacing = verticalSpacing;
    }
}

- (void)setTagBgColor:(UIColor *)tagBgColor
{
    _tagBgColor = tagBgColor;
}


- (UIColor *)tagTitleColor
{
    if (!_tagTitleColor) {
        _tagTitleColor = [UIColor blackColor];
    }
    
    return _tagTitleColor;
}


- (void)setTagBorderColor:(UIColor *)tagBorderColor
{
    _tagBorderColor = tagBorderColor;
}


- (void)setTagCornerRadius:(CGFloat)tagCornerRadius
{
    _tagCornerRadius = tagCornerRadius;
}

- (void)setTagBorderWidth:(CGFloat)tagBorderWidth
{
    _tagBorderWidth = tagBorderWidth;
}

- (void)setDelegate:(id<IKTagsViewDelegate>)delegate
{
    if (delegate) {
        _delegate = delegate;
    }
}


- (void)createViewAdjustViewFrame:(nullable AdjustFrame )newFrame
{
    NSInteger tag = 1000;
    
    // 最大宽度
    CGFloat maxWidth = CGRectGetWidth(self.bounds);
    NSLog(@"maxWidth = %.0f",maxWidth);
    CGFloat totalWidth = 5;
    CGFloat totalHeight = (_isHideTitle? 0:IKDefaultHeight - 12); // 标题高度
    CGFloat contentHeight = 0 ;
    
    
    for (int i = 0; i < self.data.count; i ++) {
        NSString *str = [self.data objectAtIndex:i];
        
        NSLog(@"str = %@",str);
        CGFloat width = [self widthForString:str];
        
        NSLog(@"width = %.0f",width);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.backgroundColor = [UIColor redColor];
        button.tag = tag + i;
        [button setTitle:str forState:UIControlStateNormal];
        [button setTitleColor:self.tagTitleColor forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:self.tagFont]];
        button.layer.cornerRadius = self.tagCornerRadius;
        button.layer.borderColor = self.tagBorderColor.CGColor;
        button.layer.borderWidth = self.tagBorderWidth;
        button.layer.masksToBounds = YES;
        [button setBackgroundImage:IKButtonClickBgImage forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if ((totalWidth + self.lineSpacing*2 + width) > maxWidth) {
            totalWidth = 5;
            totalHeight += self.tagHeight + self.verticalSpacing;
            
        }
    
        button.frame = CGRectMake(self.lineSpacing + totalWidth, self.verticalSpacing + totalHeight, width, self.tagHeight);

        totalWidth = button.frame.origin.x + width;
        contentHeight = button.frame.origin.y + self.tagHeight;
        
        [self addSubview:button];
    }
    
    if (newFrame) {
        newFrame(CGRectMake(0, 0, maxWidth, contentHeight + self.verticalSpacing));
    }
}



- (CGFloat)widthForString:(NSString *)text
{
    
    // 根据文字计算尺寸.
    CGRect frame = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.bounds) - (self.lineSpacing * 2), self.tagHeight) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.tagFont]} context:nil];
    
    // item 默认的最小宽度为 80;
    NSLog(@"frame.size.width = %.0f",frame.size.width);
    CGFloat width = frame.size.width + 20;
    if (width < 60) {
        return 60;
    }
    
    // 超过最大宽度显示为最大宽度
    CGFloat maxWidth = CGRectGetWidth(self.bounds) - (self.lineSpacing * 2);
    if (width > maxWidth){
        width = maxWidth;
    }
    
    return width;
}



- (void)buttonClick:(UIButton *)button
{
    NSLog(@"buttonClick tag = %ld",button.tag - 1000);
    if ([self.delegate respondsToSelector:@selector(tagViewDidSelectedTagWithTitle: selectedIndex:)]) {
        [self.delegate tagViewDidSelectedTagWithTitle:button.titleLabel.text selectedIndex:button.tag - 1000];
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
