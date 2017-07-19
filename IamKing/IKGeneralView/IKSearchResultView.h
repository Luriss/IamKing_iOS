//
//  IKSearchResultView.h
//  IamKing
//
//  Created by Luris on 2017/7/18.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKJobInfoModel.h"
#import "IKCompanyInfoModel.h"

#import "IKSelectView.h"



@interface IKSearchResultView : UIView
@property (nonatomic,strong)IKJobInfoModel *jobModel;
@property (nonatomic,strong)IKCompanyInfoModel *companyModel;

- (void)reloadData;
- (void)resetOldSelectedView:(UIView *)newView;

@end
