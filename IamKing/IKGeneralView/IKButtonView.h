//
//  IKButtonView.h
//  IamKing
//
//  Created by Luris on 2017/7/9.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol IKButtonViewDelegate <NSObject>

- (void)buttonViewButtonClick:(nullable UIButton *)button;

@end

/**
    适用于项目里的特殊按钮,缩放情况下不改变文字.
 */


@interface IKButtonView : UIView

@property (nonatomic, copy, nullable)NSString *title;
@property (nonatomic, assign)CGFloat cornerRadius;
@property (nonatomic, assign)CGFloat borderWidth;
@property(nullable, nonatomic,copy)UIColor  *borderColor;
@property(nullable, nonatomic,copy)UIColor  *HighBorderColor;
@property (nonatomic, assign)BOOL needAnimation;

@property (nonatomic, weak, nullable) id<IKButtonViewDelegate> delegate;


@end
