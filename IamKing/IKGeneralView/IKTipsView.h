//
//  IKTipsView.h
//  IamKing
//
//  Created by Luris on 2017/7/27.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, IKTipsArrowDirection) {
    IKTipsArrowDirectionUpLeft = 0, // 上左
    IKTipsArrowDirectionUpCenter,   // 上中
    IKTipsArrowDirectionUpRight,    // 上右
    IKTipsArrowDirectionDownLeft,   // 下左
    IKTipsArrowDirectionDownCenter,            // 下中
    IKTipsArrowDirectionDownRight,           // 下右
};


@interface IKTipsView : UIView

- (instancetype)initWithFrame:(CGRect)frame
     arrowDirection:(IKTipsArrowDirection )direction
            bgColor:(UIColor *)bgColor;


@property (nonatomic, copy)NSString *tipsContent;

- (void)popView;

@end
