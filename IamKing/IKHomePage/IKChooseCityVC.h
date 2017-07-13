//
//  IKChooseCityVC.h
//  IamKing
//
//  Created by Luris on 2017/7/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKViewController.h"

@protocol IKChooseCityViewControllerDelegate <NSObject>

- (void)locationVcDismissChangeNavButtonTitle:(NSString *)title;

@end


@interface IKChooseCityVC : IKViewController

@property (nonatomic, weak) id<IKChooseCityViewControllerDelegate> delegate;
@property (nonatomic,copy)NSArray *provinceData;
@property (nonatomic,copy)NSArray *cityData;


// dismiss self.
- (void)dismissSelf:(void(^)(NSString *location))block;

@end
