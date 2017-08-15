//
//  IKJobProcessModel.h
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKJobProcessModel : NSObject

@property(nonatomic,copy)NSString       *companyStatus;
@property(nonatomic,copy)NSString       *companyType;
@property(nonatomic,copy)NSString       *endTime;
@property(nonatomic,copy)NSString       *hasFeedback;
@property(nonatomic,copy)NSString       *inviteStatus;
@property(nonatomic,copy)NSString       *inviteWorkId;
@property(nonatomic,copy)NSString       *product;
@property(nonatomic,copy)NSString       *productNum;
@property(nonatomic,copy)NSString       *schoolNum;
@property(nonatomic,copy)NSString       *sendResumeId;
@property(nonatomic,copy)NSString       *sendTime;
@property(nonatomic,copy)NSString       *userStatus;
@property(nonatomic,copy)NSString       *workName;
@property(nonatomic,copy)NSString       *companyId;
@property(nonatomic,copy)NSString       *nickName;
@property(nonatomic,copy)NSDictionary   *companyInfoDict;



- (NSString *)description;


@end
