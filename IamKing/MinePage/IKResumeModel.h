//
//  IKResumeModel.h
//  IamKing
//
//  Created by Luris on 2017/8/16.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKResumeModel : NSObject


@property(nonatomic,copy)NSString       *birthYear;
@property(nonatomic,copy)NSString       *cityId;
@property(nonatomic,copy)NSString       *cityName;
@property(nonatomic,copy)NSString       *companyType;
@property(nonatomic,copy)NSString       *companyTypeName;
@property(nonatomic,copy)NSString       *educationType;
@property(nonatomic,copy)NSString       *educationTypeName;
@property(nonatomic,copy)NSString       *experienceType;
@property(nonatomic,copy)NSString       *experienceTypeName;
@property(nonatomic,copy)NSString       *headerImageName;
@property(nonatomic,copy)NSString       *headerImageUrl;
@property(nonatomic,copy)NSString       *introduce;
@property(nonatomic,copy)NSString       *name;
@property(nonatomic,copy)NSString       *parentWorkClassId;
@property(nonatomic,copy)NSString       *resumeId;
@property(nonatomic,copy)NSString       *salaryType;
@property(nonatomic,copy)NSString       *salaryTypeName;
@property(nonatomic,copy)NSString       *sex;
@property(nonatomic,copy)NSString       *tel;
@property(nonatomic,copy)NSString       *userId;
@property(nonatomic,copy)NSString       *workClassId;
@property(nonatomic,copy)NSString       *workId;
@property(nonatomic,copy)NSString       *workName;
@property(nonatomic,copy)NSString       *workStatus;


@property(nonatomic,copy)NSArray        *oldShowUrl;
@property(nonatomic,copy)NSArray        *schoolList;
@property(nonatomic,copy)NSArray        *showUrl;
@property(nonatomic,copy)NSArray        *tagList;
@property(nonatomic,copy)NSArray        *workList;

@end
