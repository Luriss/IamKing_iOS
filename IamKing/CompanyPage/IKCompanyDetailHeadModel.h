//
//  IKCompanyDetailHeadModel.h
//  IamKing
//
//  Created by Luris on 2017/7/30.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKCompanyDetailHeadModel : NSObject

@property(nonatomic,copy)NSString     *companyID;
@property(nonatomic,copy)NSString     *logoImageUrl;
@property(nonatomic,copy)NSString     *companyName;
@property(nonatomic,copy)NSString     *workAddress;
@property(nonatomic,copy)NSString     *workCity;
@property(nonatomic,copy)NSString     *companyTypeName;
@property(nonatomic,copy)NSString     *companyType;
@property(nonatomic,copy)NSString     *setupYear;
@property(nonatomic,copy)NSString     *nickName;
@property(nonatomic,copy)NSString     *numberOfSchool;
@property(nonatomic,copy)NSString     *shopName;
@property(nonatomic,copy)NSString     *numberOfProduct;
@property(nonatomic,copy)NSString     *numberOfAppraise;  // 评价
@property(nonatomic,copy)NSString     *numberOfAttention;  // 评价
@property(nonatomic,copy)NSString     *companyDescription;  


@property(nonatomic,assign)BOOL        isAuthen;
@property(nonatomic,assign)BOOL        isAppraise;
@property(nonatomic,assign)BOOL        isOperate;
@property(nonatomic,assign)BOOL        isPerisher;


- (NSString *)description;

@end
