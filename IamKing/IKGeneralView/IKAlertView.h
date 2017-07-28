//
//  IKAlertView.h
//  IamKing
//
//  Created by Luris on 2017/7/28.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IKAlertViewDelegate;


@interface IKAlertView : UIView


/**
 *  show alert
 *
 *  @param title             title
 *  @param message           message
 *  @param delegate          回调对象
 *  @param cancelButtonTitle 取消按钮
 *  @param otherButtonTitles 其他按钮
 *

 */
- (instancetype)initWithTitle:(NSString *)title
                       message:(NSString *)message
                      delegate:(id <IKAlertViewDelegate>)delegate
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)show;


@end


@protocol IKAlertViewDelegate <NSObject>

- (void)alertView:(IKAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;


@end
