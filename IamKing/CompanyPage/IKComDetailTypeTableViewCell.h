//
//  IKComDetailTypeTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/7/31.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IKComDetailTypeTableViewCellDelegate <NSObject>

- (void)typeButtonClick:(UIButton *)button;

@end

@interface IKComDetailTypeTableViewCell : UITableViewCell

@property (nonatomic, weak) id<IKComDetailTypeTableViewCellDelegate> delegate;


@end
