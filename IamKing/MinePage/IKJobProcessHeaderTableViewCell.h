//
//  IKJobProcessHeaderTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKJobProcessHeaderTableViewCell : UITableViewCell


- (void)addProcessHeaderCellTopTime:(NSString *)time
                       inviteStatus:(NSString *)inviteStatus
                         deliverJob:(NSString *)job
                      companyStatus:(NSString *)companyStatus
                         userStatus:(NSString *)userStatus;


@end
