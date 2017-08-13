//
//  IKGeneralTool.h
//  IamKing
//
//  Created by Luris on 2017/8/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKGeneralTool : NSObject

+ (BOOL)validateContactNumber:(NSString *)mobileNum;

+(BOOL)validatePassWordLegal:(NSString *)pass;


@end
