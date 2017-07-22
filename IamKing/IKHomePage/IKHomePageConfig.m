//
//  IKHomePageConfig.m
//  IamKing
//
//  Created by Luris on 2017/7/21.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKHomePageConfig.h"

@implementation IKHomePageConfig
// 创建静态对象 防止外部访问
static IKHomePageConfig *_shareInstance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    // 也可以使用一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_shareInstance == nil) {
            _shareInstance = [super allocWithZone:zone];
        }
    });
    return _shareInstance;
}

+(instancetype)shareInstance
{
    // 最好用self 用Tools他的子类调用时会出现错误
    return [[self alloc]init];
}

// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return _shareInstance;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _shareInstance;
}



- (CGFloat)getLoopPlayViewHight
{
    if (iPhone6P_6sP) {
        return 199;
    }
    else if (iPhone6_6s){
        return 180;
    }
    else if (iPhone5SE){
        return 154;
    }
    else{
        return 0;
    }
}


- (CGFloat)getViewHightWithScreenWidth:(CGFloat )viewHight
{
    // 以 iPhone6 的屏幕宽度作为比例.
    // 比如在 iPhone6 上是80 高度,则在 iPhone6p 上就是(80/667)
    
    return (viewHight/375)*IKSCREEN_WIDTH;
}


@end
