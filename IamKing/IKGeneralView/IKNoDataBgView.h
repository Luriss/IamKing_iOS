//
//  IKNoDataBgView.h
//  IamKing
//
//  Created by Luris on 2017/7/25.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKView.h"


typedef NS_ENUM(NSInteger, IKNoDataBgViewType) {
    IKNoDataBgViewTypeCell = 0,                     /** cell类型 */
    IKNoDataBgViewTypeDetail,                       /** 详情类型 */
};




@interface IKNoDataBgView : IKView


@property (nonatomic,assign)IKNoDataBgViewType viewType;




@end
