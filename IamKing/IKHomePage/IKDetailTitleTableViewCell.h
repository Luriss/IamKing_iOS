//
//  IKDetailTitleTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/7/26.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, IKDetailTitleType) {
    IKDetailTitleTypeSkill = 0,
    IKDetailTitleTypeResumeDetail,
    IKDetailTitleTypeWorkAddress,
    IKDetailTitleTypeInterViewAssessment
};


@interface IKDetailTitleTableViewCell : UITableViewCell

@property(nonatomic, assign)IKDetailTitleType titleType;


@end
