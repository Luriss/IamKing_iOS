//
//  IKAppraiseView.h
//  IamKing
//
//  Created by Luris on 2017/8/2.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IKAppraiseViewDelegate <NSObject>

- (void)appraiseViewSelectedData:(NSArray *)array;

@end


@interface IKAppraiseView : UIView

- (void)show;
@property(nonatomic,weak)id <IKAppraiseViewDelegate> delegate;

@end
