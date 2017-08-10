//
//  IKAppraiseView.m
//  IamKing
//
//  Created by Luris on 2017/8/2.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKAppraiseView.h"


@protocol IKStarViewDelegate <NSObject>

- (void)starViewHadSelected:(NSInteger )selectedIndex viewTag:(NSInteger )viewTag;

@end


@interface IKStarView : UIView

@property(nonatomic,assign)CGFloat selfH;
@property(nonatomic,assign)CGFloat selectedNum;
@property(nonatomic,copy)NSMutableArray *buttonArray;
@property(nonatomic,weak)id <IKStarViewDelegate> delegate;

- (void)addHollowStarToStarView;

@end


@implementation IKStarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selfH = frame.size.height;
        _selectedNum = 0;
        
        [self addHollowStarToStarView];
    }
    
    return self;
}


- (NSMutableArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _buttonArray;
}

- (void)setDelegate:(id<IKStarViewDelegate>)delegate
{
    if (delegate) {
        _delegate = delegate;
    }
}

- (void)addHollowStarToStarView
{
    for (NSInteger i = 0; i < 5; i++) {
        IKButton *imageBtn = [IKButton buttonWithType:UIButtonTypeCustom];
        imageBtn.frame = CGRectMake((_selfH + 5) * i, 0, _selfH, _selfH);
        imageBtn.tag = i+1;
        imageBtn.adjustsImageWhenHighlighted = NO;
        [imageBtn addTarget:self action:@selector(starButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageBtn setImage:[UIImage imageNamed:@"IK_star_hollow_red"] forState:UIControlStateNormal];
        [self.buttonArray addObject:imageBtn];
        [self addSubview:imageBtn];
    }
}

- (void)starButtonClick:(IKButton *)button
{
    NSLog(@"starButtonClick = %ld tag = %ld",button.tag,self.tag);
    NSInteger selectedIndex = 0;
    
    if (!button.isClick) {
        [self addSolidStar:button.tag];
        button.isClick = YES;
        selectedIndex = button.tag;
    }
    else{
        [button setImage:[UIImage imageNamed:@"IK_star_hollow_red"] forState:UIControlStateNormal];
        button.isClick = NO;
        
        if (button.tag < _selectedNum) {
            for (NSInteger i = button.tag; i < _selectedNum; i ++) {
                IKButton *btn = (IKButton *)[self.buttonArray objectAtIndex:i];
                [btn setImage:[UIImage imageNamed:@"IK_star_hollow_red"] forState:UIControlStateNormal];
                btn.isClick = NO;
            }
        }
        selectedIndex = button.tag - 1;
    }
    
    if ([self.delegate respondsToSelector:@selector(starViewHadSelected:viewTag:)]) {
        [self.delegate starViewHadSelected:selectedIndex viewTag:self.tag];
    }
}

- (void)addSolidStar:(NSInteger )number
{
    for (NSInteger i = 0; i < 5; i++) {
        IKButton *button = (IKButton *)[self.buttonArray objectAtIndex:i];
        
        if (i < number) {
            [button setImage:[UIImage imageNamed:@"IK_star_solid_red"] forState:UIControlStateNormal];
            button.isClick = YES;
        }
        else{
            [button setImage:[UIImage imageNamed:@"IK_star_hollow_red"] forState:UIControlStateNormal];
            button.isClick = NO;
        }
    }
    
    _selectedNum = number;
}

@end


@interface IKAppraiseViewController : UIViewController

@property (nonatomic, strong) UIView *showView;

- (void)addShowView:(UIView *)showView;
- (void)removeShowView;

@end

@implementation IKAppraiseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = self.view.frame;
    bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight|
    UIViewAutoresizingFlexibleWidth;
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5f;
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
    _showView.center = CGPointMake(ceilf(IKSCREEN_WIDTH*0.5), ceilf(IKSCREENH_HEIGHT*0.5 - 44));
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

@interface IKAppraiseView()<IKStarViewDelegate>

@property (nonatomic, strong) UIWindow  *alertWindow;
@property (nonatomic, copy) NSMutableArray     *selectArray;
@property (nonatomic, assign) NSInteger    hasSelected;
@property (nonatomic, strong) UILabel    *tipLabel;

//@property (nonatomic, weak) id<IKAlertViewDelegate> delegate;

@end

@implementation IKAppraiseView

+ (instancetype)sharedInstance{
    static IKAppraiseView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[[self class] alloc] init];
        
        shareInstance.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        shareInstance.alertWindow.backgroundColor = [UIColor clearColor];
        shareInstance.alertWindow.windowLevel = UIWindowLevelAlert;
        [shareInstance.alertWindow setHidden:YES];
        
        //controller
        IKAppraiseViewController *controller = [[IKAppraiseViewController alloc] init];
        shareInstance.alertWindow.rootViewController = controller;
    });
    
    return shareInstance;
}

#pragma mark - Function - Public


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    
    return self;
}


- (NSMutableArray *)selectArray
{
    if (_selectArray == nil) {
        _selectArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", nil];
    }
    return _selectArray;
}

- (void)setDelegate:(id<IKAppraiseViewDelegate>)delegate
{
    if (delegate) {
        _delegate = delegate;
    }
}

- (void)show
{
    [self showAppraiseView];
}

