//
//  IKLocationManager.h
//  IamKing
//
//  Created by Luris on 2017/7/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKLocationManager : NSObject

+ (instancetype)shareInstance;

- (void)startLocation;


- (NSString *)getLocationCity;
- (NSString *)getLocationCityId;

- (NSString *)getCountry;

- (NSString *)getDistrct;


@end
