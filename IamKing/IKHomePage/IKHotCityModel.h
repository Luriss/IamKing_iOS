//
//  IKHotCityModel.h
//  IamKing
//
//  Created by Luris on 2017/7/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKHotCityModel : NSObject

@property(nonatomic,copy)NSString     *regionID;    // id
@property(nonatomic,copy)NSString     *cityName;           // 城市名


- (NSString *)description;

@end
