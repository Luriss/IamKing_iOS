//
//  IKAddRecordListVc.h
//  IamKing
//
//  Created by Luris on 2017/8/23.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKViewController.h"


@protocol IKAddRecordListVcDelegate <NSObject>

- (void)addRecordChangeNeedRefreshData:(NSDictionary *)dict;
- (void)addRecordAddNewRecordWithData:(NSDictionary *)dict;

@end



@interface IKAddRecordListVc : IKViewController


@property (nonatomic, assign)BOOL isAddRecord;  // YES:Add, NO:Edit
@property (nonatomic, copy)NSMutableDictionary *recordDict;
@property (nonatomic, weak) id<IKAddRecordListVcDelegate> delegate;


@end
