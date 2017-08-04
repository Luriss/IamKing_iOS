//
//  IKCompanyRecommendListModel.m
//  IamKing
//
//  Created by Luris on 2017/8/3.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyRecommendListModel.h"

@implementation IKCompanyRecommendListModel

- (NSString *)description
{
    NSString *str = [NSString stringWithFormat:@"_companyID = %@,_logoImageUrl = %@,_describe = %@,_nickName = %@,_isOperate = %d",_companyID,_logoImageUrl,_describe,_nickName,_isOperate];
    
    return str;
    
}

@end
