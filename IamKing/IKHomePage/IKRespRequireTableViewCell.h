//
//  IKRespRequireTableViewCell.h
//  IamKing
//
//  Created by Luris on 2017/7/26.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, IKRespRequireType) {
    IKRespRequireTypeResp = 0,
    IKRespRequireTypeRequire,
};

@interface IKRespRequireTableViewCell : UITableViewCell

@property(nonatomic, assign)IKRespRequireType type;

@property(nonatomic, copy)NSString *content;



@end
