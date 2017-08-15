//
//  IKInterviewInfoView.m
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKInterviewInfoView.h"


@interface IKInterviewInfoViewController : UIViewController

@property (nonatomic, strong) UIView *showView;

- (void)addShowView:(UIView *)showView;
- (void)removeShowView;

@end

@implementation IKInterviewInfoViewController


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

@interface IKInterviewInfoView()<IKInterviewInfoViewDelegate>

@property (nonatomic, strong) UIWindow *alertWindow;
@property (nonatomic, strong) NSMutableArray *showArray;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, weak) id<IKInterviewInfoViewDelegate> delegate;

@end

@implementation IKInterviewInfoView

+ (instancetype)sharedInstance{
    static IKInterviewInfoView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[[self class] alloc] init];
        
        shareInstance.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        shareInstance.alertWindow.backgroundColor = [UIColor clearColor];
        shareInstance.alertWindow.windowLevel = UIWindowLevelAlert - 10;
        [shareInstance.alertWindow setHidden:YES];
        
        //controller
        IKInterviewInfoViewController *controller = [[IKInterviewInfoViewController alloc] init];
        shareInstance.alertWindow.rootViewController = controller;
        
        shareInstance.showArray = [NSMutableArray arrayWithCapacity:2];
    });
    
    return shareInstance;
}

#pragma mark - Function - Public

