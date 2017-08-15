//
//  IKBlackListTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/14.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKBlackListModel.h"


@protocol IKBlackListTableViewCellDelegate;


@interface IKBlackListTableViewCell : UITableViewCell

@property (nonatomic, weak) id<IKBlackListTableViewCellDelegate> delegate;

- (void)blackListCellAddData:(IKBlackListModel *)model;

@end


@protocol IKBlackListTableViewCellDelegate <NSObject>

- (void)deleteButtonClickWithCell:(IKBlackListTableViewCell *)cell;


@end



