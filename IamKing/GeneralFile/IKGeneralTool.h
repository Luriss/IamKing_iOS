//
//  IKGeneralTool.h
//  IamKing
//
//  Created by Luris on 2017/8/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, IKPasswordValidateResult) {
    IKPasswordValidateResultSuccess = 0,
    IKPasswordValidateResultNumberError,
    IKPasswordValidateResultDigitalAlphabetError,
};


@interface IKGeneralTool : NSObject

+ (BOOL)validateContactNumber:(NSString *)mobileNum;

+(IKPasswordValidateResult )validatePassWordLegal:(NSString *)pass;


@end
