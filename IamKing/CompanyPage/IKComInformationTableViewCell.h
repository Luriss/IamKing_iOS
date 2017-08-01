//
//  IKComInformationTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/7/31.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol IKComInformationTableViewCellDelegate <NSObject>

- (void)showMoreButtonClick:(UIButton *)button;
- (void)closeMoreButtonClick:(UIButton *)button;

@end

@interface IKComInformationTableViewCell : UITableViewCell


@property (nonatomic,assign)BOOL needShowMoreBtn;
@property (nonatomic,assign)BOOL needCloseMoreBtn;

@property (nonatomic,copy)NSString *content;
@property (nonatomic, weak) id<IKComInformationTableViewCellDelegate> delegate;


@end