- (void)setupUI
{
    
    _hasSelected = 0;
    
    CGFloat selfW = ceilf(IKSCREEN_WIDTH * 0.787);
    CGFloat selfH = ceilf(IKSCREENH_HEIGHT * 0.57);
    CGFloat totalH = 0;
    self.frame = CGRectMake(0, 0, selfW, selfH);
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,selfW,selfH*0.158)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = IKGeneralBlue;
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    titleLabel.text = @"评价这家公司/品牌";
    [self addSubview:titleLabel];
    
    //分割线
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(10,CGRectGetHeight(titleLabel.frame) , selfH-20, 1)];
    seperator.backgroundColor = IKLineColor;
    [self addSubview:seperator];
    
    totalH = CGRectGetHeight(titleLabel.frame) + 1;
    
    NSArray *titleArray = @[@"品牌知名度",@"行业影响力",@"企业规模",@"团队人才",@"薪资福利",@"发展潜力"];
    CGFloat labelH = ceilf(selfH*0.632*0.167); //0.167 = 1/6;
    
    for (int i = 0; i < titleArray.count; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(22, totalH + 10 + i *labelH, selfH*0.29, labelH)];
        label.text = [titleArray objectAtIndex:i];
        label.textColor = IKMainTitleColor;
        label.font = [UIFont systemFontOfSize:IKMainTitleFont];
        label.textAlignment = NSTextAlignmentLeft;
//        label.backgroundColor = [UIColor redColor];
        [self addSubview:label];
        
        IKStarView *starView = [[IKStarView alloc] initWithFrame:CGRectMake(label.frame.origin.x + label.frame.size.width, label.center.y - 9, 140, 18)];
        
        starView.tag = i + 100;
        starView.delegate = self;
        [self addSubview:starView];
    }
    
    totalH = totalH + 10 + 6 *labelH;
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(25, totalH + 15, ceilf(selfW*0.373), selfH*0.092);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    cancel.layer.cornerRadius = 6;
    cancel.layer.borderColor = IKGeneralBlue.CGColor;
    cancel.layer.borderWidth = 1;
    [cancel addTarget:self action:@selector(hideShowingAlertView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    
    UIButton *ok = [UIButton buttonWithType:UIButtonTypeCustom];
    ok.frame = CGRectMake(selfW - ceilf(selfW*0.373) - 25, totalH + 15, ceilf(selfW*0.373), ceilf(selfH*0.092));
    [ok setTitle:@"确定" forState:UIControlStateNormal];
    [ok setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ok.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    ok.backgroundColor = IKGeneralBlue;
    ok.layer.cornerRadius = 6;
    [ok addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [ok setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];

    [self addSubview:ok];
}


#pragma mark - action


- (void)starViewHadSelected:(NSInteger )selectedIndex viewTag:(NSInteger )viewTag
{
    NSLog(@"selectedIndex = %ld viewTag = %ld",selectedIndex,viewTag);
    
    NSString *selectStr = [NSString stringWithFormat:@"%ld",selectedIndex];
    
    switch (viewTag) {
        case 100:
        {
            [self.selectArray replaceObjectAtIndex:0 withObject:selectStr];
            _hasSelected += 1;
            break;
        }
        case 101:
        {
            [self.selectArray replaceObjectAtIndex:1 withObject:selectStr];
            _hasSelected += 1;
            break;
        }
        case 102:
        {
            [self.selectArray replaceObjectAtIndex:2 withObject:selectStr];
            _hasSelected += 1;
            break;
        }
        case 103:
        {
            [self.selectArray replaceObjectAtIndex:3 withObject:selectStr];
            _hasSelected += 1;
            break;
        }
        case 104:
        {
            [self.selectArray replaceObjectAtIndex:4 withObject:selectStr];
            _hasSelected += 1;
            break;
        }
        case 105:
        {
            [self.selectArray replaceObjectAtIndex:5 withObject:selectStr];
            _hasSelected += 1;
            break;
        }
            
        default:
            break;
    }
    

}

- (UILabel *)tipLabel
{
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width*0.5 - 60, self.frame.size.height*0.5 - 15, 120, 30)];
        _tipLabel.text = @"您还未完成评价";
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = [UIFont systemFontOfSize:13.0f];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.layer.cornerRadius = 6;
        _tipLabel.layer.masksToBounds = YES;
        _tipLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
        _tipLabel.hidden = YES;
        [self insertSubview:_tipLabel atIndex:2];

    }
    return _tipLabel;
}

- (void)actionClick:(UIButton *)button
{
    
    if (_hasSelected == 6) {
        
        if ([self.delegate respondsToSelector:@selector(appraiseViewSelectedData:)]) {
            [self.delegate appraiseViewSelectedData:self.selectArray];
        }
        [self hideShowingAlertView];
    }
    else{
        self.tipLabel.hidden = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.tipLabel.hidden = YES;
        });
    }

}



#pragma mark - Function - Private


- (void)hideShowingAlertView
{
    IKAppraiseView *alert = [[self class] sharedInstance];
    IKAppraiseViewController *rootController = (IKAppraiseViewController *)alert.alertWindow.rootViewController;
    
    [rootController removeShowView];
    alert.alertWindow.hidden = YES;
    [alert.alertWindow resignKeyWindow];
}

- (void)showAppraiseView
{
    IKAppraiseView *alert = [[self class] sharedInstance];
    IKAppraiseViewController *rootController = (IKAppraiseViewController *)alert.alertWindow.rootViewController;
    
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
