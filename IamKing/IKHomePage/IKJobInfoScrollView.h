//
//  IKJobInfoScrollView.h
//  IamKing
//
//  Created by Luris on 2017/7/15.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKScrollView.h"


@protocol IKJobInfoScrollViewDelegate <NSObject>

- (void)jobInfoScrollViewVerticalScroll;


@end




@interface IKJobInfoScrollView : IKView


@property(nonatomic,strong)UIScrollView *infoScrollView;

@property (nonatomic, weak) id<IKJobInfoScrollViewDelegate> delegate;

- (void)addSubViews;

@end
