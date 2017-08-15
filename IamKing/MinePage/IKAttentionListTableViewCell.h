//
//  IKAttentionListTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKAttentionCompanyModel.h"


@protocol IKAttentionListTableViewCellDelegate;

@interface IKAttentionListTableViewCell : UITableViewCell


@property (nonatomic, weak) id<IKAttentionListTableViewCellDelegate> delegate;

- (void)addAttentionListCellData:(IKAttentionCompanyModel *)model;

@end




@protocol IKAttentionListTableViewCellDelegate <NSObject>

- (void)cancelAttentionButtonClickWithCell:(IKAttentionListTableViewCell *)cell;


@end
