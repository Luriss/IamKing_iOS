//
//  IKSelectModel.h
//  IamKing
//
//  Created by Luris on 2017/7/19.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKSelectModel : NSObject

@property(nonatomic,copy)NSIndexPath  *salaryIP;     // 薪资区间
@property(nonatomic,copy)NSIndexPath     *jobCompanyTypeIP;     // 职位公司类型
@property(nonatomic,assign)NSIndexPath  *experienceIP;         // 工作经验
@property(nonatomic,copy)NSIndexPath     *evaluationIP;         // 地址
@property(nonatomic,copy)NSIndexPath     *directlyToJoinIP;       // 成立时间
@property(nonatomic,copy)NSIndexPath     *numberOfStoreIP;   // 店面数量
@property(nonatomic,copy)NSIndexPath     *companyTypeIP;       // 公司类型

@end
