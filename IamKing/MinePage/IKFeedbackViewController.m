//
//  IKFeedbackViewController.m
//  IamKing
//
//  Created by Luris on 2017/8/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKFeedbackViewController.h"

@interface IKFeedbackViewController ()

@property (nonatomic,strong)UITextView  *textView;
@property (nonatomic,strong)UIView      *bottomView;
@property (nonatomic,assign)CGPoint      oldBottomViewCenter;


@end

@implementation IKFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavTitle];
    [self initLeftBackItem];
    
    [self iniTopView];
    [self initBottomView];
    
    [IKNotificationCenter addObserver:self selector:@selector(feedbackVcKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [IKNotificationCenter addObserver:self selector:@selector(feedbackVcKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)initNavTitle
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    //    title.backgroundColor = [UIColor redColor];
    title.text = @"意见反馈";
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


- (void)iniTopView
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 70, IKSCREEN_WIDTH, IKSCREENH_HEIGHT - 175)];
    
//    view.backgroundColor = [UIColor cyanColor];
    [self.view insertSubview:view belowSubview:self.navigationView];
    
    self.oldBottomViewCenter = view.center;
    self.bottomView = view;
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    UIImage *image2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IK_Feedback_blue" ofType:@"png"]];
//    topImageView.userInteractionEnabled = YES;
    [topImageView setImage:image2];
    [view addSubview:topImageView];
    
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(30);
        make.centerX.equalTo(view.mas_centerX);
        make.height.and.width.mas_equalTo(50);
    }];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 60)];
    descLabel.text = @"如果您对我们的产品体验、功能有所建议或者是发现了问题，尽可畅所欲言。感谢万分！";
    descLabel.textColor = IKGeneralBlue;
    descLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.numberOfLines = 0;
    [view addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).offset(5);
        make.centerX.equalTo(view.mas_centerX);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(60);
    }];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 250)];
    textView.backgroundColor = IKGeneralLightGray;
    textView.layer.cornerRadius = 6;
    
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请在这里输入...";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [textView addSubview:placeHolderLabel];
    // same font
    textView.font = [UIFont systemFontOfSize:13.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:13.f];
    [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];

    [view addSubview:textView];
    
    self.textView = textView;
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descLabel.mas_bottom).offset(10);
        make.left.equalTo(view.mas_left).offset(20);
        make.right.equalTo(view.mas_right).offset(-20);
        make.height.equalTo(view).multipliedBy(0.375);
    }];
    
    UIButton *commit = [UIButton buttonWithType:UIButtonTypeCustom];
    [commit addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [commit setTitle:@"提交" forState:UIControlStateNormal];
    [commit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commit.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    commit.layer.cornerRadius = 6;
    commit.layer.masksToBounds = YES;
    commit.backgroundColor = IKGeneralBlue;
    [commit setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
    
    [view addSubview:commit];
    
    [commit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView.mas_bottom).offset(10);
        make.left.equalTo(view.mas_left).offset(20);
        make.right.equalTo(view.mas_right).offset(-20);
        make.height.mas_equalTo(40);
    }];
    
}


- (void)initBottomView
{
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    UIImage *image2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IK_thankyou" ofType:@"png"]];
    [topImageView setImage:image2];
    [self.view addSubview:topImageView];
    
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(82.5);
        make.width.mas_equalTo(157.5);
    }];
    
}


- (void)okView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x - 40, self.view.center.y - 100, 80, 100)];
//    view.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:view];
    
    UIImageView *okImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 40, 40)];
    UIImage *okImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IK_feedback_ok" ofType:@"png"]];
    //    topImageView.userInteractionEnabled = YES;
    [okImageView setImage:okImage];
    [view addSubview:okImageView];
    
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 80, 40)];
    descLabel.text = @"已提交";
    descLabel.textColor = IKGeneralBlue;
    descLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.numberOfLines = 0;
    [view addSubview:descLabel];
}


- (void)commitButtonClick:(UIButton *)button
{
    [self.textView resignFirstResponder];
        
    if (self.textView.text.length > 0) {
        
        [[IKNetworkManager shareInstance] postFeedbackDataToServer:@{@"userId":@"294",@"content":self.textView.text} callback:^(BOOL success, NSString *errorMessage) {
            if (success) {
                [self.bottomView removeFromSuperview];
                [self okView];
            }
            else{
                [LRToastView showTosatWithText:@"提交失败,请稍后尝试" inView:self.view];
            }
        }];
    }
    
    


}



#pragma - mark KeyboardNotification
- (void)feedbackVcKeyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = keyboardRect.origin.y;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSLog(@"yyyyy = %.0f  === %.0f ",y,_bottomView.center.y);
    
    if ((y-_bottomView.center.y) < 100) {
        [UIView animateWithDuration:duration.doubleValue animations:^{
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:[curve intValue]];
            _bottomView.center = CGPointMake(_bottomView.center.x, _bottomView.center.y - 80);
        }];
    }
}


- (void)feedbackVcKeyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        _bottomView.center = self.oldBottomViewCenter;
    }];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"vvvvvv = %@",touches.anyObject.view);
    [self.textView resignFirstResponder];
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
