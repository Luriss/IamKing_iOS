//
//  IKChooseCityVC.h
//  IamKing
//
//  Created by Luris on 2017/7/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKViewController.h"

typedef void(^LocationBlock)(NSString *location);

@interface IKChooseCityVC : IKViewController

@property (nonatomic,copy)LocationBlock locationBlock;


// dismiss self.
- (void)dismissSelf;

@end
