//
//  IKCollectionListTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKJobInfoModel.h"


@protocol IKCollectionListTableViewCellDelegate;

@interface IKCollectionListTableViewCell : UITableViewCell


@property (nonatomic, weak) id<IKCollectionListTableViewCellDelegate> delegate;

- (void)addCollectionListCellData:(IKJobInfoModel *)model;

@end




@protocol IKCollectionListTableViewCellDelegate <NSObject>

- (void)cancelCollectionButtonClickWithCell:(IKCollectionListTableViewCell *)cell;


@end



