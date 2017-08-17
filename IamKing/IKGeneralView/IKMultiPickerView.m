//
//  IKMultiPickerView.m
//  IamKing
//
//  Created by Luris on 2017/8/17.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKMultiPickerView.h"


#define IKMultiPickerHeaderHeight (44)

#define IKMultiPickerViewHeight (200)

@interface IKMultiPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView  *pickerView;
// 弹出视图
@property (nonatomic, strong) UIView        *alertView;
@property (nonatomic, copy) MultiResultBlock     resultBlock;
@property (nonatomic, copy)NSArray    *source2;
@property (nonatomic, copy)NSArray    *source3;
@property (nonatomic, assign)NSInteger oneSelectedRow;
@property (nonatomic, assign)NSInteger twoSelectedRow;

@end


@implementation IKMultiPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.oneSelectedRow = 0;
        self.twoSelectedRow = 0;
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
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, IKMultiPickerHeaderHeight + 0.5, CGRectGetWidth(self.frame), IKMultiPickerViewHeight)];
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
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - IKMultiPickerViewHeight - IKMultiPickerHeaderHeight, CGRectGetWidth(self.frame), IKMultiPickerViewHeight + IKMultiPickerHeaderHeight)];
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
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, IKMultiPickerHeaderHeight - 1, CGRectGetWidth(_alertView.frame), 1)];
        line.backgroundColor = IKLineColor;
        [_alertView addSubview:line];
        
        [_alertView addSubview:self.pickerView];
    }
    return _alertView;
}


- (void)cancelButtonClick:(UIButton *)button
{
    [self hide];
}


- (void)confirmButtonClick:(UIButton *)button
{
    [self hide];
    
    NSInteger index =  [_pickerView selectedRowInComponent:self.numberOfComponents - 1];
    
    NSString *selectedStr = nil;
    if (self.numberOfComponents == 2) {
        selectedStr = self.source2[index];
    }
    else if (self.numberOfComponents == 3){
        selectedStr = self.source3[index];
    }
    
    if (self.numberOfComponents == 2) {
        self.twoSelectedRow = index;
        index = 0;
    }
    
    if (_resultBlock) {
        _resultBlock([selectedStr copy],self.oneSelectedRow,self.twoSelectedRow,index);
    }
}

- (void)setDataSource2:(NSArray *)dataSource2
{
    if (IKArrayIsNotEmpty(dataSource2)) {
        _dataSource2 = dataSource2;
        self.source2 = [NSArray arrayWithArray:dataSource2.firstObject];
    }
}

- (void)setDataSource3:(NSArray *)dataSource3
{
    if (IKArrayIsNotEmpty(dataSource3)) {
        _dataSource3 = dataSource3;
        
        self.source3 = [NSArray arrayWithArray:((NSArray *)dataSource3.firstObject).firstObject];
    }
}


- (void)getSource2Data:(NSInteger )index
{
    self.source2  = nil;
    self.source2 = [NSArray arrayWithArray:self.dataSource2[index]];
}

- (void)getSource3Data;
{
    self.source3 = nil;
    NSArray *temp = (NSArray *)[self.dataSource3 objectAtIndex:self.oneSelectedRow];
    self.source3 = [NSArray arrayWithArray:temp[self.twoSelectedRow]];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.numberOfComponents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.dataSource.count;
    }
    else if (component == 1){
        return self.source2.count;
    }
    else{
        return self.source3.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{

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
    if (component == 0) {
        return self.dataSource[row];
    }
    else if (component == 1){
        return self.source2[row];
    }
    else{
        return self.source3[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0 && self.numberOfComponents>1) {
        self.oneSelectedRow = row;
        [self getSource2Data:row];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];

        if (self.numberOfComponents > 2) {
            self.twoSelectedRow = 0;
            [self getSource3Data];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }
    else if(self.numberOfComponents > 2) {
        if (component == 1){
            self.twoSelectedRow = row;
            [self getSource3Data];
            [pickerView reloadComponent:2];
        }
    }
}



- (void)showWithSelectedResultBlock:(MultiResultBlock)resultBlock
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
        rect.origin.y -= IKMultiPickerHeaderHeight + IKMultiPickerViewHeight;
        self.alertView.frame = rect;
    }];
}


- (void)hide
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += IKMultiPickerHeaderHeight + IKMultiPickerViewHeight;
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
    if ([touches.anyObject.view isKindOfClass:[IKMultiPickerView class]]) {
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
