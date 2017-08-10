//
//  IKShopDetailView.m
//  IamKing
//
//  Created by Luris on 2017/8/9.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKShopDetailView.h"
#import "IKLabel.h"
#import "IKImageWordView.h"
#import "IKLoopPlayView.h"


@interface IKShopDetailViewController : UIViewController

@property (nonatomic, strong) UIView *showView;

- (void)addShowView:(UIView *)showView;
- (void)removeShowView;

@end

@implementation IKShopDetailViewController


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

@interface IKShopDetailView()

@property (nonatomic, strong) UIWindow *alertWindow;
@property (nonatomic, strong) NSMutableArray *showArray;
@property (nonatomic, strong) IKCompanyShopNumModel *model;
//@property (nonatomic, copy) NSString *message;
//@property (nonatomic, copy) NSString *position;
//@property (nonatomic, weak) id<IKAlertViewDelegate> delegate;

@property(nonatomic,strong)IKImageWordView     *addressView;
@property(nonatomic,strong)IKImageWordView     *shopTypeView;
@property(nonatomic,strong)IKImageWordView     *squareView;
@property(nonatomic,strong)IKImageWordView     *memberView;
@property(nonatomic,strong)IKLoopPlayView      *lpView;

@end

@implementation IKShopDetailView

+ (instancetype)sharedInstance{
    static IKShopDetailView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[[self class] alloc] init];
        
        shareInstance.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        shareInstance.alertWindow.backgroundColor = [UIColor clearColor];
        shareInstance.alertWindow.windowLevel = UIWindowLevelAlert;
        [shareInstance.alertWindow setHidden:YES];
        
        //controller
        IKShopDetailViewController *controller = [[IKShopDetailViewController alloc] init];
        shareInstance.alertWindow.rootViewController = controller;
        shareInstance.showArray = [NSMutableArray arrayWithCapacity:2];
    });
    
    return shareInstance;
}

#pragma mark - Function - Public

- (instancetype)initWithShopDetailModel:(IKCompanyShopNumModel *)model
{
    self = [super init];
    if(self){
        
        NSLog(@"model.description = %@",model.description);
        self.model = model;
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




- (IKImageWordView *)addressView
{
    if (_addressView == nil) {
        // 地点
        _addressView = [[IKImageWordView alloc] init];
        [_addressView.imageView setImage:[UIImage imageNamed:@"IK_address_blue"]];
        _addressView.backgroundColor = IKGeneralLightGray;
    }
    return _addressView;
}

- (IKImageWordView *)shopTypeView
{
    if (_shopTypeView == nil) {
        //
        _shopTypeView = [[IKImageWordView alloc] init];
        [_shopTypeView.imageView setImage:[UIImage imageNamed:@"IK_circle_blue"]];
        _shopTypeView.backgroundColor = IKGeneralLightGray;
    }
    return _shopTypeView;
}


- (IKImageWordView *)squareView
{
    if (_squareView == nil) {
        //
        _squareView = [[IKImageWordView alloc] init];
        [_squareView.imageView setImage:[UIImage imageNamed:@"IK_square_blue"]];
        _squareView.backgroundColor = IKGeneralLightGray;
    }
    return _squareView;
}

- (IKImageWordView *)memberView
{
    if (_memberView == nil) {
        _memberView = [[IKImageWordView alloc] init];
        [_memberView.imageView setImage:[UIImage imageNamed:@"IK_member_blue"]];
        _memberView.backgroundColor = IKGeneralLightGray;
    }
    return _memberView;
}

- (IKLoopPlayView *)lpView
{
    if (_lpView == nil) {
        _lpView = [[IKLoopPlayView alloc]init];
        _lpView.scrollDirection = IKLPVScrollDirectionHorizontal;
//        _lpView.scrollTimeInterval = 4;
        _lpView.pageControlHidden = NO;
        _lpView.isAutoScroll = NO;
        _lpView.imagesArray = self.model.allShopImages;
    }
    return _lpView;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, IKSCREEN_WIDTH, 174)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    // 关闭
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(20, 0, 30, 30);
    button.layer.cornerRadius = 15;
    button.layer.masksToBounds = YES;
    button.backgroundColor = IKGeneralBlue;
    button.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [button setImage:[UIImage imageNamed:@"IK_close_white"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_close_white"] forState:UIControlStateHighlighted];
    [self addSubview:button];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IKSCREEN_WIDTH, ceilf(IKSCREENH_HEIGHT * 0.15))];
    topView.backgroundColor = IKGeneralLightGray;
    [bgView addSubview:topView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [topView addGestureRecognizer:tap];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, IKSCREEN_WIDTH - 60, 35)];
    name.textColor = IKGeneralBlue;
    name.text = self.model.name;
    name.textAlignment = NSTextAlignmentLeft;
    name.font = [UIFont boldSystemFontOfSize:19.0f];
    [topView addSubview:name];

    CGFloat totalW = 0;
    CGFloat addressW = [self getSizeWithString:self.model.workCity size:CGSizeMake(100, 20) attribute:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]}].width;
    self.addressView.frame = CGRectMake(20, 55, addressW + 20, 20);
