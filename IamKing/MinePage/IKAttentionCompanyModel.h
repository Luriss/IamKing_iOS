//
//  IKAttentionCompanyModel.h
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKAttentionCompanyModel : NSObject


@property(nonatomic,copy)NSString     *Id;
@property(nonatomic,copy)NSString     *headerImageUrl;
@property(nonatomic,copy)NSString     *nickName;
@property(nonatomic,copy)NSString     *appraiseNum;
@property(nonatomic,copy)NSString     *cityName;
@property(nonatomic,copy)NSString     *setupYear;
@property(nonatomic,copy)NSString     *product;
@property(nonatomic,copy)NSString     *productNum;
@property(nonatomic,copy)NSString     *schoolNum;
@property(nonatomic,copy)NSString     *shopType;
@property(nonatomic,copy)NSString     *workNum;
@property(nonatomic,assign)BOOL        isApproveOffcial;

- (NSString *)description;


@end
