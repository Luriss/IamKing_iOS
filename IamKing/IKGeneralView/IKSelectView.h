//
//  IKSelectView.h
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKView.h"

@protocol IKSelectViewDelegate <NSObject>

- (void)selectViewDidSelect:(NSString *)select;

@end

@interface IKSelectView : IKView

@property (nonatomic, weak) id<IKSelectViewDelegate> delegate;
@property (nonatomic,copy)NSArray *selectData;


@end
