//
//  IKJobTypeView.m
//  IamKing
//
//  Created by Luris on 2017/7/14.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobTypeView.h"

@interface IKJobTypeView ()


@property (nonatomic, strong) UIButton  *button;
@property (nonatomic, strong) UIView     *bottomLine;
@property (nonatomic, strong) UIView     *lineView;

@property (nonatomic, assign)BOOL hadAddSubview;
@property (nonatomic, copy)NSMutableArray<__kindof UIButton *> *buttonArray;
@property (nonatomic, strong)UIButton *oldButton;

@end

@implementation IKJobTypeView

-(instancetype)init
{
    self = [super init];
    if (self) {
        _hadAddSubview = NO;
        [self addLine];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _hadAddSubview = NO;
        
        [self addLine];
    }
    return self;
}

- (void)addLine
{
    [self addSubview:self.lineView];
    __weak typeof (self) weakSelf = self;
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf);
        make.left.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(1);
    }];
}


- (void)addSubViews
{
    for (int i = 0; i < _buttonArray.count; i ++) {
        
        UIButton *job = [_buttonArray objectAtIndex:i];
        if (i == 0) {
            [job setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
            _oldButton = job;
        }
        [self addSubview:job];
    }
    
    [self addSubview:self.bottomLine];
    
    __weak typeof (self) weakSelf = self;

    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).offset(-12);
        make.centerX.equalTo(_oldButton);
        make.height.mas_equalTo(3);
        make.width.mas_equalTo(55);
    }];
}

-(void)setButtonSize:(CGSize)buttonSize
{
    _buttonSize = buttonSize;
}

- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = IKGeneralBlue;
    }
    return _bottomLine;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = IKGeneralLightGray;
    }
    return _lineView;
}


- (void)adjustBottomLine:(CGFloat )index
{
    
//    CGPoint point = CGPointMake(_oldButton.center.x + index, _oldButton.center.y);
    
    
    [self btnClick:[self.buttonArray objectAtIndex:(index)]];
}

- (void)btnClick:(UIButton *)button
{
    NSLog(@"%@",button);

    if (_oldButton != button) {
        
        
        [self startBottomLineAnimation:button.center];
        
        [button setTitleColor:IKGeneralBlue forState:UIControlStateNormal];
        [_oldButton setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
        
        if ([self.delegate respondsToSelector:@selector(jobTypeViewButtonClick:)]) {
            [self.delegate jobTypeViewButtonClick:button];
        }
    }
    
    _oldButton = button;
    
}




- (void)layoutSubviews
{
    
    [super layoutSubviews];
}


- (void)setTitleArray:(NSArray *)titleArray
{
    if (IKArrayIsNotEmpty(titleArray)) {
        _titleArray = titleArray;
        
        self.buttonSize = CGSizeMake(CGRectGetWidth(self.bounds)/(titleArray.count), CGRectGetHeight(self.bounds));

        [self addButtonWithDataArray];
        
        if (!_hadAddSubview) {
            [self addSubViews];
            _hadAddSubview = YES;
        }
    }
}


- (void)addButtonWithDataArray
{
    [self clearButtonArray];
    
    NSInteger index = 0;
    for (NSString *title in _titleArray) {
        
        index +=1;
        
        if (index > 4) {
            
            IKLog(@"title is over.");
            return ;
        }
        
        UIButton *button = [self createButtonWithTitle:title index:index];
        [self.buttonArray addObject:button];
    }
}


- (UIButton *)createButtonWithTitle:(NSString *)title index:(NSInteger )index
{
    UIButton *job = [UIButton buttonWithType:UIButtonTypeCustom];
    [job setTitleColor:IKSubHeadTitleColor forState:UIControlStateNormal];
    job.frame = CGRectMake((index -1)*_buttonSize.width, 0, _buttonSize.width, _buttonSize.height);
    job.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    [job addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [job setTitle:title forState:UIControlStateNormal];
    job.tag = 100 + index;
    return job;
}


- (void)setHadAddSubview:(BOOL)hadAddSubview
{
    _hadAddSubview = hadAddSubview;
}

- (NSMutableArray<UIButton *> *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}


- (void)clearButtonArray
{
    [_buttonArray removeAllObjects];
    _buttonArray = nil;
}


- (void)startBottomLineAnimation:(CGPoint )point
{
    NSLog(@"_oldButton.center = %@",[NSValue valueWithCGPoint:point]);
    NSLog(@"button.center = %@",[NSValue valueWithCGPoint:point]);

    CABasicAnimation* position = [CABasicAnimation animation];
    position.duration = 0.1;
    position.keyPath = @"position.x";
    position.fromValue = [NSValue valueWithCGPoint:_oldButton.center];
    position.toValue = [NSValue valueWithCGPoint:point];
    position.removedOnCompletion = NO;
    position.fillMode = kCAFillModeForwards;
    [_bottomLine.layer addAnimation:position forKey:nil];
}

//
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
