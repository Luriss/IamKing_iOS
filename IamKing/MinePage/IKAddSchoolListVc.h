//
//  IKAddSchoolListVc.h
//  IamKing
//
//  Created by Luris on 2017/8/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKViewController.h"

@protocol IKAddSchoolListVcDelegate <NSObject>

- (void)addSchoolChangeNeedRefreshData:(NSDictionary *)dict;
- (void)addSchoolAddNewRecordWithData:(NSDictionary *)dict;

@end

@interface IKAddSchoolListVc : IKViewController


@property (nonatomic, assign)BOOL isAddSchool;  // YES:Add, NO:Edit
@property (nonatomic, copy)NSMutableDictionary *schoolDict;
@property (nonatomic, weak) id<IKAddSchoolListVcDelegate> delegate;

@end
