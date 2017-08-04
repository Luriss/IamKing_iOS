//
//  IKCompanyShopNumModel.h
//  IamKing
//
//  Created by Luris on 2017/8/1.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKCompanyShopNumModel : NSObject

@property(nonatomic,copy)NSString     *cityID;
@property(nonatomic,copy)NSString     *logoImageUrl;
@property(nonatomic,copy)NSString     *name;
@property(nonatomic,copy)NSString     *workAddress;
@property(nonatomic,copy)NSString     *workCity;
@property(nonatomic,copy)NSString     *area;
@property(nonatomic,copy)NSString     *companyType;
@property(nonatomic,copy)NSString     *setupYear;
@property(nonatomic,copy)NSString     *describeDetail;
@property(nonatomic,copy)NSString     *describeIntro;
@property(nonatomic,copy)NSString     *shopName;
@property(nonatomic,copy)NSString     *numberOfMember;
@property(nonatomic,copy)NSString     *shopType;
@property(nonatomic,copy)NSString     *shopTypeName;  // 评价
@property(nonatomic,copy)NSString     *status;
@property(nonatomic,copy)NSString     *numberOfTeach;
@property(nonatomic,copy)NSString     *updateTime;
@property(nonatomic,copy)NSString     *companyID;
@property(nonatomic,copy)NSString     *provinceid;
@property(nonatomic,copy)NSString     *provinceName;
@property(nonatomic,copy)NSString     *ID;
@property(nonatomic,copy)NSString     *inviteIds;
@property(nonatomic,copy)NSString     *inviteNum;

@property(nonatomic,assign)BOOL        isAuthen;
@property(nonatomic,assign)BOOL        isBusiness;

- (NSString *)description;
@end
