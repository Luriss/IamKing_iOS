//
//  IKTypeDetailView.h
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKView.h"



@protocol IKTypeDetailViewDelegate <NSObject>

- (void)typeDetailViewDidSelectItemWithTitle:(nullable NSString *)title;

@end

@interface IKTypeDetailView : IKView


@property (nonatomic, weak, nullable) id<IKTypeDetailViewDelegate> delegate;
@property (nonatomic, strong, nullable) NSArray *detailData;


- (void)typeDetailViewReloadData;


@end
