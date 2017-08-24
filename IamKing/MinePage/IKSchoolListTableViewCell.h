//
//  IKSchoolListTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IKSchoolListTableViewCellDelegate;

@interface IKSchoolListTableViewCell : UITableViewCell

@property (nonatomic, weak)id<IKSchoolListTableViewCellDelegate> delegate;

- (void)addResumeSchoolListCellData:(NSDictionary *)dict;

@end


@protocol IKSchoolListTableViewCellDelegate <NSObject>

- (void)resumeSchoolListCellEditButtonClickWithData:(NSDictionary *)dict cell:(IKSchoolListTableViewCell *)cell;
- (void)resumeSchoolListCellDeleteButtonClick:(IKSchoolListTableViewCell *)cell;

@end
