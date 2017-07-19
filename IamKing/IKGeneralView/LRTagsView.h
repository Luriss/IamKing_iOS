//
//  LRTagsView.h
//  IamKing
//
//  Created by Luris on 2017/7/17.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LRTagsViewDelegate <NSObject>

- (void)tagsCollectionViewDidSelectItemWithTitle:(nullable NSString *)title;

@end


@interface LRTagsView : UIView

@property (nonatomic,strong,nullable) NSArray *tagsData;//传入的标签数组 字符串数组
@property (nonatomic, weak, nullable) id<LRTagsViewDelegate> delegate;
@property (nonatomic,copy,nullable)NSString *titleImageName;
@property (nonatomic,copy,nullable)NSString *title;
- (void)reloadCollectionViewData;


@end