//    self.addressView.backgroundColor = [UIColor redColor];
    self.addressView.label.text = self.model.workCity;
    [topView addSubview:self.addressView];
    
    totalW = 40 + addressW;
    
    CGFloat shopTypeW = [self getSizeWithString:self.model.shopTypeName size:CGSizeMake(100, 20) attribute:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]}].width;
    self.shopTypeView.frame = CGRectMake(totalW, 55, shopTypeW + 20, 20);
//    self.shopTypeView.backgroundColor = [UIColor redColor];
    self.shopTypeView.label.text = self.model.shopTypeName;
    [topView addSubview:self.shopTypeView];
    
    totalW += shopTypeW+20;
    
    CGFloat squareW = [self getSizeWithString:self.model.area size:CGSizeMake(100, 20) attribute:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]}].width;
    self.squareView.frame = CGRectMake(totalW, 55, squareW + 20, 20);
//    self.squareView.backgroundColor = [UIColor redColor];
    self.squareView.label.text = self.model.area;
    [topView addSubview:self.squareView];
    
    totalW += squareW+20;

    CGFloat memberW = [self getSizeWithString:self.model.numberOfMember size:CGSizeMake(100, 20) attribute:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]}].width;
    self.memberView.frame = CGRectMake(totalW, 55, memberW + 20, 20);
//    self.memberView.backgroundColor = [UIColor redColor];
    self.memberView.label.text = self.model.numberOfMember;
    [topView addSubview:self.memberView];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(IKSCREEN_WIDTH - 55, topView.center.y - 15, 30, 30)];
    
    arrowView.contentMode = UIViewContentModeScaleToFill;
    [arrowView setImage:[UIImage imageNamed:@"IK_arrow_gray"]];
    
    [topView addSubview:arrowView];

    [bgView addSubview:self.lpView];
    
    self.lpView.frame = CGRectMake(0, ceilf(IKSCREENH_HEIGHT * 0.15) + 20, IKSCREEN_WIDTH, ceilf(IKSCREENH_HEIGHT * 0.4));
    
    bgView.frame = CGRectMake(0, 13, IKSCREEN_WIDTH, ceilf(IKSCREENH_HEIGHT*0.63) - 15);
    self.frame = CGRectMake(0, 0, IKSCREEN_WIDTH, ceilf(IKSCREENH_HEIGHT*0.63));
}

#pragma mark - action

- (void)closeClick:(UIButton *)button
{
    [self hideShowingAlertView];
}


- (void)tapView:(UITapGestureRecognizer *)tap
{
    [self hideShowingAlertView];
    
    if ([self.delegate respondsToSelector:@selector(showShopListWithShopID: companyID:)]) {
        [self.delegate showShopListWithShopID:self.model.ID companyID:self.model.companyID];
    }
}

#pragma mark - Function - Private

- (void)fetchShowingAlertView
{
    IKShopDetailView *alert = [[self class] sharedInstance];
    if (alert.showArray.count > 0) {
        [self hideShowingAlertView];
    }
}

- (void)hideShowingAlertView
{
    IKShopDetailView *alert = [[self class] sharedInstance];
    IKShopDetailViewController *rootController = (IKShopDetailViewController *)alert.alertWindow.rootViewController;
    
    [rootController removeShowView];
    alert.alertWindow.hidden = YES;
    [alert.alertWindow resignKeyWindow];
}

- (void)showAlertView
{
    
    IKShopDetailView *alert = [[self class] sharedInstance];
    
    IKShopDetailViewController *rootController = (IKShopDetailViewController *)alert.alertWindow.rootViewController;
    
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
