//
//  IKShowAppraiseVc.m
//  IamKing
//
//  Created by Luris on 2017/8/16.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKShowAppraiseVc.h"
#import "IKLabel.h"

@interface IKMyAppraiseStarView : UIView

@property(nonatomic,assign)CGFloat selfH;
@property(nonatomic,assign)CGFloat selfW;

- (instancetype)initWithFrame:(CGRect)frame solidStar:(NSInteger )number;

@end


@implementation IKMyAppraiseStarView

- (instancetype)initWithFrame:(CGRect)frame solidStar:(NSInteger )number
{
    self = [super initWithFrame:frame];
    if (self) {
        _selfH = frame.size.height;
        _selfW = frame.size.width;
        
        [self addsolidStarToStarView:number];
    }
    
    return self;
}

- (void)addsolidStarToStarView:(NSInteger )number
{
    CGFloat spacing = (_selfW - (5 * _selfH)) * 0.25;
    
    NSLog(@"spacing = %ld",number);
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((_selfH + spacing) * i, 0, _selfH, _selfH)];
        if (i < number) {
            [image setImage:[UIImage imageNamed:@"IK_star_solid_yellow"]];
        }
        else{
            [image setImage:[UIImage imageNamed:@"IK_star_hollow_yellow"]];
        }
        [self addSubview:image];
    }
}

@end


@interface IKShowAppraiseVc ()

@property (nonatomic, strong)NSDictionary *dataDict;
@property (nonatomic, assign)CGFloat totalH;

@end

@implementation IKShowAppraiseVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavTitle];
    [self initLeftBackItem];
    
    // Do any additional setup after loading the view.
    
    [[IKNetworkManager shareInstance] getJobMyAppraiseDataWithSendResumeId:self.sendResumeId backData:^(NSDictionary *dict, BOOL success) {
        if (success) {
            NSLog(@"dict = %@",dict);
            self.dataDict = [NSDictionary dictionaryWithDictionary:dict];
            [self initAppraiseStarView];
            [self initTagsView];
            [self initAppraiseContent];
        }
    }];
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"我的评价";
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
    
    NSString *cNum = [NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"conform_num"]];
    NSString *eNum = [NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"env_num"]];
    NSString *iNum = [NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"interviewer_num"]];
    NSString *sNum = [NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"salary_num"]];

    
    NSArray *titleArray = @[@"面试官",@"职位相符",@"工作环境",@"薪资相符"];
    NSArray *numArray = @[iNum,cNum,eNum,sNum];
    NSLog(@"numArray = %@",numArray);
    CGFloat labelH = ceilf(height * 0.25);
    
    for (int i = 0; i < titleArray.count; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(22,i*labelH, 80, labelH)];
        label.text = [titleArray objectAtIndex:i];
        label.textColor = IKMainTitleColor;
        label.font = [UIFont systemFontOfSize:IKMainTitleFont];
        label.textAlignment = NSTextAlignmentLeft;
        [starBottomView addSubview:label];
        
        IKMyAppraiseStarView *starView = [[IKMyAppraiseStarView alloc] initWithFrame:CGRectMake(starBottomView.center.x - 50, label.center.y - 10, ceil(IKSCREEN_WIDTH * 0.4), 20) solidStar:[[numArray objectAtIndex:i] integerValue]];
        
        starView.tag = i + 100;
        [starBottomView addSubview:starView];
    }
    
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(20,100 + height, IKSCREEN_WIDTH - 40, 1)];
    linView.backgroundColor = IKLineColor;
    [self.view addSubview:linView];
    
    _totalH = linView.frame.origin.y + 1;
}


- (void)initTagsView
{
    
    UIView *tagsBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _totalH + 20, IKSCREEN_WIDTH, 90)];
    //    tagsBottomView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:tagsBottomView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0, 100, 25)];
    titleLabel.text = @"面试标签";
    titleLabel.textColor = IKMainTitleColor;
    titleLabel.font = [UIFont systemFontOfSize:IKMainTitleFont];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [tagsBottomView addSubview:titleLabel];
    
    CGFloat fontSize = 0;
    if (iPhone5SE) {
        fontSize = 12.0f;
    }
    else{
        fontSize = 13.0f;
    }
    
    NSString *tagsStr = [NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"tag_str"]];
    NSArray *tagsArray = [tagsStr componentsSeparatedByString:@","];
    
    CGFloat x = 0;
    
    for (int i = 0; i < tagsArray.count; i ++) {
        NSString *string = [tagsArray objectAtIndex:i];
        CGSize size = [NSString getSizeWithString:string size:CGSizeMake(MAXFLOAT, 25) attribute:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}];
        //
        UILabel *tag = [[UILabel alloc] initWithFrame:CGRectMake(20 + x, 40, size.width + 20, 25)];
        x = x + 40 + size.width;
        
        tag.text = string;
        tag.textColor = [UIColor whiteColor];
        tag.font = [UIFont systemFontOfSize:fontSize];
        tag.textAlignment = NSTextAlignmentCenter;
        tag.backgroundColor = IKGeneralBlue;
        tag.layer.cornerRadius = 12.5;
        tag.layer.masksToBounds = YES;
        //    psLabel.backgroundColor = [UIColor yellowColor];
        [tagsBottomView addSubview:tag];
    }

    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(20, _totalH + 110, IKSCREEN_WIDTH - 40, 1)];
    linView.backgroundColor = IKLineColor;
    [self.view addSubview:linView];
    
    _totalH = linView.frame.origin.y + 1;
}


- (void)initAppraiseContent
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,_totalH + 20, 80, 25)];
    titleLabel.text = @"评价内容";
    titleLabel.textColor = IKMainTitleColor;
    titleLabel.font = [UIFont systemFontOfSize:IKMainTitleFont];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    //    titleLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:titleLabel];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    
    NSString *content = [NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"content"]];
    IKLabel *contentLabel = [[IKLabel alloc] initWithFrame:CGRectMake(20,_totalH + 55, IKSCREEN_WIDTH - 40, 100)];
    contentLabel.attributedText = [[NSAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:IKSubTitleFont],NSParagraphStyleAttributeName:style}];
    contentLabel.textColor = IKMainTitleColor;
    contentLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.numberOfLines = 0;
    contentLabel.verticalAlignment = IKVerticalAlignmentTop;
    [self.view addSubview:contentLabel];
    
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
