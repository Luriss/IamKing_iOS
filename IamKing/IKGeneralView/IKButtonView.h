//
//  IKButtonView.h
//  IamKing
//
//  Created by Luris on 2017/7/9.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol IKButtonVieDelegate <NSObject>

- (void)buttonViewButtonClick:(UIButton *)button;

@end

/**
    适用于项目里的特殊按钮,缩放情况下不改变文字.
 */


@interface IKButtonView : UIView

@property (nonatomic, copy)NSString *title;
@property (nonatomic, weak) id<IKButtonVieDelegate> delegate;


@end
