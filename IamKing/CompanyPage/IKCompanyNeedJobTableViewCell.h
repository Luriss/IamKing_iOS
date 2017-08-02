//
//  IKCompanyNeedJobTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/1.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IKImageWordView.h"
#import "IKJobInfoModel.h"

@interface IKCompanyNeedJobTableViewCell : UITableViewCell

- (void)addCellData:(IKJobInfoModel *)model;

@end
