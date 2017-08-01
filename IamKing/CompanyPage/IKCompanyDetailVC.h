//
//  IKCompanyDetailVC.h
//  IamKing
//
//  Created by Luris on 2017/7/30.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKViewController.h"
#import "IKCompanyInfoModel.h"


typedef NS_ENUM(NSInteger, IKCompanyDetailVCType) {
    IKCompanyDetailVCTypeAboutUs = 0,
    IKCompanyDetailVCTypeManagerTeam,
    IKCompanyDetailVCTypeMultipleShop,
    IKCompanyDetailVCTypeNeedJob
};

@interface IKCompanyDetailVC : IKViewController


@property (nonatomic,strong)IKCompanyInfoModel *companyInfoModel;






@end
