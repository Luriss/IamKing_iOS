//
//  IKCompanyTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IKImageWordView.h"
#import "IKCompanyInfoModel.h"

@interface IKCompanyTableViewCell : UITableViewCell

- (void)addCellData:(IKCompanyInfoModel *)model;


@end
