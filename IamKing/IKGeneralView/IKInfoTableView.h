//
//  IKInfoTableView.h
//  IamKing
//
//  Created by Luris on 2017/7/10.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol IKInfoTableViewDelegate <NSObject>

- (void)tableViewHeaderLeftButtonClick:(UIButton *)button;
- (void)tableViewHeaderRightButtonClick:(UIButton *)button;
- (void)infoTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end



typedef NS_ENUM(NSInteger, IKTableViewHeaderSelectedButton) {
    IKTableViewHeaderSelectedButtonLeft = 0,
    IKTableViewHeaderSelectedButtonRight,
};

@interface IKInfoTableView : UIView

@property (nonatomic,copy)NSString *leftHeaderButtonTitle;
@property (nonatomic,copy)NSString *rightHeaderButtonTitle;
@property (nonatomic, weak) id<IKInfoTableViewDelegate> delegate;



@end
