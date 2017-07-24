//
//  IKProvinceModel.h
//  IamKing
//
//  Created by Luris on 2017/7/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKProvinceModel : NSObject


@property(nonatomic,copy)NSString     *provinceID;    // id
@property(nonatomic,copy)NSString     *provinceName;  // 省名
@property(nonatomic,copy)NSArray      *childCity;     // 城市名

- (NSString *)description;

@end
