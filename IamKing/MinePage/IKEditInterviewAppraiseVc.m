//
//  IKEditInterviewAppraiseVc.m
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKEditInterviewAppraiseVc.h"
#import "IKTextField.h"



@protocol IKAppraiseStarViewDelegate <NSObject>

- (void)starViewHadSelected:(NSInteger )selectedIndex viewTag:(NSInteger )viewTag;

@end


@interface IKAppraiseStarView : UIView

@property(nonatomic,assign)CGFloat selfH;
@property(nonatomic,assign)CGFloat selfW;

@property(nonatomic,assign)CGFloat selectedNum;
@property(nonatomic,strong)NSMutableArray *buttonArray;
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




@interface IKEditInterviewAppraiseVc ()<IKAppraiseStarViewDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, assign)CGFloat totalH;
@property (nonatomic, strong)UIView *tagsBottomView;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)UITextView *textView;

@property (nonatomic, strong)IKTextField *tagsTf;
@property (nonatomic, strong)UILabel *tag1;
@property (nonatomic, strong)UILabel *tag2;
@property (nonatomic, strong)UILabel *tag3;
@property (nonatomic, strong)UILabel *leftL;
@property (nonatomic, strong)UIButton *delete;

@property (nonatomic, strong)UILabel *textNumber;

@end

@implementation IKEditInterviewAppraiseVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavTitle];
    [self initLeftBackItem];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:self.view.bounds];
    bottomView.userInteractionEnabled = YES;
    [self.view insertSubview:bottomView belowSubview:self.navigationView];
    self.bottomView = bottomView;
    
    [self initAppraiseStarView];
    [self initTagsView];
    [self initAppraiseTextView];
    [self initBottomButton];
    
    // Do any additional setup after loading the view.
    [IKNotificationCenter addObserver:self selector:@selector(interviewVcKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [IKNotificationCenter addObserver:self selector:@selector(interviewVcKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc
{
    [IKNotificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [IKNotificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
    [self.bottomView addSubview:starBottomView];
    
    
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

    CGFloat y = 0;
    if (iPhone5SE) {
        y = 95;
    }
    else{
        y = 100;
    }
    
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(20, y + height, IKSCREEN_WIDTH - 40, 1)];
    linView.backgroundColor = IKLineColor;
    [self.bottomView addSubview:linView];
    
    _totalH = linView.frame.origin.y + 1;
}


- (void)starViewHadSelected:(NSInteger)selectedIndex viewTag:(NSInteger)viewTag
{
    
}



- (void)initTagsView
{
    CGFloat height = ceil(IKSCREENH_HEIGHT * 0.188);
    
    CGFloat vspace = 0;
    if (iPhone5SE) {
        vspace = 15;
    }
    else{
        vspace = 20;
    }
    
    UIView *tagsBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _totalH + vspace, IKSCREEN_WIDTH, height)];
//    tagsBottomView.backgroundColor = [UIColor cyanColor];
    [self.bottomView addSubview:tagsBottomView];
    
    self.tagsBottomView = tagsBottomView;
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0, 55, 25)];
    titleLabel.text = @"贴标签";
    titleLabel.textColor = IKMainTitleColor;
    titleLabel.font = [UIFont systemFontOfSize:IKMainTitleFont];
    titleLabel.textAlignment = NSTextAlignmentLeft;
//    titleLabel.backgroundColor = [UIColor redColor];
    [tagsBottomView addSubview:titleLabel];
    
    UILabel *psLabel = [[UILabel alloc] initWithFrame:CGRectMake(75,3, 120, 20)];
    psLabel.text = @"(最多可贴3个标签)";
    psLabel.textColor = IKSubHeadTitleColor;
    psLabel.font = [UIFont systemFontOfSize:IKSubTitleFont];
    psLabel.textAlignment = NSTextAlignmentLeft;
//    psLabel.backgroundColor = [UIColor yellowColor];
    [tagsBottomView addSubview:psLabel];

    
    //IK_delete_gray
    
    UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
    delete.frame = CGRectMake(IKSCREEN_WIDTH - 40, 0, 22, 22);
    [delete setBackgroundImage:[UIImage imageNamed:@"IK_delete_gray"] forState:UIControlStateNormal];
    [delete setBackgroundImage:[UIImage getImageApplyingAlpha:0.7 imageName:@"IK_delete_gray"] forState:UIControlStateHighlighted];
    [delete addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    delete.hidden = YES;
//    delete.backgroundColor = [UIColor redColor];
    [tagsBottomView addSubview:delete];
    
    self.delete = delete;
    
    
    CGFloat fontSize = 0;
    if (iPhone5SE) {
        fontSize = 12.0f;
    }
    else{
        fontSize = 13.0f;
    }
    
    UILabel *tag1 = [[UILabel alloc] init];
//    tag1.text = @"最多六个字啊";
    tag1.textColor = IKGeneralBlue;
    tag1.font = [UIFont systemFontOfSize:fontSize];
    tag1.textAlignment = NSTextAlignmentCenter;
    tag1.layer.borderColor = IKGeneralBlue.CGColor;
    tag1.layer.borderWidth = 1.0f;
    tag1.hidden = YES;
    //    psLabel.backgroundColor = [UIColor yellowColor];
    [tagsBottomView addSubview:tag1];
    
    self.tag1 = tag1;
    
    UILabel *tag2 = [[UILabel alloc] init];
//    tag2.text = @"最多六个字啊";
    tag2.textColor = IKGeneralBlue;
    tag2.font = [UIFont systemFontOfSize:fontSize];
    tag2.textAlignment = NSTextAlignmentCenter;
    tag2.layer.borderColor = IKGeneralBlue.CGColor;
    tag2.layer.borderWidth = 1.0f;
    tag2.hidden = YES;
    //    psLabel.backgroundColor = [UIColor yellowColor];
    [tagsBottomView addSubview:tag2];
    
    self.tag2 = tag2;
    
    
    UILabel *tag3 = [[UILabel alloc] init];
//    tag3.text = @"最多六个字啊";
    tag3.textColor = IKGeneralBlue;
    tag3.font = [UIFont systemFontOfSize:fontSize];
    tag3.textAlignment = NSTextAlignmentCenter;
    tag3.layer.borderColor = IKGeneralBlue.CGColor;
    tag3.layer.borderWidth = 1.0f;
    tag3.hidden = YES;
    //    psLabel.backgroundColor = [UIColor yellowColor];
    [tagsBottomView addSubview:tag3];
    
    self.tag3 = tag3;
    
    IKTextField *tagTf = [[IKTextField alloc] initWithFrame:CGRectMake(20, iPhone5SE?60:70, ceil(IKSCREEN_WIDTH*0.64), 45)];
    tagTf.placeholder = @" 请输入标签";
//    tagTf.secureTextEntry = YES;
    tagTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tagTf.returnKeyType = UIReturnKeyDone;
    tagTf.delegate = self;
    tagTf.textColor = IKMainTitleColor;
    tagTf.backgroundColor = IKGeneralLightGray;
    tagTf.layer.cornerRadius = 6;
    [tagTf addTarget:self action:@selector(textFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 30, 25)];
    leftLabel.text = @"0/6";
    leftLabel.textColor = IKSubHeadTitleColor;
    leftLabel.font = [UIFont systemFontOfSize:13.0f];
    leftLabel.textAlignment = NSTextAlignmentLeft;
//    leftLabel.backgroundColor = IKGeneralBlue;
    tagTf.rightViewMode = UITextFieldViewModeAlways;
    tagTf.rightView = leftLabel;
    [tagsBottomView addSubview:tagTf];
    
    self.leftL = leftLabel;
    self.tagsTf = tagTf;
    
    UIButton *affix = [UIButton buttonWithType:UIButtonTypeCustom];
    affix.frame = CGRectMake(25 + tagTf.frame.size.width, tagTf.frame.origin.y + 1, IKSCREEN_WIDTH - 25 -tagTf.frame.size.width - 20, 43);
    [affix setTitle:@"贴上" forState:UIControlStateNormal];
    [affix setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [affix setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
    affix.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [affix setBackgroundImage:IKButtonBlueBgImgae forState:UIControlStateNormal];
    [affix setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
    affix.layer.cornerRadius = 6;
    affix.layer.masksToBounds = YES;
    [affix addTarget:self action:@selector(affixButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagsBottomView addSubview:affix];
    
    
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(20, _totalH + 25 + height, IKSCREEN_WIDTH - 40, 1)];
    linView.backgroundColor = IKLineColor;
    [self.bottomView addSubview:linView];
    
    _totalH = linView.frame.origin.y + 1;
}


- (void)addTagsLabelWithSting:(NSString *)string
{
    CGFloat hspace = 0;
    CGFloat vspace = 0;

    CGFloat fontSize = 0;
    CGFloat tagH = 0;
    if (iPhone5SE) {
        hspace = 10;
        vspace = 30;
        tagH = 20;
        fontSize = 12.0f;
    }
    else{
        hspace = 15;
        tagH = 25;
        vspace = 35;
        fontSize = 13.0f;
    }
    
    CGSize size = [NSString getSizeWithString:string size:CGSizeMake(MAXFLOAT, tagH) attribute:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}];
    
    if (self.tag1.hidden) {
        self.tag1.hidden = NO;
        self.tag1.text = string;
        self.tag1.frame = CGRectMake(20, vspace, size.width + 20, tagH);
        self.tag1.layer.cornerRadius = tagH *0.5;

        self.tag1.transform = CGAffineTransformMakeScale(0.1, 1);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.tag1.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.delete.hidden = NO;
        }];
    }
    else if (self.tag2.hidden){
        self.tag2.hidden = NO;
        self.tag2.text = string;
        self.tag2.frame = CGRectMake(20 + self.tag1.frame.size.width + hspace, vspace, size.width + 20, tagH);
        self.tag2.layer.cornerRadius = tagH *0.5;

        self.tag2.transform = CGAffineTransformMakeScale(0.1, 1);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.tag2.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
    else if (self.tag3.hidden){
        self.tag3.hidden = NO;
        self.tag3.text = string;
        self.tag3.frame = CGRectMake(self.tag2.frame.origin.x + self.tag2.frame.size.width + hspace, vspace, size.width + 20, tagH);
        self.tag3.layer.cornerRadius = tagH *0.5;

        self.tag3.transform = CGAffineTransformMakeScale(0.1, 1);
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.tag3.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        [LRToastView showTosatWithText:@"只能贴三个标签噢" inView:self.view];
    }
    
}

- (void)deleteButtonClick:(UIButton *)button
{
    if (!self.tag3.hidden) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.tag3.transform = CGAffineTransformMakeScale(0.1, 1);
        } completion:^(BOOL finished) {
            self.tag3.hidden = YES;
            self.tag3.text = @"";
            self.tag3.frame = CGRectZero;
            self.tag3.transform = CGAffineTransformIdentity;
        }];
    }
    else if (!self.tag2.hidden){
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.tag2.transform = CGAffineTransformMakeScale(0.1, 1);
        } completion:^(BOOL finished) {
            self.tag2.hidden = YES;
            self.tag2.text = @"";
            self.tag2.frame = CGRectZero;
            self.tag2.transform = CGAffineTransformIdentity;
        }];
    }
    else if (!self.tag1.hidden){
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.tag1.transform = CGAffineTransformMakeScale(0.1, 1);
        } completion:^(BOOL finished) {
            self.tag1.hidden = YES;
            self.tag1.text = @"";
            self.tag1.frame = CGRectZero;
            self.tag1.transform = CGAffineTransformIdentity;
            self.delete.hidden = YES;
        }];
    }
}

