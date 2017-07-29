//
//  IKHomePageVC.h
//  IamKing
//
//  Created by Luris on 2017/7/6.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKViewController.h"
#import "IKTabBarController.h"


@protocol IKHomePageViewControllerDelegate <NSObject>

- (void)locationVcDismissChangeNavButtonTitle:(NSString *)title;

@end



@interface IKHomePageVC : IKViewController


@property (nonatomic, weak) id<IKHomePageViewControllerDelegate> delegate;



@end
