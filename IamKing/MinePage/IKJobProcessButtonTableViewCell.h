//
//  IKJobProcessButtonTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,IKJobProcessButtonType){
    IKJobProcessButtonTypeChat = 0,
    IKJobProcessButtonTypeCheckInterview,
    IKJobProcessButtonTypeInterViewEndToAppraise,
    IKJobProcessButtonTypeGoingAppraise,
    IKJobProcessButtonTypeCheckAppraise,
};




@protocol IKJobProcessButtonCellDelegate;

@interface IKJobProcessButtonTableViewCell : UITableViewCell

@property (nonatomic, weak) id<IKJobProcessButtonCellDelegate> delegate;

- (void)addProcessButtonTitleWithCompanyStatus:(NSString *)companyStatus
                                    userStatus:(NSString *)userStatus
                                      feedback:(NSString *)hasFeedback
                                  inviteStatus:(NSString *)inviteStatus;


@end


@protocol IKJobProcessButtonCellDelegate <NSObject>

- (void)jobProcessButtonClickWithType:(IKJobProcessButtonType )type cell:(IKJobProcessButtonTableViewCell *)cell;


@end
