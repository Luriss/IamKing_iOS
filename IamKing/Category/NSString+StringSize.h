//
//  NSString+StringSize.h
//  IamKing
//
//  Created by Luris on 2017/7/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringSize)


+ (CGSize )getSizeWithString:(NSString *)string size:(CGSize )size attribute:(NSDictionary *)attribute;

@end
