//
//  IKSchoolListModel.m
//  IamKing
//
//  Created by Luris on 2017/8/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKSchoolListModel.h"

@implementation IKSchoolListModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"Id = %@;_logoImageUrl = %@;_name = %@;_type = %@",_Id,_logoImageUrl,_name,_type];
}


@end
