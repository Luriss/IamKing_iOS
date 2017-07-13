//
//  IKSearchView.h
//  IamKing
//
//  Created by Luris on 2017/7/12.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKView.h"

@protocol IKSearchViewDelegate <NSObject>

- (void)searchViewCloseButtonClick;

@end

@interface IKSearchView : IKView

@property (nonatomic, weak, nullable) id<IKSearchViewDelegate> delegate;








@end
