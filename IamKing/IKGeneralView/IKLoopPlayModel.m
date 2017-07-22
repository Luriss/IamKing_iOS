//
//  IKLoopPlayModel.m
//  IamKing
//
//  Created by Luris on 2017/7/21.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKLoopPlayModel.h"

@implementation IKLoopPlayModel




- (NSString *)description
{
    return [NSString stringWithFormat:@"imageUrl = %@;imageID = %@;errorType = %ld;errorMessage = %@;",_imageUrl,_imageID,_errorType,_errorMessage];
}



@end
