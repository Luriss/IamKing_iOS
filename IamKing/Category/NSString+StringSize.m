//
//  NSString+StringSize.m
//  IamKing
//
//  Created by Luris on 2017/7/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "NSString+StringSize.h"

@implementation NSString (StringSize)

+ (CGSize )getSizeWithString:(NSString *)string size:(CGSize )size attribute:(NSDictionary *)attribute
{
    CGSize  strSzie = [string boundingRectWithSize:size  options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)  attributes:attribute context:nil].size;

    CGSize reSzie = CGSizeMake(ceilf(strSzie.width) + 16, ceilf(strSzie.height)+16);

    return reSzie;
}

@end
