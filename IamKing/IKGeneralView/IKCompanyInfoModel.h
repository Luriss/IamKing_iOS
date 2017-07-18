//
//  IKCompanyInfoModel.h
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKCompanyInfoModel : NSObject

@property(nonatomic,copy)NSString     *logoImageUrl;    // 图片
@property(nonatomic,copy)NSString     *title;           // 标题
@property(nonatomic,assign)NSInteger  evaluate;        // 评价
@property(nonatomic,copy)NSString     *address;         // 地址
@property(nonatomic,copy)NSString     *setupTime;       // 成立时间
@property(nonatomic,copy)NSString     *numberOfStore;   // 店面数量
@property(nonatomic,copy)NSString     *introduce;       // 介绍
@property(nonatomic,copy)NSString     *numberOfJob;     // 在招职位


@end
