//
//  IKTypeTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKJobTypeModel.h"

@interface IKTypeTableViewCell : UITableViewCell

- (void)addCellDataWithLogo:(NSString *)logoName data:(IKJobTypeModel *)model;

@end
