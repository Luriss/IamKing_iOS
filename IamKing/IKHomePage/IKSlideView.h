//
//  IKSlideView.h
//  IamKing
//
//  Created by Luris on 2017/7/7.
//  Copyright © 2017年 Luris. All rights reserved.
//


@class IKSlideView;

@protocol IKSlideViewDelegate <NSObject>

- (void)slideView:(IKSlideView *)slideView didSelectItemAtIndex:(NSUInteger )selectedIndex;

@end



@interface IKSlideView : IKView


@property(nonatomic,strong)NSArray *data;
@property (nonatomic, weak) id<IKSlideViewDelegate> delegate;
@property (nonatomic, assign, readwrite) NSInteger currentIndex;


- (void)reloadData;

@end
