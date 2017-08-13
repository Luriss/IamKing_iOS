//
//  IKSettingView.h
//  IamKing
//
//  Created by Luris on 2017/8/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IKSettingViewDelegate <NSObject>

- (void)tableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

//- (void)settingViewRightArrowClick;

@end



@interface IKSettingView : UIView


@property (nonatomic, weak) id<IKSettingViewDelegate> delegate;
@property (nonatomic, strong)NSDictionary *dictionary;


@end
