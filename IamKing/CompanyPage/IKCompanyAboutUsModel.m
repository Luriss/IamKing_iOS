//
//  IKCompanyAboutUsModel.m
//  IamKing
//
//  Created by Luris on 2017/7/31.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKCompanyAboutUsModel.h"

@implementation IKCompanyAboutUsModel

- (NSString *)description
{
    NSString *str = [NSString stringWithFormat:@"_companyID = %@,_cityID = %@,_cityName = %@,_location = %@,_imageArray = %@,_progressList = %@,_informationDetail = %@",_companyID,_cityID,_cityName,_location,_imageArray,_progressList,_informationDetail];
    
    return str;
    
}

@end
