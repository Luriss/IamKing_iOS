//
//  IKAddSkillVc.h
//  IamKing
//
//  Created by Luris on 2017/8/23.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKViewController.h"
#import "IKChildJobTypeModel.h"


@protocol IKAddSkillVcDelegate <NSObject>

- (void)addSkillChangeNeedRefreshData:(NSDictionary *)dict;
- (void)addSkillAddNewSkillWithData:(NSDictionary *)dict;

@end


@interface IKAddSkillVc : IKViewController

@property (nonatomic, assign)BOOL isAddSkill;  // YES:Add, NO:Edit
@property (nonatomic, copy)NSMutableDictionary *skillDict;
@property (nonatomic, copy)NSDictionary    *childTypeDict;
@property (nonatomic, weak) id<IKAddSkillVcDelegate> delegate;




@end