- (instancetype)initWithTime:(NSString *)time
                     address:(NSString *)address
                     contact:(NSString *)contact
                 phoneNumber:(NSString *)phone
                    delegate:(id <IKInterviewInfoViewDelegate>)delegate
{
    self = [super init];
    if(self){
        
        self.time = time;
        self.address = address;
        self.contact = contact;
        self.phone = phone;
        self.delegate = delegate;
        
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
    
    CGFloat width = ceil(IKSCREEN_WIDTH *0.787);
    
    CGFloat height = 0;
    
    //self
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, width - 40, 60)];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = IKGeneralBlue;
    titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    titleLabel.text = @"您收到面试邀请";
    titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:titleLabel];
    
    height = CGRectGetHeight(titleLabel.frame) + titleLabel.frame.origin.y;
    
    //分割线
    UIView *seperator1 = [[UIView alloc] initWithFrame:CGRectMake(20, height, width - 40, 1)];
    seperator1.backgroundColor = IKLineColor;
    [self addSubview:seperator1];
    
    UILabel *psLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, height+1, 60, 50)];
    psLabel1.numberOfLines = 0;
    psLabel1.textAlignment = NSTextAlignmentLeft;
    psLabel1.textColor = IKSubHeadTitleColor;
    psLabel1.font = [UIFont systemFontOfSize:13.0f];
    psLabel1.text = @"面试时间";
    [self addSubview:psLabel1];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, height+1, width - 115, 50)];
    timeLabel.numberOfLines = 0;
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.textColor = IKMainTitleColor;
    timeLabel.font = [UIFont systemFontOfSize:13.0f];
    timeLabel.text = self.time;
    [self addSubview:timeLabel];
    
    height = CGRectGetHeight(psLabel1.frame) + psLabel1.frame.origin.y;
    
    
    
    //分割线
    UIView *seperator2 = [[UIView alloc] initWithFrame:CGRectMake(20, height, width - 40, 1)];
    seperator2.backgroundColor = IKLineColor;
    [self addSubview:seperator2];
    
    
    CGSize size = [self getSizeWithString:self.address size:CGSizeMake(width - 120, MAXFLOAT) attribute:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]}];
    NSLog(@"size.height = %.0f",size.height);
    
    UILabel *psLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, height+1, 60, 30+size.height)];
    psLabel2.numberOfLines = 0;
    psLabel2.textAlignment = NSTextAlignmentLeft;
    psLabel2.textColor = IKSubHeadTitleColor;
    psLabel2.font = [UIFont systemFontOfSize:13.0f];
    psLabel2.text = @"面试地点";
    psLabel2.backgroundColor = [UIColor clearColor];
    [self addSubview:psLabel2];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, height+1, width - 115, 30+size.height)];
    addressLabel.numberOfLines = 0;
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.textColor = IKMainTitleColor;
    addressLabel.font = [UIFont systemFontOfSize:13.0f];
    addressLabel.text = self.address;
    [self addSubview:addressLabel];
    
    height = CGRectGetHeight(addressLabel.frame) + addressLabel.frame.origin.y;
    
    //分割线
    UIView *seperator3 = [[UIView alloc] initWithFrame:CGRectMake(20, height, width - 40, 1)];
    seperator3.backgroundColor = IKLineColor;
    [self addSubview:seperator3];
    
    UILabel *psLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(20, height+1, 60, 50)];
    psLabel3.numberOfLines = 0;
    psLabel3.textAlignment = NSTextAlignmentLeft;
    psLabel3.textColor = IKSubHeadTitleColor;
    psLabel3.font = [UIFont systemFontOfSize:13.0f];
    psLabel3.text = @"联系人";
    psLabel3.backgroundColor = [UIColor clearColor];
    [self addSubview:psLabel3];
    
    UILabel *contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, height+1, width - 115, 50)];
    contactLabel.numberOfLines = 0;
    contactLabel.textAlignment = NSTextAlignmentLeft;
    contactLabel.textColor = IKMainTitleColor;
    contactLabel.font = [UIFont systemFontOfSize:13.0f];
    contactLabel.text = self.contact;
    [self addSubview:contactLabel];
    
    height = CGRectGetHeight(psLabel3.frame) + psLabel3.frame.origin.y;
    
    //分割线
    UIView *seperator4 = [[UIView alloc] initWithFrame:CGRectMake(20, height, width - 40, 1)];
    seperator4.backgroundColor = IKLineColor;
    [self addSubview:seperator4];
    
    UILabel *psLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(20, height+1, 60, 50)];
    psLabel4.numberOfLines = 0;
    psLabel4.textAlignment = NSTextAlignmentLeft;
    psLabel4.textColor = IKSubHeadTitleColor;
    psLabel4.font = [UIFont systemFontOfSize:13.0f];
    psLabel4.text = @"联系电话";
    psLabel4.backgroundColor = [UIColor clearColor];
    [self addSubview:psLabel4];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, height+1, width - 115, 50)];
    phoneLabel.numberOfLines = 0;
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.textColor =  IKGeneralBlue;
    phoneLabel.font = [UIFont systemFontOfSize:13.0f];
    phoneLabel.text = self.phone;
    phoneLabel.userInteractionEnabled = YES;
    [self addSubview:phoneLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneTap:)];
    [phoneLabel addGestureRecognizer:tap];
    
    height = CGRectGetHeight(psLabel4.frame) + psLabel4.frame.origin.y;
    
    //分割线
    UIView *seperator5 = [[UIView alloc] initWithFrame:CGRectMake(20, height, width - 40, 1)];
    seperator5.backgroundColor = IKLineColor;
    [self addSubview:seperator5];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(23, height+16, 15, 15)];
    //    imageV.backgroundColor = [UIColor redColor];
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IK_hint_gray" ofType:@"png"]];
    [imageV setImage:image];
    [self addSubview:imageV];
    
    
    UILabel *psLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(40, height+1, width - 60, 60)];
    psLabel5.numberOfLines = 0;
    psLabel5.textAlignment = NSTextAlignmentLeft;
    psLabel5.textColor = IKSubHeadTitleColor;
    psLabel5.font = [UIFont systemFontOfSize:13.0f];
    psLabel5.text = @"点击确定后,如果爽约放鸽子,将对您今后的求职造成一定的影响,请遵守信用。";
    psLabel5.backgroundColor = [UIColor clearColor];
    [self addSubview:psLabel5];
    
    height = CGRectGetHeight(psLabel5.frame) + psLabel5.frame.origin.y;

    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(20, height + 15, 85, 40);
    [cancel setTitle:@"再想想" forState:UIControlStateNormal];
    [cancel setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
    [cancel setTitleColor:IKButtonClickColor forState:UIControlStateHighlighted];
    cancel.tag = 0;
    cancel.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    cancel.layer.cornerRadius = 6;
    cancel.layer.masksToBounds = YES;
    cancel.layer.borderColor = IKGeneralBlue.CGColor;
    cancel.layer.borderWidth = 1.0f;
    [cancel addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    
    UIButton *accept = [UIButton buttonWithType:UIButtonTypeCustom];
    accept.frame = CGRectMake(125, height + 15, width - 145, 40);
    [accept setTitle:@"确定前往面试" forState:UIControlStateNormal];
    [accept setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [accept setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
    accept.tag = 1;
    accept.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [accept setBackgroundImage:IKButtonBlueBgImgae forState:UIControlStateNormal];
    [accept setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
    accept.layer.cornerRadius = 6;
    accept.layer.masksToBounds = YES;
    [accept addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:accept];
    
    self.frame = CGRectMake((IKSCREEN_WIDTH - width)*0.5, (IKSCREENH_HEIGHT - height - 75)*0.5, width, height + 75);
}


#pragma mark - action

- (void)actionClick:(UIButton *)button
{
    [self hideShowingAlertView];
    if ([self.delegate respondsToSelector:@selector(interviewInfoViewClickedButtonAtIndex:)]) {
        [self.delegate interviewInfoViewClickedButtonAtIndex:button.tag];
    }
}


- (void)phoneTap:(UITapGestureRecognizer *)tap
{
    NSLog(@"phoneLabel");
    NSString *phoneStr = [NSString stringWithFormat:@"telprompt://%@",self.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
}

- (void)interviewInfoViewClickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark - Function - Private

- (void)fetchShowingAlertView
{
    IKInterviewInfoView *alert = [[self class] sharedInstance];
    if (alert.showArray.count > 0) {
        [self hideShowingAlertView];
    }
}

- (void)hideShowingAlertView
{
    IKInterviewInfoView *alert = [[self class] sharedInstance];
    IKInterviewInfoViewController *rootController = (IKInterviewInfoViewController *)alert.alertWindow.rootViewController;
    
    [rootController removeShowView];
    alert.alertWindow.hidden = YES;
    [alert.alertWindow resignKeyWindow];
}

- (void)showAlertView
{
    
    IKInterviewInfoView *alert = [[self class] sharedInstance];
    
    IKInterviewInfoViewController *rootController = (IKInterviewInfoViewController *)alert.alertWindow.rootViewController;
    
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

