//
//  IKBlackListModel.m
//  IamKing
//
//  Created by Luris on 2017/8/14.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKBlackListModel.h"

@implementation IKBlackListModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"Id = %@;_headerImageUrl = %@;_headerImageName = %@;_nickName = %@",_Id,_headerImageUrl,_headerImageName,_nickName];
}


@end
