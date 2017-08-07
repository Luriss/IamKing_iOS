//
//  IKMessageNoticeTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, IKMessageNoticeTableViewCellType) {
    IKMessageNoticeTableViewCellTypeNotice = 0,
    IKMessageNoticeTableViewCellTypeInterested,
    IKMessageNoticeTableViewCellTypeMessage,
};



@interface IKMessageNoticeTableViewCell : UITableViewCell


@property(nonatomic, assign)IKMessageNoticeTableViewCellType cellType;

- (void)messageNoticeCellAddData;


@end
