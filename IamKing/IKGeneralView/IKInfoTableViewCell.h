//
//  IKInfoTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/7/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKImageWordView.h"
#import "IKJobInfoModel.h"

@interface IKInfoTableViewCell : UITableViewCell

- (void)addCellData:(IKJobInfoModel *)model;


@end
