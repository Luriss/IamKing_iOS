//
//  LRPickerView.m
//  IamKing
//
//  Created by Luris on 2017/8/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "LRPickerView.h"


#define IKPickerHeaderHeight (44)

#define IKPickerViewHeight (200)

@interface LRPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView  *pickerView;
// 弹出视图
@property (nonatomic, strong) UIView        *alertView;
@property (nonatomic, copy) ResultBlock     resultBlock;
@property (nonatomic, copy) NSString        *selectedValue1;
@property (nonatomic, copy) NSString        *selectedValue2;
@property (nonatomic, strong)NSArray    *source1;
@property (nonatomic, strong)NSArray    *source2;


@end


@implementation LRPickerView

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

- (void)defaultSelectRow:(NSInteger)selectedRow inComponent:(NSInteger)component animated:(BOOL)animated
{
    [_pickerView selectRow:selectedRow inComponent:component animated:animated];
    
    if (self.dataSource.count == 2) {
        NSArray *array = (NSArray *)[self.dataSource objectAtIndex:component];
        if (component == 0) {
            self.selectedValue1 = [NSString stringWithFormat:@"%@",array[selectedRow]];
        }
        else{
            self.selectedValue2 = [NSString stringWithFormat:@"%@",array[selectedRow]];
        }
    }
    else{
        // 一列
        self.selectedValue1 = [NSString stringWithFormat:@"%@",self.dataSource[selectedRow]];
    }
    
}

- (void)cancelButtonClick:(UIButton *)button
{
    [self hide];
}


- (NSArray *)source1
{
    if (_source1 == nil) {
        _source1 = [NSArray array];
    }
    return _source1;
}


- (NSArray *)source2
{
    if (_source2 == nil) {
        _source2 = [NSArray array];
    }
    return _source2;
}

-(void)setDataSource:(NSArray *)dataSource
{
    if (IKArrayIsNotEmpty(dataSource)) {
        _dataSource = dataSource;
        
        if (dataSource.count == 2) {
            self.source1 = dataSource.firstObject;
            self.source2 = dataSource.lastObject;
        }
        else{
            self.source1 = dataSource;
        }
    }
}


- (void)confirmButtonClick:(UIButton *)button
{
    [self hide];
    
    if (IKStringIsEmpty(self.selectedValue1)) {
        self.selectedValue1 = [NSString stringWithFormat:@"%@",self.source1.firstObject];
    }
    if (IKStringIsEmpty(self.selectedValue2)) {
        self.selectedValue2 = [NSString stringWithFormat:@"%@",self.source2.firstObject];
    }
    
    if (_resultBlock) {
        _resultBlock([self.selectedValue1 copy],[self.selectedValue2 copy]);
    }
}



#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.dataSource.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.source1.count;
    }
    else if (component == 1){
        return self.source2.count;
    }
    return 0;
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
        return [NSString stringWithFormat:@"%@",self.source1[row]];
    }
    else if (component == 1){
        return [NSString stringWithFormat:@"%@",self.source2[row]];
    }
    else{
        return nil;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (self.dataSource.count == 2) {
        if (component == 0) {
            self.selectedValue1 = [NSString stringWithFormat:@"%@",self.source1[row]];
        }
        else{
            self.selectedValue2 = [NSString stringWithFormat:@"%@",self.source2[row]];
        }
        
        if ([self.selectedValue1 isEqualToString:@"至今"]) {
            self.source2 = @[];
            [pickerView reloadComponent:1];
        }
        else{
            self.source2 = self.dataSource.lastObject;
            [pickerView reloadComponent:1];
        }
    }
    else{
        // 一列
        self.selectedValue1 = [NSString stringWithFormat:@"%@",self.dataSource[row]];
    }
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
    if ([touches.anyObject.view isKindOfClass:[LRPickerView class]]) {
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
