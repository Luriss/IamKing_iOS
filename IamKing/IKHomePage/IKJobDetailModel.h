//
//  IKJobDetailModel.h
//  IamKing
//
//  Created by Luris on 2017/7/25.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKJobDetailModel : NSObject


@property(nonatomic,copy)NSString     *jobID;
@property(nonatomic,copy)NSString     *logoImageUrl;
@property(nonatomic,copy)NSString     *jobName;
@property(nonatomic,copy)NSString     *companyName;
@property(nonatomic,copy)NSString     *salary;
@property(nonatomic,copy)NSString     *workAddress;
@property(nonatomic,copy)NSString     *workCity;
@property(nonatomic,copy)NSString     *experience;
@property(nonatomic,copy)NSString     *education;
@property(nonatomic,copy)NSArray      *feedback;
@property(nonatomic,copy)NSString     *responsibility;
@property(nonatomic,copy)NSString     *require;
@property(nonatomic,copy)NSString     *shopName;
@property(nonatomic,copy)NSArray      *tagsList;
@property(nonatomic,copy)NSString     *temptation;
@property(nonatomic,copy)NSDictionary *companyInfo;
@property(nonatomic,copy)NSString     *releaseTime;
@property(nonatomic,assign)CGFloat     numberOfSection;

@property(nonatomic,assign)BOOL        isAuthen;


- (NSString *)description;

@end
