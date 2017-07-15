//
//  IKJobTypeButton.h
//  IamKing
//
//  Created by Luris on 2017/7/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKView.h"

@protocol IKJobTypeButtonDelegate <NSObject>

- (void)jobTypeViewNewJobButtonClick:(UIButton *)button;
- (void)jobTypeViewHotJobButtonClick:(UIButton *)button;

@end

@interface IKJobTypeButton : IKView

@property (nonatomic, weak) id<IKJobTypeButtonDelegate> delegate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign)NSUInteger buttonIndex;
@property (nonatomic, strong)UIButton *selectedButton;


@end
