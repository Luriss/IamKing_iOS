//
//  IKResumeSkillTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/17.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IKResumeSkillTableViewCellDelegate;

@interface IKResumeSkillTableViewCell : UITableViewCell

@property (nonatomic, weak)id<IKResumeSkillTableViewCellDelegate> delegate;

- (void)addResumeSkillCellData:(NSDictionary *)dict;

@end


@protocol IKResumeSkillTableViewCellDelegate <NSObject>

- (void)resumeSkillCellEditButtonClickWithData:(NSDictionary *)dict cell:(IKResumeSkillTableViewCell *)cell;
- (void)resumeSkillCellDeleteButtonClick:(IKResumeSkillTableViewCell *)cell;

@end

