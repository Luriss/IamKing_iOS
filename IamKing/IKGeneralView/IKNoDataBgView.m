//
//  IKNoDataBgView.m
//  IamKing
//
//  Created by Luris on 2017/7/25.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKNoDataBgView.h"

@interface IKNoDataBgView ()

@property(nonatomic,assign)CGFloat totalH;

@end


@implementation IKNoDataBgView

- (instancetype)init
{
    if (self = [super init]) {
        _totalH = 0;
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _totalH = 0;
        [self initBgView];
    }
    
    return self;
}



- (void)initBgView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 200, 40)];
    
    view.backgroundColor = IKGeneralLightGray;
    
    [self addSubview:view];
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 65, IKSCREEN_WIDTH*0.6, 20)];
    
    view1.backgroundColor = IKGeneralLightGray;
    
    [self addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(20, 90, IKSCREEN_WIDTH*0.9, 30)];
    
    view2.backgroundColor = IKGeneralLightGray;
    
    [self addSubview:view2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(20, 125, IKSCREEN_WIDTH*0.5, 20)];
    
    view3.backgroundColor = IKGeneralLightGray;
    
    [self addSubview:view3];

    _totalH = 160;
    
    [self addCellTypeBgView];
    
    [self addlineView];
}


- (void)addCellTypeBgView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, _totalH, 80, 80)];
    view.backgroundColor = IKGeneralLightGray;
    [self addSubview:view];
    
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(115, _totalH, IKSCREEN_WIDTH*0.5, 15)];
    view1.backgroundColor = IKGeneralLightGray;
    [self addSubview:view1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(115, _totalH + 20, IKSCREEN_WIDTH*0.5, 15)];
    view2.backgroundColor = IKGeneralLightGray;
    [self addSubview:view2];
    
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(115, _totalH + 40, IKSCREEN_WIDTH*0.5, 15)];
    view3.backgroundColor = IKGeneralLightGray;
    [self addSubview:view3];
    
    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(115, _totalH + 60, IKSCREEN_WIDTH*0.5, 15)];
    view4.backgroundColor = IKGeneralLightGray;
    [self addSubview:view4];
    
    _totalH += 95;
    
}


- (void)addlineView
{
    CGFloat h = IKSCREENH_HEIGHT * 0.0264;
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(20, _totalH, IKSCREEN_WIDTH*0.9, IKSCREENH_HEIGHT *0.053)];
    view1.backgroundColor = IKGeneralLightGray;
    [self addSubview:view1];
    _totalH += IKSCREENH_HEIGHT *0.053 ;
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(20, _totalH + 5, IKSCREEN_WIDTH*0.7, h)];
    view2.backgroundColor = IKGeneralLightGray;
    [self addSubview:view2];
    _totalH = CGRectGetMinY(view2.frame)+h;
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(20, _totalH + 5, IKSCREEN_WIDTH*0.7, h)];
    view3.backgroundColor = IKGeneralLightGray;
    [self addSubview:view3];
    _totalH = CGRectGetMinY(view3.frame)+h;

    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(20, _totalH + 5, IKSCREEN_WIDTH*0.7, h)];
    view4.backgroundColor = IKGeneralLightGray;
    [self addSubview:view4];
    _totalH = CGRectGetMinY(view4.frame)+h;

    
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(20, _totalH + 5, IKSCREEN_WIDTH*0.7, h)];
    view5.backgroundColor = IKGeneralLightGray;
    [self addSubview:view5];
    _totalH = CGRectGetMinY(view5.frame)+h;

    
    UIView *view6 = [[UIView alloc]initWithFrame:CGRectMake(20, _totalH + 20, IKSCREEN_WIDTH*0.9, IKSCREENH_HEIGHT *0.053)];
    view6.backgroundColor = IKGeneralLightGray;
    [self addSubview:view6];
    _totalH = CGRectGetMinY(view6.frame)+ (IKSCREENH_HEIGHT *0.053);

    
    UIView *view7 = [[UIView alloc]initWithFrame:CGRectMake(20, _totalH + 5, IKSCREEN_WIDTH*0.7, h)];
    view7.backgroundColor = IKGeneralLightGray;
    [self addSubview:view7];
    _totalH = CGRectGetMinY(view7.frame)+h;

    
    UIView *view8 = [[UIView alloc]initWithFrame:CGRectMake(20, _totalH + 5, IKSCREEN_WIDTH*0.7, h)];
    view8.backgroundColor = IKGeneralLightGray;
    [self addSubview:view8];
    _totalH = CGRectGetMinY(view8.frame)+h;

    
    UIView *view9 = [[UIView alloc]initWithFrame:CGRectMake(20, _totalH + 5, IKSCREEN_WIDTH*0.7, h)];
    view9.backgroundColor = IKGeneralLightGray;
    [self addSubview:view9];
    _totalH = CGRectGetMinY(view9.frame)+h;

    UIView *view10 = [[UIView alloc]initWithFrame:CGRectMake(20, _totalH + 5, IKSCREEN_WIDTH*0.7, h)];
    view10.backgroundColor = IKGeneralLightGray;
    [self addSubview:view10];
    _totalH = CGRectGetMinY(view10.frame)+h;

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
