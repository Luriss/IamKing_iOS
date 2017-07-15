//
//  IKJobTypeView.h
//  IamKing
//
//  Created by Luris on 2017/7/14.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKView.h"


@protocol IKJobTypeViewDelegate <NSObject>

- (void)jobTypeViewNewJobButtonClick:(UIButton *)button;
- (void)jobTypeViewHotJobButtonClick:(UIButton *)button;

@end



@interface IKJobTypeView : IKView

@property (nonatomic, weak) id<IKJobTypeViewDelegate> delegate;


@end
