//
//  IKComInformationTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/7/31.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol IKComInformationTableViewCellDelegate <NSObject>

- (void)showMoreButtonClick:(BOOL)isClickShowMore;
//- (void)closeMoreButtonClick:(UIButton *)button;

@end

@interface IKComInformationTableViewCell : UITableViewCell




//@property (nonatomic,copy)NSString *content;
@property (nonatomic, weak) id<IKComInformationTableViewCellDelegate> delegate;

- (void)createSubViews:(NSString *)content needShowMore:(BOOL)needMore needClose:(BOOL)needClose cellHeight:(CGFloat)cellH;

@end
