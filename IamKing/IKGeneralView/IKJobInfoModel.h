//
//  IKJobInfoModel.h
//  IamKing
//
//  Created by Luris on 2017/7/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKJobInfoModel : NSObject

@property(nonatomic,copy)NSString     *logoImageUrl;
@property(nonatomic,copy)NSString     *title;
@property(nonatomic,copy)NSString     *salary;
@property(nonatomic,copy)NSString     *address;
@property(nonatomic,copy)NSString     *experience;
@property(nonatomic,copy)NSString     *education;
@property(nonatomic,copy)NSString     *skill1;
@property(nonatomic,copy)NSString     *skill2;
@property(nonatomic,copy)NSString     *skill3;
@property(nonatomic,copy)NSString     *introduce;
@property(nonatomic,assign)BOOL        isAuthen;

@end
