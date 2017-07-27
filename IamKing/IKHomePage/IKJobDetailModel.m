//
//  IKJobDetailModel.m
//  IamKing
//
//  Created by Luris on 2017/7/25.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobDetailModel.h"

@implementation IKJobDetailModel


- (NSString *)description
{
    NSString *str = [NSString stringWithFormat:@"_jobID = %@,_jobName = %@,_logoImageUrl = %@,_companyName = %@,_salary = %@,_workCity = %@,_workAddress = %@,_experience = %@,_education = %@,_feedback = %@,_responsibility = %@,_require = %@,_shopName = %@,_tagsList = %@,_temptation = %@,_companyInfo = %@,_releaseTime = %@,_numberOfSection = %.0f",_jobID,_jobName,_logoImageUrl,_companyName,_salary,_workCity,_workAddress,_experience,_education,_feedback,_responsibility,_require,_shopName,_tagsList,_temptation,_companyInfo,_releaseTime,_numberOfSection];
    
    return str;
    
}


@end
