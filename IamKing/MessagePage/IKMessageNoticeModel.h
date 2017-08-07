//
//  IKMessageNoticeModel.h
//  IamKing
//
//  Created by Luris on 2017/8/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKMessageNoticeModel : NSObject

@property(nonatomic,copy)NSString     *logoImage;
@property(nonatomic,copy)NSString     *notice;
@property(nonatomic,copy)NSString     *information;
@property(nonatomic,copy)NSString     *msgNumber;
@property(nonatomic,copy)NSString     *time;
@property(nonatomic,copy)NSString      *title;
//@property(nonatomic,copy)NSString     *informationDetail;
@end
