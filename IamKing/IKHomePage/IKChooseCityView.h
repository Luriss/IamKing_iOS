//
//  IKChooseCityView.h
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKView.h"

@protocol IKChooseCityViewDelegate <NSObject>

- (void)chooseCityViewSelectedCity:(NSString *)city;

@end

@interface IKChooseCityView : IKView

@property (nonatomic, weak) id<IKChooseCityViewDelegate> delegate;
@property (nonatomic,copy)NSArray *provinceData;
@property (nonatomic,copy)NSArray *cityData;
@end
