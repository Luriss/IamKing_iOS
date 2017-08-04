//
//  IKCompanyAdView.h
//  IamKing
//
//  Created by Luris on 2017/8/3.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, IKAdVScrollDirection) {
    IKAdVScrollDirectionHorizontal = 0,                 /** 水平滚动*/
    IKAdVScrollDirectionVertical,                       /** 垂直滚动*/
};

typedef NS_ENUM(NSInteger, IKAdPageControlAlignment) {
    IKAdPageControlAlignmentHorizontalLeft = 0,        /** page control 布局 水平靠左*/
    IKAdPageControlAlignmentHorizontalCenter,          /** page control 布局 水平居中*/
    IKAdPageControlAlignmentHorizontalRight,           /** page control 布局 水平靠右*/
    IKAdPageControlAlignmentVerticalTop,               /** page control 布局 垂直靠上*/
    IKAdPageControlAlignmentVerticalCenter,            /** page control 布局 垂直居中*/
    IKAdPageControlAlignmentVerticalButtom,            /** page control 布局 垂直靠底*/
};


@interface IKCompanyAdView : UIView

// 图片数据源
@property (nonatomic, copy)NSArray *imagesArray;

// 标题数据源
@property (nonatomic, copy)NSArray *titlesArray;

// 图片滚动方向 默认横向
@property (nonatomic, assign)IKAdVScrollDirection scrollDirection;

// 图片反向滚动  default is no.
@property (nonatomic, assign) BOOL reverseDirection;


// 图片是否自动滚动 defalut is YES.
@property (nonatomic, assign)BOOL isAutoScroll;

// 轮播图是否无限循环滚动 - defalut is YES
@property (nonatomic, assign) BOOL isInfiniteLoop;

// 轮播图滚动时间间隔 defalut is 3 second */
@property (nonatomic, assign) NSTimeInterval scrollTimeInterval;

// 获取轮播图当前的位置
@property (nonatomic, assign, readonly) NSInteger currentPageIndex;

// 轮播图片占位图,加载网络图片建议设置占位图
@property (nonatomic, strong) UIImage* placeholderImage;

// 轮播图片ContentMode - defalut is UIViewContentModeScaleToFill
@property (nonatomic, assign) UIViewContentMode pageViewContentMode;

// 滚动到下一页
- (void)scrollToNextPage;

// 开始自动滚动
- (void)startAutoScrollPage;

// 停止自动滚动
- (void)stopAutoScrollPage;

- (void)reloadImageData;

@end
