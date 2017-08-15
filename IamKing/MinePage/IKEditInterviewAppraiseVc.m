//
//  IKEditInterviewAppraiseVc.m
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKEditInterviewAppraiseVc.h"



@protocol IKAppraiseStarViewDelegate <NSObject>

- (void)starViewHadSelected:(NSInteger )selectedIndex viewTag:(NSInteger )viewTag;

@end


@interface IKAppraiseStarView : UIView

@property(nonatomic,assign)CGFloat selfH;
@property(nonatomic,assign)CGFloat selfW;

@property(nonatomic,assign)CGFloat selectedNum;
@property(nonatomic,copy)NSMutableArray *buttonArray;
@property(nonatomic,weak)id <IKAppraiseStarViewDelegate> delegate;

- (void)addHollowStarToStarView;

@end


@implementation IKAppraiseStarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selfH = frame.size.height;
        _selfW = frame.size.width;
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

- (void)setDelegate:(id<IKAppraiseStarViewDelegate>)delegate
{
    if (delegate) {
        _delegate = delegate;
    }
}

- (void)addHollowStarToStarView
{
    CGFloat spacing = (_selfW - (5 * _selfH)) * 0.25;
    
    NSLog(@"spacing = %.0f",spacing);
    for (NSInteger i = 0; i < 5; i++) {
        IKButton *imageBtn = [IKButton buttonWithType:UIButtonTypeCustom];
        imageBtn.frame = CGRectMake((_selfH + spacing) * i, 0, _selfH, _selfH);
        imageBtn.tag = i+1;
        imageBtn.adjustsImageWhenHighlighted = NO;
        [imageBtn addTarget:self action:@selector(starButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageBtn setImage:[UIImage imageNamed:@"IK_star_hollow_yellow"] forState:UIControlStateNormal];
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
        [button setImage:[UIImage imageNamed:@"IK_star_hollow_yellow"] forState:UIControlStateNormal];
        button.isClick = NO;
        
        if (button.tag < _selectedNum) {
            for (NSInteger i = button.tag; i < _selectedNum; i ++) {
                IKButton *btn = (IKButton *)[self.buttonArray objectAtIndex:i];
                [btn setImage:[UIImage imageNamed:@"IK_star_hollow_yellow"] forState:UIControlStateNormal];
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
            [button setImage:[UIImage imageNamed:@"IK_star_solid_yellow"] forState:UIControlStateNormal];
            button.isClick = YES;
        }
        else{
            [button setImage:[UIImage imageNamed:@"IK_star_hollow_yellow"] forState:UIControlStateNormal];
            button.isClick = NO;
        }
    }
    
    _selectedNum = number;
}

@end




@interface IKEditInterviewAppraiseVc ()<IKAppraiseStarViewDelegate>

@property(nonatomic,assign)CGFloat totalH;


@end

@implementation IKEditInterviewAppraiseVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavTitle];
    [self initLeftBackItem];
    [self initAppraiseStarView];
    // Do any additional setup after loading the view.
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"对此次面试进行评价";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:IKMainTitleFont];
    self.navigationView.titleView = title;
    
}


- (void)initLeftBackItem
{
    // 返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 00, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 50);
    [button setImage:[UIImage imageNamed:@"IK_back_white"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_back_white"] forState:UIControlStateHighlighted];
    
    self.navigationView.leftButton = button;
}

- (void)backButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initAppraiseStarView
{
    CGFloat height = ceil(IKSCREENH_HEIGHT * 0.225);
    UIView *starBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, IKSCREEN_WIDTH, height)];
    [self.view addSubview:starBottomView];
    
    
    NSArray *titleArray = @[@"面试官",@"职位相符",@"工作环境",@"薪资相符"];
    CGFloat labelH = ceilf(height * 0.25);
    
    for (int i = 0; i < titleArray.count; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(22,i*labelH, 80, labelH)];
        label.text = [titleArray objectAtIndex:i];
        label.textColor = IKMainTitleColor;
        label.font = [UIFont systemFontOfSize:IKMainTitleFont];
        label.textAlignment = NSTextAlignmentLeft;
        [starBottomView addSubview:label];
        
        IKAppraiseStarView *starView = [[IKAppraiseStarView alloc] initWithFrame:CGRectMake(starBottomView.center.x - 50, label.center.y - 10, ceil(IKSCREEN_WIDTH * 0.4), 20)];
        
        starView.tag = i + 100;
        starView.delegate = self;
        [starBottomView addSubview:starView];
    }

    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(20, 100 + height, IKSCREEN_WIDTH - 40, 1)];
    linView.backgroundColor = IKLineColor;
    [self.view addSubview:linView];
    
    _totalH = linView.frame.origin.y + 1;
}


- (void)starViewHadSelected:(NSInteger)selectedIndex viewTag:(NSInteger)viewTag
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
