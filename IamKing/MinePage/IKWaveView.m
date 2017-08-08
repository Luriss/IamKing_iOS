//
//  IKWaveView.m
//  IamKing
//
//  Created by Luris on 2017/8/7.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKWaveView.h"


@interface IKWaveView ()

@property (nonatomic, strong)CAShapeLayer *waveShapeLayer1;
@property (nonatomic, strong)CAShapeLayer *waveShapeLayer2;
@property (nonatomic, strong)CADisplayLink *waveDisplayLink;

/**
 *  波纹的振幅   amplitude （振幅）
 */
@property (nonatomic, assign) CGFloat waveAmplitude;

/**
 *  波纹的传播周期  单位s    period (周期)
 */
@property (nonatomic, assign) CGFloat wavePeriod;

/**
 *  波纹的长度
 */
@property (nonatomic, assign) CGFloat waveWidth;

@property (nonatomic, assign) CGFloat waveHeight;


/** 偏移量 */
@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, assign) CGFloat offsetX2;

@end

@implementation IKWaveView

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        
        [self addWave];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.waveWidth = frame.size.width;
        self.waveHeight = 30;
        self.wavePeriod = 2;
        self.waveAmplitude = 3.0;
        [self addWave];
    }
    return self;
}

- (void)addWave
{
    /*
     *创建两个layer
     */
    self.waveShapeLayer1 = [CAShapeLayer layer];
    self.waveShapeLayer1.fillColor = IKGeneralBlue.CGColor;
    [self.layer addSublayer:self.waveShapeLayer1];
    
    self.waveShapeLayer2 = [CAShapeLayer layer];
    self.waveShapeLayer2.fillColor = IKButtonClickColor.CGColor;
    [self.layer addSublayer:self.waveShapeLayer2];
    /*
     *CADisplayLink是一个能让我们以和屏幕刷新率相同的频率将内容画到屏幕上的定时器。我们在应用中创建一个新的 CADisplayLink 对象，把它添加到一个runloop中，并给它提供一个 target 和selector 在屏幕刷新的时候调用。
     */
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}


//CADispayLink相当于一个定时器 会一直绘制曲线波纹 看似在运动，其实是一直在绘画不同位置点的余弦函数曲线
- (void)getCurrentWave {
    //offsetX决定x位置，如果想搞明白可以多试几次
    self.offsetX += (IKSCREEN_WIDTH / 60 / self.wavePeriod);
    //声明第一条波曲线的路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始点
    CGPathMoveToPoint(path, nil, 0, self.frame.size.height);
    
    CGFloat y = 0.0f;
    //第一个波纹的公式
    for (float x = 0.f; x <= self.waveWidth ; x++) {
        y = self.waveAmplitude * sin((300 / self.waveWidth) * (x * M_PI / 180) - self.offsetX * M_PI / 270) + self.waveHeight*1;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    //把绘图信息添加到路径里
    CGPathAddLineToPoint(path, nil, self.waveWidth, self.frame.size.height);
//    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    //结束绘图信息
    CGPathCloseSubpath(path);
    
    self.waveShapeLayer1.path = path;
    //释放绘图路径
    CGPathRelease(path);
    
    /*
     *  第二个
     */
    self.offsetX2 += (IKSCREEN_WIDTH / 60 / self.wavePeriod);
    CGMutablePathRef pathT = CGPathCreateMutable();
    CGPathMoveToPoint(pathT, nil, 0, self.frame.size.height);
    
    CGFloat yT = 0.f;
    for (float x = 0.f; x <= self.waveWidth ; x++) {
        yT = self.waveAmplitude * sin((300 / self.waveWidth) * (x * 2* M_PI / 180) - self.offsetX * M_PI / 270) + self.waveHeight;
        CGPathAddLineToPoint(pathT, nil, x, yT);
    }
    CGPathAddLineToPoint(pathT, nil, self.waveWidth, self.frame.size.height);
//    CGPathAddLineToPoint(pathT, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(pathT);
    self.waveShapeLayer2.path = pathT;
    CGPathRelease(pathT);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
