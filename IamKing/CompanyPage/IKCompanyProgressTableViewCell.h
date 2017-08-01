//
//  IKCompanyProgressTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/1.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKCompanyProgressTableViewCell : UITableViewCell


- (void)addProgressCellData:(NSDictionary *)progress
             showVerTopLine:(BOOL )isShowVerTopLine
          showVerBottomLine:(BOOL )isShowVerBottomLine;



@end
