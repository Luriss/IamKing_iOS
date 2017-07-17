//
//  IKSearchVC.h
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKViewController.h"


@protocol IKSearchViewControllerDelegate <NSObject>

- (void)searchViewControllerDismiss;

@end

@interface IKSearchVC : IKViewController

@property (nonatomic, weak) id<IKSearchViewControllerDelegate> delegate;


@end
