//
//  IKCompanyListView.h
//  IamKing
//
//  Created by Luris on 2017/8/24.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKView.h"
#import "IKSchoolListModel.h"

@protocol IKCompanyListViewDelegate <NSObject>

- (void)companyListViewdidSelectData:(IKSchoolListModel *)model;

@end

@interface IKCompanyListView : IKView


@property(nonatomic, copy)NSArray  *headerTitle;
@property(nonatomic, copy)NSArray  *dataSource;
@property (nonatomic, weak)id<IKCompanyListViewDelegate> delegate;



@end
