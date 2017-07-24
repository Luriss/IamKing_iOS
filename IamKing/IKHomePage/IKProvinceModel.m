//
//  IKProvinceModel.m
//  IamKing
//
//  Created by Luris on 2017/7/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKProvinceModel.h"

@implementation IKProvinceModel


- (NSString *)description
{
    return [NSString stringWithFormat:@"_provinceID = %@;_provinceName = %@;_childCity = %@",_provinceID,_provinceName,_childCity];
}



@end
