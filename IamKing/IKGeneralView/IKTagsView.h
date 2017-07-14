//
//  IKTagsView.h
//  IamKing
//
//  Created by Luris on 2017/7/13.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKView.h"



@protocol IKTagsViewDelegate <NSObject>

- (void)tagsCollectionViewDidSelectItemWithTitle:(nullable NSString *)title;

@end

@interface IKTagsView : IKView

@property (nonatomic,strong,nullable) NSArray *tagsData;//传入的标签数组 字符串数组
@property (nonatomic, weak, nullable) id<IKTagsViewDelegate> delegate;

- (void)reloadCollectionViewData;


@end
