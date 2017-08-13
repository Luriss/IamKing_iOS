//
//  IKTabBarController.h
//  IamKing
//
//  Created by Luris on 2017/7/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKTabBar.h"
#import "LRTabBar.h"

extern NSString *const kIKGetHomePageVcData;
extern NSString *const kIKGetCompanyPageVcData;
extern NSString *const kIKGetMessagePageVcData;
extern NSString *const kIKGetMinePageVcData;


@interface IKTabBarController : UITabBarController

@property(nonatomic,strong)LRTabBar *customTabBar;
@property(nonatomic,strong)UIView *tabBarTopLine;

//- (void)tabBarControllerDidSelectedIndex:(NSInteger )index;

@end
