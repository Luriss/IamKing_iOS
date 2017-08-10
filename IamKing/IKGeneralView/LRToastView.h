//
//  LRToastView.h
//  IamKing
//
//  Created by Luris on 2017/8/9.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LRToastVerticalAlignment) {
    LRToastVerticalAlignmentTop = 0,
    LRToastVerticalAlignmentMiddle,
    LRToastVerticalAlignmentBottom,
};

@interface LRToastStyle : NSObject

// Default blackColor ,Alpha 0.98
@property (nonatomic,strong) UIColor *backgroundColor;
@property (nonatomic,copy) NSString *text;

// Default 14.0
@property (nonatomic,strong) UIFont *textFont;

// Default whiteColor
@property (nonatomic,strong) UIColor *textColor;

// Default SCREEN_WIDTH * 0.5
@property (nonatomic,assign) CGFloat maxWidth;

// Default  1.0
@property (nonatomic,assign) NSTimeInterval duration;

// Default LRToastVerticalAlignmentMiddle
@property (nonatomic,assign) LRToastVerticalAlignment verticalAlignment;

@end

@interface LRToastView : UIView



/**
    Toast 默认的,不支持自定义.

 @param text 信息
 @param showView 显示的视图  1s 后消失.
 */
+ (void)showTosatWithText:(NSString *)text inView:(UIView *)showView;


+ (void)showTosatWithText:(NSString *)text
                   inView:(UIView *)showView
        dismissAfterDelay:(NSTimeInterval )duration;

/**
 Toast 支持自定义位置

 @param style 自定义样式
 @param showView 显示的视图
 */
+ (void)showTosatWithStyle:(LRToastStyle *)style inView:(UIView *)showView;

@end
