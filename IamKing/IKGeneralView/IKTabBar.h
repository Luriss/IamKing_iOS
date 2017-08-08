//
//  IKTabBar.h
//  IamKing
//
//  Created by Luris on 2017/7/28.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kIKTabBarItemTitle; 
extern NSString *const kIKTabBarItemNormalImageName;  
extern NSString *const kIKLTabBarItemSelectedImageName; 

@interface IKTabBar : UIView

@property (nonatomic, assign) NSInteger defaultSelected;
@property (nonatomic, copy) NSArray<NSDictionary *> *tabBarItemAttributes;


- (void)selectedDefaultItem:(NSInteger )index;

@end
