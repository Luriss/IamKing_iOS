//
//  IKRollLabel.h
//  IamKing
//
//  Created by Luris on 2017/8/3.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, IKRollLabelScrollDirection) {
    IKRollLabelScrollDirectionHorizontal = 0,                 /** 水平滚动*/
    IKRollLabelScrollDirectionVertical,                       /** 垂直滚动*/
};

@interface IKRollLabel : UIView


// label 文字数据源
@property (nonatomic, copy)NSArray<NSString *> *dataArray;

// 滚动方向 默认横向
@property (nonatomic, assign)IKRollLabelScrollDirection scrollDirection;

// 反向滚动  default is no.
@property (nonatomic, assign) BOOL reverseDirection;

// 是否自动滚动 defalut is YES.
@property (nonatomic, assign)BOOL isAutoScroll;

// 是否无限循环滚动 - defalut is YES
@property (nonatomic, assign) BOOL isInfiniteLoop;

// 滚动时间间隔 defalut is 3 second */
@property (nonatomic, assign) NSTimeInterval scrollTimeInterval;

// 获取当前的位置
@property (nonatomic, assign, readonly) NSInteger currentPageIndex;

// 文字字体
@property (nonatomic, strong) UIFont    *labelFont;

// 文字颜色
@property (nonatomic, strong) UIColor   *labelTextColor;

// 位子位置
@property(nonatomic)        NSTextAlignment    textAlignment;


// 滚动到下一页
- (void)scrollToNextPage;

// 开始自动滚动
- (void)startAutoScrollPage;

// 停止自动滚动
- (void)stopAutoScrollPage;

- (void)reloadViewData;

@end
