//
//  IKWorkListTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/23.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol IKWorkListTableViewCellDelegate;

@interface IKWorkListTableViewCell : UITableViewCell

@property (nonatomic, weak)id<IKWorkListTableViewCellDelegate> delegate;

- (void)addResumeWorkListCellData:(NSDictionary *)dict;

@end


@protocol IKWorkListTableViewCellDelegate <NSObject>

- (void)resumeWorkListCellEditButtonClickWithData:(NSDictionary *)dict cell:(IKWorkListTableViewCell *)cell;
- (void)resumeWorkListCellDeleteButtonClick:(IKWorkListTableViewCell *)cell;

@end

