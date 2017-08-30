//
//  IKAddPhotoTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol IKAddPhotoTableViewCellDelegate <NSObject>

- (void)addPhotoCellDidSelectItemAtIndexPath:(NSIndexPath *)indexPath isAdd:(BOOL)isAdd;

@end


@interface IKAddPhotoTableViewCell : UITableViewCell

@property (nonatomic, copy)NSArray *dataArray;
@property (nonatomic, weak)id<IKAddPhotoTableViewCellDelegate> delegate;



@end
