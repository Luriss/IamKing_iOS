//
//  IKCompanyShopNumModel.m
//  IamKing
//
//  Created by Luris on 2017/8/1.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyShopNumModel.h"

@implementation IKCompanyShopNumModel

- (NSString *)description
{
    NSString *str = [NSString stringWithFormat:@"_companyID = %@,_logoImageUrl = %@,_cityID = %@,_workCity = %@,_workAddress = %@,_name = %@,_companyType = %@,_area = %@,_setupYear = %@,_describeDetail = %@,_describeIntro = %@,_shopName = %@,_numberOfMember = %@,_shopType = %@,_isAuthen = %d,_shopTypeName = %@,_status = %@,_numberOfTeach = %@,_updateTime = %@,_provinceid = %@,_provinceName = %@,_ID = %@,_update_inviteIdsTime = %@,_inviteNum = %@,_isAuthen = %d,_isBusiness = %d",_companyID,_logoImageUrl,_cityID,_workCity,_workAddress,_name,_companyType,_area,_setupYear,_describeDetail,_describeIntro,_shopName,_numberOfMember,_shopType,_isAuthen,_shopTypeName,_status,_numberOfTeach,_updateTime,_provinceid,_provinceName,_ID,_inviteIds,_inviteNum,_isAuthen,_isBusiness];
    
    return str;
    
}


@end
