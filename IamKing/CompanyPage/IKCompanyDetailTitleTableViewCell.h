//
//  IKCompanyDetailTitleTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/8/1.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, IKCompanyDetailTitleType) {
    IKCompanyDetailTitleTypeProgress = 0,
    IKCompanyDetailTitleTypeLocation,
};


@interface IKCompanyDetailTitleTableViewCell : UITableViewCell

@property(nonatomic, assign)IKCompanyDetailTitleType titleType;


@end


