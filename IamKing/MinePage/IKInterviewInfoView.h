//
//  IKInterviewInfoView.h
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IKInterviewInfoViewDelegate <NSObject>

- (void)interviewInfoViewClickedButtonAtIndex:(NSInteger)buttonIndex;

@end


@interface IKInterviewInfoView : UIView


- (instancetype)initWithTime:(NSString *)time
                     address:(NSString *)address
                     contact:(NSString *)contact
                 phoneNumber:(NSString *)phone
                     delegate:(id <IKInterviewInfoViewDelegate>)delegate;

- (void)show;

@end
