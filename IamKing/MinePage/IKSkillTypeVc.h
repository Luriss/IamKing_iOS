//
//  IKSkillTypeVc.h
//  IamKing
//
//  Created by Luris on 2017/8/23.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKViewController.h"
#import "IKChildJobTypeModel.h"


@protocol IKSkillTypeVcDelegate <NSObject>

- (void)selectedJobTypeName:(NSString *)name typeId:(NSString *)typeId;

@end



@interface IKSkillTypeVc : IKViewController

@property(nonatomic, copy)NSDictionary    *childTypeDict;
@property (nonatomic, weak) id<IKSkillTypeVcDelegate> delegate;

@end
