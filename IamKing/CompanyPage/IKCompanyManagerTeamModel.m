//
//  IKCompanyManagerTeamModel.m
//  IamKing
//
//  Created by Luris on 2017/8/1.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyManagerTeamModel.h"

@implementation IKCompanyManagerTeamModel


- (NSString *)description
{
    NSString *str = [NSString stringWithFormat:@"_companyID = %@,_headerImageName = %@,_headerImageUrl = %@,_name = %@,_work_position = %@",_companyID,_headerImageName,_headerImageUrl,_name,_workPosition];
    
    return str;
    
}

@end
