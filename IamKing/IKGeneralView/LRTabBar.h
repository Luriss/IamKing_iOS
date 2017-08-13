//
//  LRTabBar.h
//  IamKing
//
//  Created by Luris on 2017/8/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LRTabBar;
@protocol LRTabBarDelegate <NSObject>

@optional
- (void)tabBar:(LRTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag;

@end


@interface LRTabBar : UIView

@property(nonatomic, weak)id <LRTabBarDelegate>delegate;

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem;
- (void)addTabBarButtonWithTitle:(NSString *)title
                           image:(UIImage *)image
                   selectedImage:(UIImage *)selectedImage;


- (void)changeButtonTitle:(NSString *)newTitle
                    image:(UIImage *)newImage
            selectedImage:(UIImage *)newSelectedImage;
@end