- (void)affixButtonClick:(UIButton *)button
{
    [self addTagsLabelWithSting:self.tagsTf.text];
    self.tagsTf.text = @"";
    self.leftL.text = @"0/6";
    [self.tagsTf resignFirstResponder];
}

- (void)textFieldTextDidChange:(IKTextField *)textField
{
    NSLog(@"textFieldTextDidChange = %@",textField.text);
    
    NSInteger length = textField.text.length;
    if (length > 6) {
        textField.text = [textField.text substringToIndex:6];
        self.leftL.text = @"6/6";
    }
    else{
        self.leftL.text = [NSString stringWithFormat:@"%ld/6",length];
    }
}


- (void)initAppraiseTextView
{
    CGFloat h = iPhone5SE?10:20;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,_totalH + h, 80, 25)];
    titleLabel.text = @"说点什么";
    titleLabel.textColor = IKMainTitleColor;
    titleLabel.font = [UIFont systemFontOfSize:IKMainTitleFont];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    //    titleLabel.backgroundColor = [UIColor redColor];
    [self.bottomView addSubview:titleLabel];
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, _totalH + h + 30, IKSCREEN_WIDTH - 40, IKSCREENH_HEIGHT - _totalH - h - (iPhone5SE?80:100))];
    textView.backgroundColor = IKGeneralLightGray;
    textView.layer.cornerRadius = 6;
    textView.textColor = IKMainTitleColor;
    textView.delegate = self;
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 10);
    textView.contentInset = UIEdgeInsetsMake(0, 0, 25, 0);
    
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"说点什么...";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [textView addSubview:placeHolderLabel];
    // same font
    textView.font = [UIFont systemFontOfSize:13.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:13.f];
    [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    [self.bottomView addSubview:textView];
    
    self.textView = textView;
   
    UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(textView.frame.size.width - 70 ,textView.frame.size.height - 25, 60, 25)];
    number.text = @"0/100";
    number.textColor = IKSubHeadTitleColor;
    number.font = [UIFont systemFontOfSize:12.0f];
    number.textAlignment = NSTextAlignmentRight;
    //    titleLabel.backgroundColor = [UIColor redColor];
    [textView addSubview:number];
    
    self.textNumber = number;
}


- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger length = textView.text.length;
    if (length > 100) {
        textView.text = [textView.text substringToIndex:100];
        self.textNumber.text = @"100/100";
    }
    else{
        self.textNumber.text = [NSString stringWithFormat:@"%ld/100",length];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"text = %@",text);
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}



- (void)initBottomButton
{
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(20, IKSCREENH_HEIGHT - (iPhone5SE?45:50), 110, 40);
    [cancel addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
    [cancel setTitleColor:IKButtonClickColor forState:UIControlStateHighlighted];
    cancel.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    cancel.layer.cornerRadius = 6;
    cancel.layer.masksToBounds = YES;
    cancel.layer.borderColor = IKGeneralBlue.CGColor;
    cancel.layer.borderWidth = 1.0f;
    
    [self.view insertSubview:cancel aboveSubview:self.bottomView];
    
    
    UIButton *commit = [UIButton buttonWithType:UIButtonTypeCustom];
    commit.frame = CGRectMake(150, cancel.frame.origin.y, IKSCREEN_WIDTH - 170, 40);
    [commit addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [commit setTitle:@"确定" forState:UIControlStateNormal];
    [commit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commit.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    commit.layer.cornerRadius = 6;
    commit.layer.masksToBounds = YES;
    commit.backgroundColor = IKGeneralBlue;
    [commit setBackgroundImage:IKButtonCkickBlueImage forState:UIControlStateHighlighted];
    
    [self.view insertSubview:commit aboveSubview:self.bottomView];
}

- (void)commitButtonClick:(UIButton *)button
{
    [[IKNetworkManager shareInstance] postJobAppraiseDataToServer:nil callback:^(BOOL success, NSString *errorMessage) {
        [LRToastView showTosatWithText:@"感谢您的评价" inView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self backButtonClick:nil];
        });
    }];
}

- (void)interviewVcKeyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = keyboardRect.origin.y;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSLog(@"yyyyy = %.0f  === %.0f ",y,_bottomView.center.y);
    
    if (self.tagsTf.isFirstResponder) {
        if ((y-_bottomView.center.y) < 100) {
            [UIView animateWithDuration:duration.doubleValue animations:^{
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationCurve:[curve intValue]];
                _bottomView.center = CGPointMake(_bottomView.center.x, _bottomView.center.y - 80);
            }];
        }
    }
    else{
        [UIView animateWithDuration:duration.doubleValue animations:^{
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:[curve intValue]];
            _bottomView.center = CGPointMake(_bottomView.center.x, _bottomView.center.y - (iPhone5SE?(y-100):(y *0.6)));
        }];
    }
}


- (void)interviewVcKeyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        _bottomView.center = self.view.center;
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.tagsTf.isFirstResponder) {
        [self.tagsTf resignFirstResponder];
    }
    
    if (self.textView.isFirstResponder) {
        [self.textView resignFirstResponder];
    }
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
