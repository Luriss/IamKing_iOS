//
//  IKPickerView.m
//  IamKing
//
//  Created by Luris on 2017/8/16.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKPickerView.h"

#define IKPickerHeaderHeight (44)

#define IKPickerViewHeight (200)

@interface IKPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView  *pickerView;
// 弹出视图
@property (nonatomic, strong) UIView        *alertView;
@property (nonatomic, copy) ResultBlock     resultBlock;
@property (nonatomic, copy) NSString        *selectedStr;


@end


@implementation IKPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self initUI];
    }
    return self;
}


- (void)initUI
{
    [self addSubview:self.alertView];
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, IKPickerHeaderHeight + 0.5, CGRectGetWidth(self.frame), IKPickerViewHeight)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

#pragma mark - 弹出视图
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - IKPickerViewHeight - IKPickerHeaderHeight, CGRectGetWidth(self.frame), IKPickerViewHeight + IKPickerHeaderHeight)];
        _alertView.backgroundColor = [UIColor whiteColor];
        
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        cancel.frame = CGRectMake(20, 0, 50, 43);
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel setTitleColor:IKMainTitleColor forState:UIControlStateNormal];
        [cancel setTitleColor:[IKMainTitleColor colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
        cancel.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        cancel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [cancel addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:cancel];
        
        UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        confirm.frame = CGRectMake(CGRectGetWidth(_alertView.frame) - 70, 0, 50, 43);
        [confirm setTitle:@"确定" forState:UIControlStateNormal];
        [confirm setTitleColor: IKGeneralBlue forState:UIControlStateNormal];
        [confirm setTitleColor:[IKGeneralBlue colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
        confirm.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

        confirm.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [confirm addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:confirm];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, IKPickerHeaderHeight - 1, CGRectGetWidth(_alertView.frame), 1)];
        line.backgroundColor = IKLineColor;
        [_alertView addSubview:line];
        
        [_alertView addSubview:self.pickerView];
    }
    return _alertView;
}

- (void)setDefaultSelectedRow:(NSInteger)defaultSelectedRow
{
    [_pickerView selectRow:defaultSelectedRow inComponent:0 animated:NO];
    self.selectedStr = self.dataSource[defaultSelectedRow];
}

- (void)cancelButtonClick:(UIButton *)button
{
    [self hide];
}


- (void)confirmButtonClick:(UIButton *)button
{
    [self hide];
    
    if (_resultBlock) {
        _resultBlock([self.selectedStr copy]);
    }
}



#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return self.dataSource.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSLog(@"view = %@",view);
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:16.0f]];
    }
    
    // 设置文字
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    UIColor *color = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1];
    ((UIView *)[self.pickerView.subviews objectAtIndex:1]).backgroundColor = color;
    ((UIView *)[self.pickerView.subviews objectAtIndex:2]).backgroundColor = color;
    
    return pickerLabel;
}

#pragma mark - UIPickerViewDelegate
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@",self.dataSource[row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedStr = [self.dataSource objectAtIndex:row];
}



- (void)showWithSelectedResultBlock:(ResultBlock)resultBlock
{
    self.resultBlock = resultBlock;
    [self show];
}


- (void)show
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    // 动画前初始位置
    CGRect rect = self.alertView.frame;
    rect.origin.y = CGRectGetHeight(self.frame);
    self.alertView.frame = rect;
    
    // 浮现动画
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y -= IKPickerHeaderHeight + IKPickerViewHeight;
        self.alertView.frame = rect;
    }];
}


- (void)hide
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += IKPickerHeaderHeight + IKPickerViewHeight;
        self.alertView.frame = rect;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.pickerView removeFromSuperview];
        [self.alertView removeFromSuperview];
        [self removeFromSuperview];

        self.pickerView = nil;
        self.alertView = nil;
    }];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches.anyObject.view isKindOfClass:[IKPickerView class]]) {
        [self hide];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
