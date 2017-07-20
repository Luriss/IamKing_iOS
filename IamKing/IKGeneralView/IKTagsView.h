//
//  IKTagsView.h
//  IamKing
//
//  Created by Luris on 2017/7/20.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
    标签视图,乱序排列,自动布局,由于缺少重用机制,不建议大量数据使用.
 */

// 重新适配 frame
typedef void(^AdjustFrame)(CGRect newFrame);



@protocol IKTagsViewDelegate <NSObject>

- (void)tagViewDidSelectedTagWithTitle:(nullable NSString *)title;

@end


@interface IKTagsView : UIView

@property (nonatomic, weak, nullable) id<IKTagsViewDelegate> delegate;
@property(nonatomic,strong,nullable)NSArray<NSString *> *data;  //数据源
@property(nonatomic,assign)CGFloat tagHeight;           // 高度
@property(nonatomic,assign)CGFloat tagFont;             // 字号
@property(nonatomic,assign)CGFloat lineSpacing;         // 行间距
@property(nonatomic,assign)CGFloat verticalSpacing;     // 列间距
@property(nonatomic,strong, nullable)UIView *titleView;   // 标题 默认整个 view 宽度;

@property(nonatomic,assign,nullable)NSString *title;             // 标题
@property(nonatomic,assign)NSTextAlignment titleAlignment;   // 标题位置 默认居中
@property(nonatomic,assign)CGFloat titleFont;   // 标题字号 默认 14;
@property(nonatomic,strong, nullable)UIColor *titleColor;   // 标题颜色 默认 黑色;
@property(nonatomic,strong, nullable)UIColor *tagTitleColor;   // tag颜色 默认 黑色;
@property(nonatomic,assign)CGFloat tagCornerRadius;   // tag圆角;
@property(nonatomic,strong, nullable)UIColor *tagBgColor;   // tag背景色;
@property(nonatomic,strong, nullable)UIColor *tagBorderColor;   // tag边框色; 宽度默认1;
@property(nonatomic,assign)CGFloat tagBorderWidth;   // tag边框宽度;



- (void)createViewAdjustViewFrame:(nullable AdjustFrame )newFrame;


@end
