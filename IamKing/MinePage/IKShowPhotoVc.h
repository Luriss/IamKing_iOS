//
//  IKShowPhotoVc.h
//  IamKing
//
//  Created by Luris on 2017/8/25.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKViewController.h"


@protocol IKShowPhotoVcDelegate <NSObject>

- (void)deletePhotoAtIndex:(NSInteger )index;

@end

@interface IKShowPhotoVc : IKViewController

@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic,copy)NSArray  *imageArray;
@property (nonatomic, weak) id<IKShowPhotoVcDelegate> delegate;

@end
