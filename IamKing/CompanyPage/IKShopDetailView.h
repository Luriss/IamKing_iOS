//
//  IKShopDetailView.h
//  IamKing
//
//  Created by Luris on 2017/8/9.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKCompanyShopNumModel.h"

@protocol IKShopDetailViewDelegate <NSObject>

- (void)showShopListWithShopID:(NSString *)shopId companyID:(NSString *)companyID;


@end


@interface IKShopDetailView : UIView

- (instancetype)initWithShopDetailModel:(IKCompanyShopNumModel *)model;

@property (nonatomic, weak) id<IKShopDetailViewDelegate> delegate;

- (void)show;

@end
