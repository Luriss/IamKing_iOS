//
//  IKTeamDeatilView.m
//  IamKing
//
//  Created by Luris on 2017/8/9.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKTeamDeatilView.h"
#import "IKLabel.h"

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
    _showView.center = CGPointMake(IKSCREEN_WIDTH*0.5, IKSCREENH_HEIGHT * 0.5);
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

    CGFloat bgW = width - 26;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(13, 13, bgW, 174)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    // 关闭
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(width - 26, 0, 26, 26);
    button.layer.cornerRadius = 13;
    button.layer.masksToBounds = YES;
    button.backgroundColor = IKGeneralBlue;
    button.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [button setImage:[UIImage imageNamed:@"IK_close_white"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_close_white"] forState:UIControlStateHighlighted];
    [self addSubview:button];
    
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, bgW - 40, 25)];
    name.textColor = IKGeneralBlue;
    name.text = self.title;
    name.textAlignment = NSTextAlignmentLeft;
    name.font = [UIFont boldSystemFontOfSize:17.0f];
    
    [bgView addSubview:name];
    
    
    UILabel *position = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, bgW - 40, 25)];
    position.textColor = IKMainTitleColor;
    position.text = self.position;
    position.textAlignment = NSTextAlignmentLeft;
    position.font = [UIFont boldSystemFontOfSize:13.0f];
    
    [bgView addSubview:position];
    
    //分割线
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(10, 85, bgW - 20, 1)];
    seperator.backgroundColor = IKLineColor;
    [bgView addSubview:seperator];
    
    
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 110, bgW, 80)];
    bgScrollView.backgroundColor = [UIColor whiteColor];
    bgScrollView.scrollEnabled = YES;
    bgScrollView.bounces = NO;
    //    scrollView.delegate = self;
    bgScrollView.showsVerticalScrollIndicator = YES;
    [bgView addSubview:bgScrollView];
    
    
//    self.message = @"新锐时尚健身俱乐部品牌，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌1，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌2，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌3，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌，致力于为年轻人提供时尚有品质的健身运动体验新锐时尚健身俱乐部品牌4，致力于为年轻人提供时尚有品质的健身运动体验";
//   
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12.0f],NSParagraphStyleAttributeName:paragraphStyle};
    CGSize size = [self getSizeWithString:self.message size:CGSizeMake(bgW - 40, MAXFLOAT) attribute:attributes];

    IKLabel *desc = [[IKLabel alloc] initWithFrame:CGRectMake(20, 0, bgW - 40, (size.height<80)?80:(size.height+20))];
    desc.textColor = IKSubHeadTitleColor;
    desc.attributedText = [[NSAttributedString alloc] initWithString:self.message attributes:attributes];
    desc.textAlignment = NSTextAlignmentLeft;
    desc.font = [UIFont systemFontOfSize:12.0f];
    desc.numberOfLines = 0;
    desc.verticalAlignment = IKVerticalAlignmentTop;
    [bgScrollView addSubview:desc];
    
    NSLog(@"size.height = %.0f",size.height);
    if (size.height > 300) {
        height = 400;
        bgScrollView.contentSize = CGSizeMake(bgW, size.height + 20);
    }
    else{
        height = 110 + CGRectGetHeight(desc.frame);
    }
    
    bgScrollView.frame = CGRectMake(0, 110, bgW,height - 110);
    bgView.frame = CGRectMake(13, 13, bgW, height);
    self.frame = CGRectMake(0, 0, width, height);
}

#pragma mark - action

- (void)closeClick:(UIButton *)button
{
    
    [self hideShowingAlertView];
}

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
