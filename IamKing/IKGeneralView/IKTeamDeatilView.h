//
//  IKTeamDeatilView.h
//  IamKing
//
//  Created by Luris on 2017/8/9.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKTeamDeatilView : UIView

/**
 *  show alert
 *
 *  @param name              name
 *  @param message           message
 *  @param position          职位
 *
 
 */


- (instancetype)initWithName:(NSString *)name
                     message:(NSString *)message
                    position:(NSString *)position;

- (void)show;

@end
