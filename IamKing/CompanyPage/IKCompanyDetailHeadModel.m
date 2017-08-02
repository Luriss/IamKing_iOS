//
//  IKCompanyDetailHeadModel.m
//  IamKing
//
//  Created by Luris on 2017/7/30.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyDetailHeadModel.h"

@implementation IKCompanyDetailHeadModel


- (NSString *)description
{
    NSString *str = [NSString stringWithFormat:@"_companyID = %@,_logoImageUrl = %@,_companyName = %@,_workCity = %@,_workAddress = %@,_companyTypeName = %@,_companyType = %@,_setupYear = %@,_nickName = %@,_numberOfSchool = %@,_numberOfProduct = %@,_shopName = %@,_numberOfAppraise = %@,_numberOfAttention = %@,_isAuthen = %d,_companyDescription = %@,_isAppraise = %d,_isOperate = %d,_isPerisher = %d",_companyID,_logoImageUrl,_companyName,_workCity,_workAddress,_companyTypeName,_companyType,_setupYear,_nickName,_numberOfSchool,_numberOfProduct,_shopName,_numberOfAppraise,_numberOfAttention,_isAuthen,_companyDescription,_isAppraise,_isOperate,_isPerisher];
    
    return str;
    
}

@end
