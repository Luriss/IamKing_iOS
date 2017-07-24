//
//  IKBottomTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/7/16.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol IKBottomTableViewCellDelegate <NSObject>

- (void)searchViewCellStartSearch;

@end

@interface IKBottomTableViewCell : UITableViewCell

@property (nonatomic, weak, nullable) id<IKBottomTableViewCellDelegate> delegate;

@property(nonatomic,assign)BOOL isShowSearchView;
@property(nonatomic,assign)BOOL isShowLooPalyView;
@property(nonatomic,assign)BOOL isShowTopLine;


@end
