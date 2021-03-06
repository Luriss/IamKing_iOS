//
//  IKJobTypeDetailVC.h
//  IamKing
//
//  Created by Luris on 2017/7/17.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKViewController.h"

@protocol IKJobTypeDetailVCDelegate <NSObject>

- (void)dismissViewController;

@end



@interface IKJobTypeDetailVC : IKViewController

@property(nonatomic,strong,nullable)NSArray *childJobTypeData;

@property (nonatomic, weak, nullable) id<IKJobTypeDetailVCDelegate> delegate;
@property (nonatomic,strong,nullable) NSMutableArray *silderData;//传入的标签数组 字符串数组

@end
