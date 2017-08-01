//
//  IKCompanyManagerTeamModel.h
//  IamKing
//
//  Created by Luris on 2017/8/1.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKCompanyManagerTeamModel : NSObject

@property(nonatomic,copy)NSString     *companyID;
@property(nonatomic,copy)NSString     *headerImageUrl;
@property(nonatomic,copy)NSString     *headerImageName;
@property(nonatomic,copy)NSString     *name;
@property(nonatomic,copy)NSString     *workPosition;
@property(nonatomic,copy)NSString     *describe;

- (NSString *)description;


@end
