//
//  IKIntroduceVc.m
//  IamKing
//
//  Created by Luris on 2017/8/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKIntroduceVc.h"

@interface IKIntroduceLabel : UILabel


@end

@implementation IKIntroduceLabel

- (void)drawTextInRect:(CGRect)rect
{
    CGRect newRect ;
    newRect.origin.x = rect.origin.x + 10;
    newRect.origin.y = rect.origin.x + 10;
    
    newRect.size.width = rect.size.width - 20;
    newRect.size.height = rect.size.height - 20;
    
    [super drawTextInRect:newRect];
}

@end


@interface IKIntroduceVc ()

@end

@implementation IKIntroduceVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationView.hidden = YES;
    
    [self backGroundView];

    [self initLeftBackItem];
    
    // Do any additional setup after loading the view.
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"我的设置";
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
    button.frame = CGRectMake(20, 20, 70, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 50);
    [button setImage:[UIImage imageNamed:@"IK_back_white"] forState:UIControlStateNormal];
    [button setImage:[UIImage getImageApplyingAlpha:IKDefaultAlpha imageName:@"IK_back_white"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:button];
}



- (void)backGroundView
{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
//    imageV.backgroundColor = [UIColor cyanColor];
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IK_kingBg" ofType:@"jpg"]];
    [imageV setImage:image];
    [self.view addSubview:imageV];

    
    UIImageView *logoImageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x - 100, 70, 200, 88)];
    
//    logoImageV.backgroundColor = [UIColor cyanColor];
    UIImage *logoImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IK_kingLogo" ofType:@"png"]];
    [logoImageV setImage:logoImage];
    
    [imageV addSubview:logoImageV];
    
    
    IKIntroduceLabel *label = [[IKIntroduceLabel alloc] initWithFrame:CGRectMake(20, 170, IKSCREEN_WIDTH - 40, IKSCREENH_HEIGHT - 190)];
    label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    label.layer.cornerRadius = 15;
    label.layer.masksToBounds = YES;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    [imageV addSubview:label];
    
    NSString *content = @"国王招聘-健身招聘求职神器，隶属于国王KING旗下专注于健身行业的垂直招聘求职平台。国王招聘帮助正处于高速发展的中国健身行业，在企业招人、从业者找工作上提供专业、高效、精准、便捷的需求匹配服务。\n\n 国王招聘基于行业人才大数据，通过智能匹配与算法技术，实现让健身企业更快更精准更有保障地搜索匹配到适合的专业人才；让健身从业者可以前所未有地在全国范围内，高效、便捷、精准地搜索挑选适合自身的工作及职业发展平台。\n\n 作为中国首家专注健身行业的专业招聘求职平台，国王招聘致力于通过互联网的技术与思维，结合健身行业的特点与痛点，加上持续优化的产品设计与用户体验，以及不断丰富与创新的产品功能，使健身行业人力资源得到高效匹配与优化配置，改善行业从业规则与职业道德，推动引领中国健身行业更好更快发展。\n\n 我们深知，优秀人才对于企业发展的重要性!!!";
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.tailIndent = -20;
    style.headIndent = 20;
    style.firstLineHeadIndent = 20;
    style.alignment = NSTextAlignmentLeft;//靠右显示
    style.lineSpacing = 5;

    CGFloat fontsize = 0.0f;
    
    if (iPhone6P_6sP) {
        fontsize = 14.0f;
    }
    else if (iPhone5SE){
        fontsize = 11.0f;
        style.tailIndent = -10;
        style.headIndent = 10;
        style.firstLineHeadIndent = 10;
        style.lineSpacing = 3;
    }
    else{
        fontsize = 12.0f;
    }
    
    
    label.attributedText = [[NSAttributedString alloc] initWithString:content attributes: @{NSFontAttributeName:[UIFont boldSystemFontOfSize:fontsize],NSParagraphStyleAttributeName:style}];
}




- (void)backButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
