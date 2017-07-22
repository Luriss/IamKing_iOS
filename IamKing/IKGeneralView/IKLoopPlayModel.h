//
//  IKLoopPlayModel.h
//  IamKing
//
//  Created by Luris on 2017/7/21.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKLoopPlayModel : NSObject

@property(nonatomic,copy)NSString     *imageUrl;        // 图片 Url
@property(nonatomic,copy)NSString     *imageID;         // 图片 ID
@property(nonatomic,assign)NSInteger  errorType;        // 失败错误类型 0 代表成功
@property(nonatomic,copy)NSString     *errorMessage;    // 错误信息

- (NSString *)description;

@end
