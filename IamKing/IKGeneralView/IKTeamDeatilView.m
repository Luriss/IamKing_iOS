//
//  IKTeamDeatilView.m
//  IamKing
//
//  Created by Luris on 2017/8/9.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTeamDeatilView.h"


@interface IKTeamDeatilViewController : UIViewController

@property (nonatomic, strong) UIView *showView;

- (void)addShowView:(UIView *)showView;
- (void)removeShowView;

@end

@implementation IKTeamDeatilViewController


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

@interface IKTeamDeatilView()

@property (nonatomic, strong) UIWindow *alertWindow;
@property (nonatomic, strong) NSMutableArray *showArray;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *position;
//@property (nonatomic, weak) id<IKAlertViewDelegate> delegate;

@end

@implementation IKTeamDeatilView

+ (instancetype)sharedInstance{
    static IKTeamDeatilView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[[self class] alloc] init];
        
        shareInstance.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        shareInstance.alertWindow.backgroundColor = [UIColor clearColor];
        shareInstance.alertWindow.windowLevel = UIWindowLevelAlert;
        [shareInstance.alertWindow setHidden:YES];
        
        //controller
        IKTeamDeatilViewController *controller = [[IKTeamDeatilViewController alloc] init];
        shareInstance.alertWindow.rootViewController = controller;
        shareInstance.showArray = [NSMutableArray arrayWithCapacity:2];
    });
    
    return shareInstance;
}

#pragma mark - Function - Public

- (instancetype)initWithName:(NSString *)name
                      message:(NSString *)message
                     position:(NSString *)position
{
    self = [super init];
    if(self){
    
        self.title = name;
        self.message = message;
        self.position = position;
        
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
    
    self.backgroundColor = [UIColor clearColor];
    CGFloat width = ceilf(IKSCREEN_WIDTH * 0.83);
    CGFloat height = 200;

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(13, 13, width - 26, 174)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:bgView];
    
    // 关闭
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(hideShowingAlertView) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(width - 26, 0, 26, 26);
    button.layer.cornerRadius = 13;
    button.layer.masksToBounds = YES;
    button.backgroundColor = IKGeneralBlue;
    button.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [button setImage:[UIImage imageNamed:@"IK_close_white"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_close_white"] forState:UIControlStateHighlighted];
    [self addSubview:button];
    
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, width - 40, 25)];
    name.textColor = IKGeneralBlue;
    name.text = self.title;
    name.textAlignment = NSTextAlignmentLeft;
    name.font = [UIFont boldSystemFontOfSize:17.0f];
    
    [bgView addSubview:name];
    
    
    UILabel *position = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, width - 40, 25)];
    position.textColor = IKMainTitleColor;
    position.text = self.position;
    position.textAlignment = NSTextAlignmentLeft;
    position.font = [UIFont boldSystemFontOfSize:13.0f];
    
    [bgView addSubview:position];
    
    //分割线
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(10, 85, width - 20, 1)];
    seperator.backgroundColor = IKLineColor;
    [bgView addSubview:seperator];
    
    
//    CGFloat verticalSpace = 10;
//    CGFloat horizentalSpace = 10;
//    CGFloat btnHeight = 44;
    
    //self
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
//    self.backgroundColor = [UIColor clearColor];
    
