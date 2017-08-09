//
//  IKAlertView.m
//  IamKing
//
//  Created by Luris on 2017/7/28.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKAlertView.h"

// rgb颜色转换（16进制->10进制）
#define IKAlertColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define IKStringIsEmpty(str) (([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 )? YES:NO)
#define IKAlertTitleColor   (IKAlertColorFromRGB(0x707070))
//#define IKPlaceHolderColor (IKColorFromRGB(0xbabac0))
#define IKAlertTitleFont [UIFont boldSystemFontOfSize:16.0f]
#define IKAlertMessageFont [UIFont systemFontOfSize:13.0f]
#define IKAlertMessageColor (IKAlertColorFromRGB(0xaaaaaa))
#define IKAlertLineColor (IKAlertColorFromRGB(0xf2f2f5))
#define IKAlertButtonFont [UIFont systemFontOfSize:14.0f]
#define IKAlertButtonColor (IKAlertTitleColor)


@interface IKAlertViewController : UIViewController

@property (nonatomic, strong) UIView *showView;

- (void)addShowView:(UIView *)showView;
- (void)removeShowView;

@end

@implementation IKAlertViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = self.view.frame;
    bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight|
    UIViewAutoresizingFlexibleWidth;
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.3f;
    bgView.transform = CGAffineTransformMakeScale(4, 4); //防止statusBar没有覆盖到
    [self.view addSubview:bgView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Function - Public

- (void)addShowView:(UIView *)showView
{
    if (self.showView) {
        [_showView removeFromSuperview];
    }
    self.showView = showView;
    _showView.center = CGPointMake(CGRectGetWidth(self.view.frame)*0.5, CGRectGetHeight(self.view.frame)*0.5);
    [self.view addSubview:_showView];
    
}

- (void)removeShowView
{
    if (self.showView) {
        [self.showView removeFromSuperview];
    }
    self.showView = nil;
}

@end

@interface IKAlertView()<IKAlertViewDelegate>

@property (nonatomic, strong) UIWindow *alertWindow;
@property (nonatomic, strong) NSMutableArray *showArray;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, weak) id<IKAlertViewDelegate> delegate;

@end

@implementation IKAlertView

+ (instancetype)sharedInstance{
    static IKAlertView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[[self class] alloc] init];
        
        shareInstance.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        shareInstance.alertWindow.backgroundColor = [UIColor clearColor];
        shareInstance.alertWindow.windowLevel = UIWindowLevelAlert;
        [shareInstance.alertWindow setHidden:YES];
        
        //controller
        IKAlertViewController *controller = [[IKAlertViewController alloc] init];
        shareInstance.alertWindow.rootViewController = controller;
        
        shareInstance.showArray = [NSMutableArray arrayWithCapacity:2];
    });
    
    return shareInstance;
}

#pragma mark - Function - Public

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                     delegate:(id <IKAlertViewDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    self = [super init];
    if(self){
        
        NSMutableArray *btnTitles = [NSMutableArray arrayWithCapacity:2];
        if (!IKStringIsEmpty(cancelButtonTitle)) {
            [btnTitles addObject:cancelButtonTitle];
        }
        if (otherButtonTitles) {
            va_list args;
            va_start(args, otherButtonTitles);
            for (NSString *tmpStr = otherButtonTitles; tmpStr != nil; tmpStr = va_arg(args, NSString *)){
                [btnTitles addObject:tmpStr];
            }
        }
        
        self.title = title;
        self.message = message;
        self.delegate = delegate;
        self.buttons = btnTitles;
        
        [self setupUI];
    }
    
    return self;
}

- (void)show
{
    //将显示中的AlertView拉回，暂存起来，显示新的AlertView
    [self fetchShowingAlertView];
    
    [self showAlertView];
}

