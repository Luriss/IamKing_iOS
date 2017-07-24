//
//  IKJobTypeModel.m
//  IamKing
//
//  Created by Luris on 2017/7/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKJobTypeModel.h"

@implementation IKJobTypeModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"_describe = %@;_JobName = %@;_childType = %@",_describe,_JobName,_childType];
}
@end
