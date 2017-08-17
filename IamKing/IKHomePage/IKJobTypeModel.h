//
//  IKJobTypeModel.h
//  IamKing
//
//  Created by Luris on 2017/7/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKJobTypeModel : NSObject


@property(nonatomic,copy)NSString     *describe;    // 描述
@property(nonatomic,copy)NSString     *JobName;     //
@property(nonatomic,copy)NSString     *jobId;     //

@property(nonatomic,copy)NSArray      *childType;     // 

- (NSString *)description;


@end