//    if (_title.length > 0) {
//        UILabel *titleLabel = [[UILabel alloc] init];
//        titleLabel.numberOfLines = 0;
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.textColor = IKAlertTitleColor;
//        titleLabel.font = IKAlertTitleFont;
//        titleLabel.text = _title;
//        titleLabel.backgroundColor = [UIColor clearColor];
//        CGSize size = [self getSizeWithString:_title size:CGSizeMake(width - 2*horizentalSpace, MAXFLOAT) attribute:@{NSFontAttributeName:IKAlertTitleFont}];
//        titleLabel.frame = CGRectMake((width - size.width) * 0.5, verticalSpace, size.width, size.height);
//        [self addSubview:titleLabel];
//        
//        height = CGRectGetHeight(titleLabel.frame) + titleLabel.frame.origin.y;
//    }
//    
//    if (_message.length > 0) {
//        UILabel *messageLabel = [[UILabel alloc] init];
//        messageLabel.numberOfLines = 0;
//        messageLabel.textAlignment = NSTextAlignmentCenter;
//        messageLabel.textColor = IKAlertMessageColor;
//        messageLabel.font = IKAlertMessageFont;
//        messageLabel.text = _message;
//        messageLabel.backgroundColor = [UIColor clearColor];
//        
//        CGSize mSize = [self getSizeWithString:_message size:CGSizeMake(width - 2*horizentalSpace, MAXFLOAT) attribute:@{NSFontAttributeName:IKAlertMessageFont}];
//        messageLabel.frame = CGRectMake((width - mSize.width) * 0.5, height>0?(height+10):verticalSpace, mSize.width, mSize.height);
//        [self addSubview:messageLabel];
//        
//        height = CGRectGetHeight(messageLabel.frame) + messageLabel.frame.origin.y;
//    }
//    

//    
//    height = CGRectGetHeight(seperator.frame) + seperator.frame.origin.y;
//    
//    //暂时支持2个按钮
//    
//    if ([_buttons count] == 1) {
//        CGRect tmpFrame = CGRectMake(0, height, width, btnHeight);
//        UIButton *btn = [self getBtnWithText:[_buttons firstObject]
//                                       frame:tmpFrame];
//        [btn addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
//        btn.titleLabel.font = IKAlertButtonFont;
//        btn.tag = 1;
//        [self addSubview:btn];
//        height = CGRectGetHeight(btn.frame) + btn.frame.origin.y;
//        
//    }
//    else{
//        //目前只支持2个按钮
//        for (int i = 0; i < 2; i ++) {
//            CGRect tmpFrame = CGRectMake(i * (width/2), height, width/2, btnHeight);
//            UIButton *btn = [self getBtnWithText:[_buttons objectAtIndex:i]
//                                           frame:tmpFrame];
//            btn.tag = i;
//            [btn addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
//            [self addSubview:btn];
//        }
//        
//        //垂直 分割线
//        UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(width*0.5, height + 10, 1, btnHeight - 20)];
//        verticalLine.backgroundColor = IKAlertLineColor;
//        [self addSubview:verticalLine];
//        
//        height += btnHeight;
//    }
    
    self.frame = CGRectMake((IKSCREEN_WIDTH - width)*0.5, (IKSCREENH_HEIGHT - height)*0.5, width, height);
}

//- (UIButton *)getBtnWithText:(NSString *)text frame:(CGRect)frame
//{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:text forState:UIControlStateNormal];
//    [btn setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
//    [btn setBackgroundImage:nil
//                   forState:UIControlStateNormal];
//    UIImage *hlImage = [self getImageWithColor:IKAlertLineColor
//                                          size:frame.size];
//    [btn setBackgroundImage:hlImage
//                   forState:UIControlStateHighlighted];
//    btn.titleLabel.font = IKAlertButtonFont;
//    btn.frame = frame;
//    
//    return btn;
//}

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
//    if ([self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
//        [self.delegate alertView:self clickedButtonAtIndex:button.tag];
//    }
}

//- (void)alertView:(IKAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSLog(@"clickedButtonAtIndex");
//}

#pragma mark - Function - Private

- (void)fetchShowingAlertView
{
    IKTeamDeatilView *alert = [[self class] sharedInstance];
    if (alert.showArray.count > 0) {
        [self hideShowingAlertView];
    }
}

- (void)hideShowingAlertView
{
    IKTeamDeatilView *alert = [[self class] sharedInstance];
    IKTeamDeatilViewController *rootController = (IKTeamDeatilViewController *)alert.alertWindow.rootViewController;
    
    [rootController removeShowView];
    alert.alertWindow.hidden = YES;
    [alert.alertWindow resignKeyWindow];
}

- (void)showAlertView
{
    
    IKTeamDeatilView *alert = [[self class] sharedInstance];
    
    IKTeamDeatilViewController *rootController = (IKTeamDeatilViewController *)alert.alertWindow.rootViewController;
    
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
//                         self.backgroundColor = [UIColor whiteColor];
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
