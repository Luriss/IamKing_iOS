//
//  IKBlackListModel.h
//  IamKing
//
//  Created by Luris on 2017/8/14.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKBlackListModel : NSObject

@property(nonatomic,copy)NSString     *Id;
@property(nonatomic,copy)NSString     *headerImageUrl;
@property(nonatomic,copy)NSString     *headerImageName;
@property(nonatomic,copy)NSString     *nickName;

- (NSString *)description;

@end
