//
//  IKJobProcessModel.m
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobProcessModel.h"

@implementation IKJobProcessModel


- (NSString *)description
{
    return [NSString stringWithFormat:@"_companyStatus = %@;_companyType = %@;_endTime = %@;_hasFeedback = %@,_inviteStatus = %@,_inviteWorkId = %@,_product = %@,_productNum = %@,_schoolNum = %@,_sendResumeId = %@,_sendTime = %@,_userStatus = %@,_workName = %@,_companyId = %@,_companyInfoDict = %@",_companyStatus,_companyType,_endTime,_hasFeedback,_inviteStatus,_inviteWorkId,_product,_productNum,_schoolNum,_sendResumeId,_sendTime,_userStatus,_workName,_companyId,_companyInfoDict];
}

@end