- (void)setupUI{
    
     CGFloat width = 270;
    
    CGFloat verticalSpace = 10;
    CGFloat horizentalSpace = 10;
    CGFloat btnHeight = 44;
    
    CGFloat height = 0;
    
    //self
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
    if (_title.length > 0) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = IKAlertTitleColor;
        titleLabel.font = IKAlertTitleFont;
        titleLabel.text = _title;
        titleLabel.backgroundColor = [UIColor clearColor];
        CGSize size = [self getSizeWithString:_title size:CGSizeMake(width - 2*horizentalSpace, MAXFLOAT) attribute:@{NSFontAttributeName:IKAlertTitleFont}];
        titleLabel.frame = CGRectMake((width - size.width) * 0.5, verticalSpace, size.width, size.height);
        [self addSubview:titleLabel];
        
        height = CGRectGetHeight(titleLabel.frame) + titleLabel.frame.origin.y;
    }
    
    if (_message.length > 0) {
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.textColor = IKAlertMessageColor;
        messageLabel.font = IKAlertMessageFont;
        messageLabel.text = _message;
        messageLabel.backgroundColor = [UIColor clearColor];

        CGSize mSize = [self getSizeWithString:_message size:CGSizeMake(width - 2*horizentalSpace, MAXFLOAT) attribute:@{NSFontAttributeName:IKAlertMessageFont}];
        messageLabel.frame = CGRectMake((width - mSize.width) * 0.5, height>0?(height+10):verticalSpace, mSize.width, mSize.height);
        [self addSubview:messageLabel];
        
        height = CGRectGetHeight(messageLabel.frame) + messageLabel.frame.origin.y;
    }
    
    //分割线
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(20, height + verticalSpace + 10, width - 40, 1)];
    seperator.backgroundColor = IKAlertLineColor;
    [self addSubview:seperator];
    
    height = CGRectGetHeight(seperator.frame) + seperator.frame.origin.y;
    
    //暂时支持2个按钮
    
    if ([_buttons count] == 1) {
        CGRect tmpFrame = CGRectMake(0, height, width, btnHeight);
        UIButton *btn = [self getBtnWithText:[_buttons firstObject]
                                       frame:tmpFrame];
        [btn addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = IKAlertButtonFont;
        btn.tag = 1;
        [self addSubview:btn];
        height = CGRectGetHeight(btn.frame) + btn.frame.origin.y;

    }
    else{
        //目前只支持2个按钮
        for (int i = 0; i < 2; i ++) {
            CGRect tmpFrame = CGRectMake(i * (width/2), height, width/2, btnHeight);
            UIButton *btn = [self getBtnWithText:[_buttons objectAtIndex:i]
                                           frame:tmpFrame];
            btn.tag = i;
            [btn addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
        //垂直 分割线
        UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(width*0.5, height + 10, 1, btnHeight - 20)];
        verticalLine.backgroundColor = IKAlertLineColor;
        [self addSubview:verticalLine];
        
        height += btnHeight;
    }
    
    self.frame = CGRectMake((IKSCREEN_WIDTH - width)*0.5, (IKSCREENH_HEIGHT - height)*0.5, width, height);
}

- (UIButton *)getBtnWithText:(NSString *)text frame:(CGRect)frame
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
    [btn setBackgroundImage:nil
                   forState:UIControlStateNormal];
    UIImage *hlImage = [self getImageWithColor:IKAlertLineColor
                                          size:frame.size];
    [btn setBackgroundImage:hlImage
                   forState:UIControlStateHighlighted];
    btn.titleLabel.font = IKAlertButtonFont;
    btn.frame = frame;
    
    return btn;
}

- (UIImage *)getImageWithColor:(UIColor *)bgColor size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
    CGContextSetLineWidth(context, 0);
    [bgColor setFill];
    CGContextDrawPath(context, kCGPathFill);
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}

#pragma mark - action

- (void)actionClick:(UIButton *)button
{
    
    [self hideShowingAlertView];
    if ([self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [self.delegate alertView:self clickedButtonAtIndex:button.tag];
    }
}

- (void)alertView:(IKAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"clickedButtonAtIndex");
}

#pragma mark - Function - Private

- (void)fetchShowingAlertView
{
    IKAlertView *alert = [[self class] sharedInstance];
    if (alert.showArray.count > 0) {
        [self hideShowingAlertView];
    }
}

- (void)hideShowingAlertView
{
    IKAlertView *alert = [[self class] sharedInstance];
    IKAlertViewController *rootController = (IKAlertViewController *)alert.alertWindow.rootViewController;
    
    [rootController removeShowView];
    alert.alertWindow.hidden = YES;
    [alert.alertWindow resignKeyWindow];
}

- (void)showAlertView
{
    
    IKAlertView *alert = [[self class] sharedInstance];
    
    IKAlertViewController *rootController = (IKAlertViewController *)alert.alertWindow.rootViewController;
    
    self.alpha = 0.0f;
    self.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
    [rootController addShowView:self];
    
    alert.alertWindow.hidden = NO;
    [alert.alertWindow makeKeyAndVisible];
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:kNilOptions
                     animations:^{
                         self.alpha = 1;
                         self.backgroundColor = [UIColor whiteColor];
                         self.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                         [alert.showArray addObject:self];
                     }];
}

- (CGSize )getSizeWithString:(NSString *)string size:(CGSize )size attribute:(NSDictionary *)attribute
{
    CGSize  strSzie = [string boundingRectWithSize:size  options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine)  attributes:attribute context:nil].size;
    
    CGSize reSzie = CGSizeMake(ceilf(strSzie.width) + 8 , ceilf(strSzie.height)+8);
    
    return reSzie;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
