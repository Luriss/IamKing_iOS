//
//  IKSelectView.h
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKView.h"



typedef NS_ENUM(NSInteger, IKSelectedSubType) {
    IKSelectedSubTypeNone = 0,
    IKSelectedSubTypeJobAddress,                        // 工作地点 
    IKSelectedSubTypeJobCompanyType,                    // 公司类型
    IKSelectedSubTypeJobSalary,                         // 薪资待遇
    IKSelectedSubTypeJobExperience,                     // 工作经验
    IKSelectedSubTypeCompanyType,                       // 公司类型
    IKSelectedSubTypeCompanyNumberOfStore,              // 店铺数量
    IKSelectedSubTypeCompanyDirectlyToJoin,             // 直营加盟
    IKSelectedSubTypeCompanyEvaluation                  // 公司评价
};



@protocol IKSelectViewDelegate <NSObject>

- (void)selectViewDidSelectIndexPath:(NSIndexPath *)indexPath selectContent:(NSString *)select;

@end

@interface IKSelectView : IKView

@property (nonatomic, weak) id<IKSelectViewDelegate> delegate;

@property(nonatomic,assign)IKSelectedSubType type;
@property(nonatomic,strong)NSIndexPath *selectedIndexPath;

- (instancetype)initWithFrame:(CGRect)frame Type:(IKSelectedSubType)type;

@end
