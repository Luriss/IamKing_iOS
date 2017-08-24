//
//  IKSchoolListModel.h
//  IamKing
//
//  Created by Luris on 2017/8/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKSchoolListModel : NSObject

@property(nonatomic,copy)NSString     *Id;
@property(nonatomic,copy)NSString     *logoImageUrl;
@property(nonatomic,copy)NSString     *name;
@property(nonatomic,copy)NSString     *type;

- (NSString *)description;

@end
