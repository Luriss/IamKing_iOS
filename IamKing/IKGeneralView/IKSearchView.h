//
//  IKSearchView.h
//  IamKing
//
//  Created by Luris on 2017/7/12.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKView.h"

/**
 适合本 App 使用的搜索框样式的 view.

 */

@protocol IKSearchViewDelegate <NSObject>

- (void)searchViewCloseButtonClick;
- (void)searchViewSearchButtonClick;

@end

@interface IKSearchView : IKView

@property (nonatomic, weak, nullable) id<IKSearchViewDelegate> delegate;

@end
