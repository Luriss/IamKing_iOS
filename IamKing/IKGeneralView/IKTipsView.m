//
//  IKTipsView.m
//  IamKing
//
//  Created by Luris on 2017/7/27.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTipsView.h"
#define Length 8
#define Length2 15


@interface IKTipsView ()

@property (nonatomic, assign)IKTipsArrowDirection arrowDirection;

@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic,strong) UILabel *contentLabel;


@end


@implementation IKTipsView


- (instancetype)initWithFrame:(CGRect)frame arrowDirection:(IKTipsArrowDirection)direction bgColor:(UIColor *)bgColor
{
    self = [super initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, IKSCREENH_HEIGHT)];
    if (self) {
        // 自定义你需要的属性
        self.backgroundColor = [UIColor clearColor];
        self.arrowDirection = direction;
        self.origin = frame.origin;
        self.width = frame.size.width;
        self.height = frame.size.height;
        self.contentLabel = [[UILabel alloc] initWithFrame:frame];
        self.contentLabel.backgroundColor = [bgColor colorWithAlphaComponent:0.98f];
        self.contentLabel.layer.cornerRadius = 6;
        self.contentLabel.layer.masksToBounds = YES;
        self.contentLabel.textColor = [UIColor whiteColor];
        self.contentLabel.font = [UIFont systemFontOfSize:12.0f];
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        self.contentLabel.numberOfLines = 0;
        [self addSubview:self.contentLabel];
    }
    return self;
}

- (void)setTipsContent:(NSString *)tipsContent
{
    if (IKStringIsNotEmpty(tipsContent)) {
        self.contentLabel.text = tipsContent;
    }
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (self.arrowDirection) {
        case IKTipsArrowDirectionUpLeft:
        case IKTipsArrowDirectionUpCenter:
        case IKTipsArrowDirectionUpRight:{
            {
                CGFloat startX = self.origin.x;
                CGFloat startY = self.origin.y;
                CGContextMoveToPoint(context, startX, startY);
                CGContextAddLineToPoint(context, startX + Length, startY + Length);
                CGContextAddLineToPoint(context, startX - Length, startY + Length);
            }
            break;
        }
        case IKTipsArrowDirectionDownLeft:
        case IKTipsArrowDirectionDownCenter:
        case IKTipsArrowDirectionDownRight: {
            {
                CGFloat startX = self.origin.x;
                CGFloat startY = self.origin.y;
                CGContextMoveToPoint(context, startX, startY);
                CGContextAddLineToPoint(context, startX - Length, startY - Length);
                CGContextAddLineToPoint(context, startX + Length, startY - Length);
            }
            break;
        }
    }
    
    CGContextClosePath(context);
    [self.contentLabel.backgroundColor setFill];
    [self.backgroundColor setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
    
}


#pragma mark - popView
- (void)popView
{
    UIWindow *windowView = [UIApplication sharedApplication].keyWindow;
    [windowView addSubview:self];
    
    switch (self.arrowDirection) {
        case IKTipsArrowDirectionUpLeft: {
            {
                self.contentLabel.frame = CGRectMake(self.origin.x, self.origin.y + Length, 0, 0);
                CGFloat origin_x = self.origin.x - Length2;
                CGFloat origin_y = self.origin.y + Length;
                CGFloat size_width = self.width;
                CGFloat size_height = self.height;
                [self startAnimateView_x:origin_x _y:origin_y origin_width:size_width origin_height:size_height];
            }
            break;
        }
        case IKTipsArrowDirectionUpCenter: {
            {
                self.contentLabel.frame = CGRectMake(self.origin.x, self.origin.y + Length, 0, 0);
                CGFloat origin_x = self.origin.x - self.width / 2;
                CGFloat origin_y = self.origin.y + Length;
                CGFloat size_width = self.width;
                CGFloat size_height = self.height;
                [self startAnimateView_x:origin_x _y:origin_y origin_width:size_width origin_height:size_height];
            }
            break;
        }
        case IKTipsArrowDirectionUpRight: {
            {
                self.contentLabel.frame = CGRectMake(self.origin.x, self.origin.y + Length, 0, 0);
                CGFloat origin_x = self.origin.x + Length2;
                CGFloat origin_y = self.origin.y + Length;
                CGFloat size_width = -self.width;
                CGFloat size_height = self.height;
                [self startAnimateView_x:origin_x _y:origin_y origin_width:size_width origin_height:size_height];
            }
            break;
        }
        case IKTipsArrowDirectionDownLeft: {
            {
                self.contentLabel.frame = CGRectMake(self.origin.x, self.origin.y - Length, 0, 0);
                CGFloat origin_x = self.origin.x - Length2;
                CGFloat origin_y = self.origin.y - Length;
                CGFloat size_width = self.width;
                CGFloat size_height = -self.height;
                [self startAnimateView_x:origin_x _y:origin_y origin_width:size_width origin_height:size_height];
            }
            break;
        }
        case IKTipsArrowDirectionDownCenter: {
            {
                self.contentLabel.frame = CGRectMake(self.origin.x, self.origin.y - Length, 0, 0);
                CGFloat origin_x = self.origin.x - self.width / 2;
                CGFloat origin_y = self.origin.y - Length;
                CGFloat size_width = self.width;
                CGFloat size_height = -self.height;
                [self startAnimateView_x:origin_x _y:origin_y origin_width:size_width origin_height:size_height];
            }
            break;
        }
        case IKTipsArrowDirectionDownRight: {
            {
                self.contentLabel.frame = CGRectMake(self.origin.x, self.origin.y - Length, 0, 0);
                CGFloat origin_x = self.origin.x-self.width + Length2;
                CGFloat origin_y = self.origin.y - Length;
                CGFloat size_width = self.width;
                CGFloat size_height = -self.height;
                [self startAnimateView_x:origin_x _y:origin_y origin_width:size_width origin_height:size_height];
            }
            break;
        }
    }
}
#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![[touches anyObject].view isEqual:self.contentLabel]) {
        [self dismiss];
    }
    
}
#pragma mark -
- (void)dismiss
{
    NSArray *results = [self subviews];
    for (UIView *view in results) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}
#pragma mark -
- (void)startAnimateView_x:(CGFloat) x
                        _y:(CGFloat) y
              origin_width:(CGFloat) width
             origin_height:(CGFloat) height
{
    self.contentLabel.frame = CGRectMake(x, y, width, height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
