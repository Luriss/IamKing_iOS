//
//  IKAttentionCompanyModel.m
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKAttentionCompanyModel.h"

@implementation IKAttentionCompanyModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"Id = %@;_headerImageUrl = %@;_appraiseNum = %@;_nickName = %@,_cityName = %@,_setupYear = %@,_product = %@,_productNum = %@,_schoolNum = %@,_shopType = %@,_workNum = %@,_isApproveOffcial = %d",_Id,_headerImageUrl,_appraiseNum,_nickName,_cityName,_setupYear,_product,_productNum,_schoolNum,_shopType,_workNum,_isApproveOffcial];
}


@end
