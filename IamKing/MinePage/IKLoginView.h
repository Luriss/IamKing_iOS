//
//  IKLoginView.h
//  IamKing
//
//  Created by Luris on 2017/8/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKView.h"

typedef NS_ENUM(NSInteger, IKLoginViewLoginType) {
    IKLoginViewLoginTypeRegisterFindJob = 0,    // 注册- 找工作
    IKLoginViewLoginTypeRegisterFindPerson,     // 注册- 招人
    IKLoginViewLoginTypePhoneNumber,            // 手机号码登录
    IKLoginViewLoginTypeAccount,                // 账号登录
};

@protocol IKLoginViewDelegate <NSObject>

- (void)loginViewRefreshFrameWithType:(IKLoginViewLoginType)loginType;

@end


@interface IKLoginView : IKView

@property (nonatomic, weak) id<IKLoginViewDelegate> delegate;


- (void)textFieldNeedResignFirstResponder;



@end
