//
//  IKCompanyRecommendListModel.h
//  IamKing
//
//  Created by Luris on 2017/8/3.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKCompanyRecommendListModel : NSObject

@property(nonatomic,copy)NSString     *companyID;
@property(nonatomic,copy)NSString     *logoImageUrl;
@property(nonatomic,copy)NSString     *describe;
@property(nonatomic,copy)NSString     *nickName;

@property(nonatomic,assign)BOOL        isOperate;

- (NSString *)description;

@end
