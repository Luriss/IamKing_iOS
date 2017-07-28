//
//  IKFeedbackTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/7/27.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKFeedbackTableViewCell : UITableViewCell

@property (nonatomic, assign)BOOL showBottomLine;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier noData:(BOOL)isNoData;

- (void)addFeedbackCellData:(NSDictionary *)dict;

@end
