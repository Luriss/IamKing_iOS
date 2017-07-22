//
//  IKJobInfoModel.m
//  IamKing
//
//  Created by Luris on 2017/7/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobInfoModel.h"

@implementation IKJobInfoModel



- (NSString *)description
{
    return [NSString stringWithFormat:@"jobID = %@;logoImageUrl = %@;title = %@;salary = %@;address = %@;experience = %@;education = %@;skill1 = %@;skill2 = %@;skill3 = %@;introduce = %@;isAuthen = %d",_jobID,_logoImageUrl,_title,_salary,_address,_experience,_education,_skill1,_skill2,_skill3,_introduce,_isAuthen];
}


@end
