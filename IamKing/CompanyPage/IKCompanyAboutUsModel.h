//
//  IKCompanyAboutUsModel.h
//  IamKing
//
//  Created by Luris on 2017/7/31.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKCompanyAboutUsModel : NSObject


@property(nonatomic,copy)NSString     *companyID;
@property(nonatomic,copy)NSString     *cityID;
@property(nonatomic,copy)NSString     *provinceID;
@property(nonatomic,copy)NSString     *workAddress;
@property(nonatomic,copy)NSString     *cityName;
@property(nonatomic,copy)NSArray      *imageArray;
@property(nonatomic,copy)NSString     *informationDetail;
@property(nonatomic,copy)NSString     *location;
@property(nonatomic,copy)NSArray      *progressList;
@property(nonatomic,copy)NSString     *errorMsg;

- (NSString *)description;


@end
