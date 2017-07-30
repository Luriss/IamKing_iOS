//
//  IKCompanyInfoModel.m
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyInfoModel.h"

@implementation IKCompanyInfoModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"_companyID = %@;logoImageUrl = %@;title = %@;_evaluate = %ld;address = %@;_setupTime = %@;_numberOfJob = %@;_numberOfStore = %@;introduce = %@;isAuthen = %d",_companyID,_logoImageUrl,_title,_evaluate,_address,_setupTime,_numberOfJob,_numberOfStore,_introduce,_isAuthen];
}


@end
